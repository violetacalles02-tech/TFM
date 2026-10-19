{{ config(materialized='table') }}

-- Dose era
--- A Dose Era is defined as a span of time when the Person is assumed to be 
--- exposed to a constant dose of a specific active ingredient.
--- Dose Eras will be derived from records in the DRUG_EXPOSURE table and the 
--- Dose information from the DRUG_STRENGTH table using a standardized algorithm. 
--- Dose Form information is not taken into account. So, if the patient changes 
--- between different formulations, or different manufacturers with the same 
--- formulation, the Dose Era is still spanning the entire time of exposure to the Ingredient.
---
--- Implementation logic:
--- 1. Consecutive or overlapping exposures to the same ingredient at the same daily dose are consolidated
--- 2. Any gap between exposures starts a new dose era (no persistence window)
--- 3. Dose eras span from the earliest start date to the latest end date within each continuous period

WITH ingredient_exposure AS (
    -- Get the ingredient level with normalized exposure end dates
    -- excluding unmapped drugs (concept_id = 0) and negative days_supply values
    SELECT
        d.drug_exposure_id,
        d.person_id,
        d.drug_concept_id,
        c.concept_id AS ingredient_concept_id,
        d.drug_exposure_start_date AS drug_exposure_start_date,
        -- Normalize DRUG_EXPOSURE_END_DATE
        coalesce(
            --- THEMIS Convention for end date normalization + default
            -- Use the recorded end date when present
            d.drug_exposure_end_date,
            -- If days_supply is available, use start_date + days_supply - 1 day
            case when d.days_supply is not null and d.days_supply > 0 
                then d.drug_exposure_start_date + (d.days_supply - 1) * interval '1 day' 
                else null end,
            -- For quantity-based calculation (solid, indivisible drug products) <-- not implemented
            -- Administration record: end date = start date
            case when d.drug_type_concept_id in (32818) -- administration concepts
                then d.drug_exposure_start_date
                else null end,
            -- Written prescription: start date + 29 days
            case when d.drug_type_concept_id in (32838, 32830) -- written prescription concepts
                then d.drug_exposure_start_date + 29 * interval '1 day'
                else null end,
            -- Mail-order prescription: start date + 89 days  
            case when d.drug_type_concept_id in (32857) -- mail-order prescription concepts
                then d.drug_exposure_start_date + 89 * interval '1 day'
                else null end,
            -- Default fallback: start date + 1 day (not themis convention)
            d.drug_exposure_start_date + interval '1 day'
        ) AS drug_exposure_end_date,
        d.quantity AS quantity,
        d.days_supply AS days_supply
    FROM {{ ref('drug_exposure') }} d
    JOIN {{ source('vocabularies','concept_ancestor') }} ca ON ca.descendant_concept_id = d.drug_concept_id
    JOIN {{ source('vocabularies', 'concept') }} c ON ca.ancestor_concept_id = c.concept_id AND c.concept_class_id = 'Ingredient'
    WHERE d.drug_concept_id != 0 -- Exclude unmapped drugs
      AND coalesce(d.days_supply,0) >= 0 -- Exclude negative days_supply values
),
ingredient_dose AS (
    -- Calculate total dose per exposure using drug_strength
    -- using amount_value or numerator_value (https://ohdsi.github.io/CommonDataModel/drug_dose.html)
    SELECT 
        i.*,
        coalesce(
            CASE 
                WHEN i.quantity IS NOT NULL AND d.amount_value IS NOT NULL 
                THEN i.quantity * d.amount_value 
            END,
            CASE 
                WHEN i.quantity IS NOT NULL AND d.numerator_value IS NOT NULL 
                THEN i.quantity * d.numerator_value 
            END
        ) AS total_dose,
        coalesce(
            d.amount_unit_concept_id,
            d.numerator_unit_concept_id
        ) AS dose_unit_concept_id
    FROM ingredient_exposure i
    LEFT JOIN {{ source('vocabularies', 'drug_strength') }} d 
    ON i.drug_concept_id = d.drug_concept_id 
    AND i.ingredient_concept_id = d.ingredient_concept_id
),
daily_dose AS (
    -- Calculate daily dose
    SELECT
        *,
        (CASE 
            WHEN days_supply IS NOT NULL AND days_supply > 0 THEN {{ round('total_dose / days_supply', 6) }}
            ELSE NULL
        END) AS daily_dose
    FROM ingredient_dose
    WHERE total_dose IS NOT NULL
),
dose_exposures_ordered AS (
    -- Order exposures and get previous exposure end date
    SELECT
        *,
        lag(drug_exposure_end_date) OVER (
            PARTITION BY person_id, ingredient_concept_id, daily_dose, dose_unit_concept_id
            ORDER BY drug_exposure_start_date, drug_exposure_end_date, drug_exposure_id
        ) AS prev_exposure_end_date
    FROM daily_dose
),
dose_era_groups AS (
    -- Identify dose era boundaries using gap-based logic
    -- A new era starts when there's any gap from previous exposure
    SELECT
        *,
        sum(
            CASE 
                WHEN prev_exposure_end_date IS NULL 
                    OR drug_exposure_start_date > prev_exposure_end_date + interval '1 day'
                THEN 1 
                ELSE 0 
            END
        ) OVER (
            PARTITION BY person_id, ingredient_concept_id, daily_dose, dose_unit_concept_id
            ORDER BY drug_exposure_start_date
            ROWS UNBOUNDED PRECEDING
        ) AS dose_era_group
    FROM dose_exposures_ordered
),
consolidated_dose_eras AS (
    -- Consolidate overlapping/consecutive exposures into dose eras
    SELECT
        person_id,
        ingredient_concept_id,
        daily_dose,
        dose_unit_concept_id,
        dose_era_group,
        min(drug_exposure_start_date) AS dose_era_start_date,
        max(drug_exposure_end_date) AS dose_era_end_date,
        count(*) AS exposure_count
    FROM dose_era_groups
    GROUP BY person_id, ingredient_concept_id, daily_dose, dose_unit_concept_id, dose_era_group
)
-- Final aggregation to create dose_era records
SELECT
    row_number() OVER (ORDER BY person_id)::BIGINT AS dose_era_id,
    person_id::BIGINT AS person_id,
    ingredient_concept_id::INT AS drug_concept_id,
    dose_unit_concept_id::INT AS unit_concept_id,
    daily_dose::FLOAT AS dose_value,
    dose_era_start_date::DATE AS dose_era_start_date,
    dose_era_end_date::DATE AS dose_era_end_date
FROM consolidated_dose_eras
-- Only include eras with valid dose values
WHERE daily_dose IS NOT NULL 
  AND daily_dose > 0
  AND dose_era_start_date <= dose_era_end_date
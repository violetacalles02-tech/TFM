{{ config(materialized='table') }}

WITH pre_drug_target AS (
    -- Normalize end dates AND map drug_concept_id to ingredient_concept_id
    SELECT
        d.drug_exposure_id,
        d.person_id,
        c.concept_id AS ingredient_concept_id,
        d.drug_exposure_start_date AS drug_exposure_start_date,
        d.days_supply AS days_supply,
        -- Normalize DRUG_EXPOSURE_END_DATE to either the existing drug exposure end date, or add days supply, or add 1 day to the start date
        coalesce(
            -- Use the recorded end date when present
            d.drug_exposure_end_date,
            -- If days_supply != NULL or 0, return drug_exposure_start_date + days_supply, otherwise go to next case
            nullif(d.drug_exposure_start_date + coalesce(d.days_supply, 0) * interval '1 day', d.drug_exposure_start_date),
            -- Add 1 day to the drug_exposure_start_date since there is no end_date or INTERVAL for the days_supply
            d.drug_exposure_start_date + interval '1 day'
        ) AS drug_exposure_end_date
    FROM {{ ref('drug_exposure') }} d
    join {{ source('vocabularies','concept_ancestor') }} ca ON ca.descendant_concept_id = d.drug_concept_id
    join {{ source('vocabularies', 'concept') }} c ON ca.ancestor_concept_id = c.concept_id
    where c.vocabulary_id = 'RxNorm'
      AND c.concept_class_id = 'Ingredient'

      AND d.drug_concept_id != 0 -- Exclude unmapped drugs (i.e. unmapped drug_concept_id's are set to 0, so we don't want different drugs wrapped up in the same era)
      AND coalesce(d.days_supply,0) >= 0 -- Exclude negative days_supply values (data quality issue)
),

sub_exposure_end_dates AS (
    -- Build start/end event stream for persistence window
    -- A preliminary sorting that groups all of the overlapping exposures into one exposure so that we don't double-count non-gap-days
    SELECT
        person_id,
        ingredient_concept_id,
        event_date AS end_date
    FROM(
        SELECT 
            person_id,
            ingredient_concept_id,
            event_date,
            event_type,
            -- Pulls the current START down from the prior rows so that the NULLs
            -- from the END DATES will contain a value we can compare with
            max(start_ordinal) OVER (
                PARTITION BY person_id, ingredient_concept_id 
                ORDER BY event_date, event_type 
                ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
            ) AS start_ordinal,
            --  Re-numbers the inner UNION so all rows are numbered ordered by the event date
            row_number() OVER (
                PARTITION BY person_id, ingredient_concept_id 
                ORDER BY event_date, event_type
            ) AS overall_ord
        FROM(
            -- Start dates
            -- Select start dates assigning a row number to each
            SELECT
                person_id,
                ingredient_concept_id,
                drug_exposure_start_date AS event_date,
                -1 AS event_type,
                row_number() OVER (
                    PARTITION BY person_id, ingredient_concept_id
                    ORDER BY drug_exposure_start_date
                ) AS start_ordinal
            FROM pre_drug_target

            UNION ALL

            -- End dates
            SELECT
                person_id,
                ingredient_concept_id,
                drug_exposure_end_date AS event_date,
                1 AS event_type,
                NULL::integer AS start_ordinal
            FROM pre_drug_target
        ) rawdata
    ) e
    WHERE (2 * e.start_ordinal) - e.overall_ord = 0
),

drug_exposure_ends AS(
    SELECT
        dt.person_id,
        dt.ingredient_concept_id,
        dt.drug_exposure_start_date,
        min(e.end_date) AS drug_sub_exposure_end_date
    FROM pre_drug_target dt
    JOIN sub_exposure_end_dates e
    ON dt.person_id = e.person_id
    AND dt.ingredient_concept_id = e.ingredient_concept_id
    AND e.end_date >= dt.drug_exposure_start_date
    GROUP BY dt.drug_exposure_id, dt.person_id, dt.ingredient_concept_id, dt.drug_exposure_start_date
),
sub_exposures AS (
    SELECT 
        row_number() OVER (
            -- PARTITION BY person_id, drug_concept_id, drug_sub_exposure_end_date
            PARTITION BY person_id, ingredient_concept_id, drug_sub_exposure_end_date
            ORDER BY person_id
        ) AS row_number,
        person_id,
        ingredient_concept_id,
        min(drug_exposure_start_date) AS drug_sub_exposure_start_date,
        drug_sub_exposure_end_date,
        count(*) AS drug_exposure_count
    FROM drug_exposure_ends
    GROUP BY person_id, ingredient_concept_id, drug_sub_exposure_end_date
),
final_target AS (
    SELECT
        row_number, 
        person_id,
        -- drug_concept_id,
        ingredient_concept_id,
        drug_sub_exposure_start_date, 
        drug_sub_exposure_end_date, 
        drug_exposure_count,
        {{ datediff('drug_sub_exposure_start_date', 'drug_sub_exposure_end_date', 'day') }} AS days_exposed
    FROM sub_exposures
),
end_dates AS (
    SELECT
        person_id, 
        ingredient_concept_id,
        event_date - interval '30 day' AS end_date -- Unpad end date
    FROM(
    SELECT 
            person_id,
            ingredient_concept_id, 
            event_date, 
            event_type, 
            max(start_ordinal) OVER (
                PARTITION BY person_id, ingredient_concept_id 
                ORDER BY event_date, event_type 
                ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
            ) AS start_ordinal,
            row_number() OVER (
                PARTITION BY person_id, ingredient_concept_id 
                ORDER BY event_date, event_type
            ) AS overall_ord
        FROM(
            -- Start dates
            SELECT
                person_id,
                ingredient_concept_id,
                drug_sub_exposure_start_date AS event_date,
                -1 AS event_type,
                row_number() OVER (
                    PARTITION BY person_id, ingredient_concept_id
                    ORDER BY drug_sub_exposure_start_date
                ) AS start_ordinal
            FROM final_target
            UNION ALL
            -- End dates
            -- Pad the end dates by 30 to allow a grace period for overlapping ranges
            SELECT
                person_id,
                ingredient_concept_id,
                drug_sub_exposure_end_date + interval '30 day' AS event_date,
                1 AS event_type,
                NULL::integer AS start_ordinal
            FROM final_target
        ) rawdata
    ) e
    WHERE (2 * e.start_ordinal) - e.overall_ord = 0
),
drug_era_ends AS (
    -- Pair each exposure start with nearest era end
    SELECT
        ft.person_id,
        ft.ingredient_concept_id,
        ft.drug_sub_exposure_start_date,
        min(e.end_date) AS drug_era_end_date,
        drug_exposure_count,
        days_exposed
    FROM final_target ft
    JOIN end_dates e  
    ON ft.person_id = e.person_id 
    AND ft.ingredient_concept_id = e.ingredient_concept_id
    AND e.end_date >= ft.drug_sub_exposure_start_date
    GROUP BY ft.person_id, ft.ingredient_concept_id, ft.drug_sub_exposure_start_date, drug_exposure_count, days_exposed
)
-- Final aggregation to create drug_era records
SELECT
    row_number() OVER (ORDER BY person_id)::BIGINT AS drug_era_id,
    person_id::BIGINT AS person_id,
    --drug_concept_id,
    ingredient_concept_id::INT AS drug_concept_id,
    min(drug_sub_exposure_start_date)::DATE AS drug_era_start_date,
    drug_era_end_date::DATE AS drug_era_end_date,
    sum(drug_exposure_count)::INT AS drug_exposure_count,
    ({{ datediff('min(drug_sub_exposure_start_date)', 'drug_era_end_date', 'day') }} - sum(days_exposed))::INT AS gap_days
FROM drug_era_ends
-- GROUP BY person_id, drug_concept_id, drug_era_end_date
GROUP BY person_id, ingredient_concept_id, drug_era_end_date
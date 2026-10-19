{{ config(materialized='table') }}

WITH condition_target AS (
    -- Normalize condition_occurrence
    -- - If condition_end_date is NULL, set it to condition_start_date + 1 day
    SELECT
        person_id,
        condition_concept_id,
        condition_start_date,
        coalesce(
            condition_end_date,
            condition_start_date + interval '1 day'
        ) AS condition_end_date
    FROM {{ ref('condition_occurrence') }}
),
events AS (
    -- Generate start and end events for each condition occurrence
    -- -Start events
    SELECT
        person_id,
        condition_concept_id,
        condition_start_date AS event_date,
        -1 AS event_type
    FROM condition_target

    UNION ALL
    -- -End events (+30 days)
    SELECT
        person_id,
        condition_concept_id,
        condition_end_date + interval '30 day' AS event_date,
        1 AS event_type
    FROM condition_target
),
ordered_events AS (
    -- Order events chronologically
    SELECT
        *,
        row_number() over (
            partition by person_id, condition_concept_id
            order by event_date, event_type
        ) AS overall_ord
    FROM events
),
starts AS (
    -- Identify condition starts
    SELECT
        person_id,
        condition_concept_id,
        condition_start_date,
        row_number() over (
            partition by person_id, condition_concept_id
            order by condition_start_date
        ) AS start_ord
    FROM condition_target
),
end_dates AS (
    -- Calculate condition era end dates
    SELECT
        e.person_id,
        e.condition_concept_id,
        (e.event_date - interval '30 day')::date AS era_end_date
    FROM ordered_events e
    JOIN starts s
      ON e.person_id = s.person_id
     AND e.condition_concept_id = s.condition_concept_id
     AND s.condition_start_date <= e.event_date
    WHERE (2 * s.start_ord) - e.overall_ord = 0
),
condition_ends AS (
    -- Pair each condition start with the nearest valid era end date
    SELECT
        c.person_id,
        c.condition_concept_id,
        c.condition_start_date,
        min(e.era_end_date) AS era_end_date
    FROM condition_target c
    JOIN end_dates e
      ON c.person_id = e.person_id
     AND c.condition_concept_id = e.condition_concept_id
     AND e.era_end_date >= c.condition_start_date
    GROUP BY c.person_id, c.condition_concept_id, c.condition_start_date
)
-- Final aggregation to create condition_era records
-- -One row per person_id, condition_concept_id, and era_end_date
SELECT
    row_number() OVER (ORDER BY person_id)::BIGINT AS condition_era_id,
    person_id::BIGINT AS person_id,
    condition_concept_id::INT AS condition_concept_id,
    min(condition_start_date)::DATE AS condition_era_start_date,
    era_end_date::DATE AS condition_era_end_date,
    count(*)::INT AS condition_occurrence_count
FROM condition_ends
GROUP BY person_id, condition_concept_id, era_end_date
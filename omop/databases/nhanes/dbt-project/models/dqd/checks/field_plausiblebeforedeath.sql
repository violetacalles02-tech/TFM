

/*********
SQL to insert individual DQD results directly into output table, rather than waiting until collecting all results.
Note that this  does not include information about SQL errors or performance
**********/
WITH cte_all  AS (SELECT cte.num_violated_rows
  ,cte.pct_violated_rows
  ,cte.num_denominator_rows
  , CAST('' as TEXT) as execution_time
  ,'' as query_text
  ,'plausibleBeforeDeath' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a date value in the CONDITION_ERA_END_DATE field of the CONDITION_ERA table that occurs after death.' as check_description
  ,'CONDITION_ERA' as cdm_table_name
  ,'CONDITION_ERA_END_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_before_death.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausiblebeforedeath_condition_era_condition_era_end_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_BEFORE_DEATH
Checks for events that occur more than 60 days after death (PLAUSIBLE_BEFORE_DEATH == Yes).
Denominator is number of events with a non-null date, of persons who died.
Parameters used in this template:
schema = cdm
cdmDatabaseSchema = cdm
cdmTableName = CONDITION_ERA
cdmFieldName = CONDITION_ERA_END_DATE
**********/
SELECT 
    num_violated_rows, 
    CASE 
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM
(
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM
    (
        /*violatedRowsBegin*/
        SELECT 
            'CONDITION_ERA.CONDITION_ERA_END_DATE' AS violating_field, 
            cdmTable.*
        FROM {{ ref('condition_era') }} cdmTable
        JOIN {{ ref('death') }} de 
            ON cdmTable.person_id = de.person_id
        WHERE cdmTable.CONDITION_ERA_END_DATE IS NOT NULL 
            AND CAST(cdmTable.CONDITION_ERA_END_DATE AS DATE) > (de.death_date + 60*INTERVAL'1 day')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
(
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('condition_era') }} cdmTable
    JOIN {{ ref('death') }}
        ON death.person_id = cdmTable.person_id
    WHERE cdmTable.CONDITION_ERA_END_DATE IS NOT NULL
) denominator
) cte
 UNION ALL /*********
SQL to create query for insertion into results table. These may be unioned together prior to insert.
Note that this does not include information about SQL errors or performance.
**********/
SELECT 
  cte.num_violated_rows
  ,cte.pct_violated_rows
  ,cte.num_denominator_rows
  ,'' as execution_time
  ,'' as query_text
  ,'plausibleBeforeDeath' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a date value in the CONDITION_ERA_START_DATE field of the CONDITION_ERA table that occurs after death.' as check_description
  ,'CONDITION_ERA' as cdm_table_name
  ,'CONDITION_ERA_START_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_before_death.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausiblebeforedeath_condition_era_condition_era_start_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_BEFORE_DEATH
Checks for events that occur more than 60 days after death (PLAUSIBLE_BEFORE_DEATH == Yes).
Denominator is number of events with a non-null date, of persons who died.
Parameters used in this template:
schema = cdm
cdmDatabaseSchema = cdm
cdmTableName = CONDITION_ERA
cdmFieldName = CONDITION_ERA_START_DATE
**********/
SELECT 
    num_violated_rows, 
    CASE 
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM
(
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM
    (
        /*violatedRowsBegin*/
        SELECT 
            'CONDITION_ERA.CONDITION_ERA_START_DATE' AS violating_field, 
            cdmTable.*
        FROM {{ ref('condition_era') }} cdmTable
        JOIN {{ ref('death') }} de 
            ON cdmTable.person_id = de.person_id
        WHERE cdmTable.CONDITION_ERA_START_DATE IS NOT NULL 
            AND CAST(cdmTable.CONDITION_ERA_START_DATE AS DATE) > (de.death_date + 60*INTERVAL'1 day')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
(
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('condition_era') }} cdmTable
    JOIN {{ ref('death') }}
        ON death.person_id = cdmTable.person_id
    WHERE cdmTable.CONDITION_ERA_START_DATE IS NOT NULL
) denominator
) cte
 UNION ALL /*********
SQL to create query for insertion into results table. These may be unioned together prior to insert.
Note that this does not include information about SQL errors or performance.
**********/
SELECT 
  cte.num_violated_rows
  ,cte.pct_violated_rows
  ,cte.num_denominator_rows
  ,'' as execution_time
  ,'' as query_text
  ,'plausibleBeforeDeath' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a date value in the CONDITION_END_DATE field of the CONDITION_OCCURRENCE table that occurs after death.' as check_description
  ,'CONDITION_OCCURRENCE' as cdm_table_name
  ,'CONDITION_END_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_before_death.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausiblebeforedeath_condition_occurrence_condition_end_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_BEFORE_DEATH
Checks for events that occur more than 60 days after death (PLAUSIBLE_BEFORE_DEATH == Yes).
Denominator is number of events with a non-null date, of persons who died.
Parameters used in this template:
schema = cdm
cdmDatabaseSchema = cdm
cdmTableName = CONDITION_OCCURRENCE
cdmFieldName = CONDITION_END_DATE
**********/
SELECT 
    num_violated_rows, 
    CASE 
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM
(
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM
    (
        /*violatedRowsBegin*/
        SELECT 
            'CONDITION_OCCURRENCE.CONDITION_END_DATE' AS violating_field, 
            cdmTable.*
        FROM {{ ref('condition_occurrence') }} cdmTable
        JOIN {{ ref('death') }} de 
            ON cdmTable.person_id = de.person_id
        WHERE cdmTable.CONDITION_END_DATE IS NOT NULL 
            AND CAST(cdmTable.CONDITION_END_DATE AS DATE) > (de.death_date + 60*INTERVAL'1 day')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
(
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('condition_occurrence') }} cdmTable
    JOIN {{ ref('death') }}
        ON death.person_id = cdmTable.person_id
    WHERE cdmTable.CONDITION_END_DATE IS NOT NULL
) denominator
) cte
 UNION ALL /*********
SQL to create query for insertion into results table. These may be unioned together prior to insert.
Note that this does not include information about SQL errors or performance.
**********/
SELECT 
  cte.num_violated_rows
  ,cte.pct_violated_rows
  ,cte.num_denominator_rows
  ,'' as execution_time
  ,'' as query_text
  ,'plausibleBeforeDeath' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a date value in the CONDITION_END_DATETIME field of the CONDITION_OCCURRENCE table that occurs after death.' as check_description
  ,'CONDITION_OCCURRENCE' as cdm_table_name
  ,'CONDITION_END_DATETIME' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_before_death.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausiblebeforedeath_condition_occurrence_condition_end_datetime' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_BEFORE_DEATH
Checks for events that occur more than 60 days after death (PLAUSIBLE_BEFORE_DEATH == Yes).
Denominator is number of events with a non-null date, of persons who died.
Parameters used in this template:
schema = cdm
cdmDatabaseSchema = cdm
cdmTableName = CONDITION_OCCURRENCE
cdmFieldName = CONDITION_END_DATETIME
**********/
SELECT 
    num_violated_rows, 
    CASE 
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM
(
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM
    (
        /*violatedRowsBegin*/
        SELECT 
            'CONDITION_OCCURRENCE.CONDITION_END_DATETIME' AS violating_field, 
            cdmTable.*
        FROM {{ ref('condition_occurrence') }} cdmTable
        JOIN {{ ref('death') }} de 
            ON cdmTable.person_id = de.person_id
        WHERE cdmTable.CONDITION_END_DATETIME IS NOT NULL 
            AND CAST(cdmTable.CONDITION_END_DATETIME AS DATE) > (de.death_date + 60*INTERVAL'1 day')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
(
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('condition_occurrence') }} cdmTable
    JOIN {{ ref('death') }}
        ON death.person_id = cdmTable.person_id
    WHERE cdmTable.CONDITION_END_DATETIME IS NOT NULL
) denominator
) cte
 UNION ALL /*********
SQL to create query for insertion into results table. These may be unioned together prior to insert.
Note that this does not include information about SQL errors or performance.
**********/
SELECT 
  cte.num_violated_rows
  ,cte.pct_violated_rows
  ,cte.num_denominator_rows
  ,'' as execution_time
  ,'' as query_text
  ,'plausibleBeforeDeath' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a date value in the CONDITION_START_DATE field of the CONDITION_OCCURRENCE table that occurs after death.' as check_description
  ,'CONDITION_OCCURRENCE' as cdm_table_name
  ,'CONDITION_START_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_before_death.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausiblebeforedeath_condition_occurrence_condition_start_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_BEFORE_DEATH
Checks for events that occur more than 60 days after death (PLAUSIBLE_BEFORE_DEATH == Yes).
Denominator is number of events with a non-null date, of persons who died.
Parameters used in this template:
schema = cdm
cdmDatabaseSchema = cdm
cdmTableName = CONDITION_OCCURRENCE
cdmFieldName = CONDITION_START_DATE
**********/
SELECT 
    num_violated_rows, 
    CASE 
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM
(
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM
    (
        /*violatedRowsBegin*/
        SELECT 
            'CONDITION_OCCURRENCE.CONDITION_START_DATE' AS violating_field, 
            cdmTable.*
        FROM {{ ref('condition_occurrence') }} cdmTable
        JOIN {{ ref('death') }} de 
            ON cdmTable.person_id = de.person_id
        WHERE cdmTable.CONDITION_START_DATE IS NOT NULL 
            AND CAST(cdmTable.CONDITION_START_DATE AS DATE) > (de.death_date + 60*INTERVAL'1 day')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
(
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('condition_occurrence') }} cdmTable
    JOIN {{ ref('death') }}
        ON death.person_id = cdmTable.person_id
    WHERE cdmTable.CONDITION_START_DATE IS NOT NULL
) denominator
) cte
 UNION ALL /*********
SQL to create query for insertion into results table. These may be unioned together prior to insert.
Note that this does not include information about SQL errors or performance.
**********/
SELECT 
  cte.num_violated_rows
  ,cte.pct_violated_rows
  ,cte.num_denominator_rows
  ,'' as execution_time
  ,'' as query_text
  ,'plausibleBeforeDeath' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a date value in the CONDITION_START_DATETIME field of the CONDITION_OCCURRENCE table that occurs after death.' as check_description
  ,'CONDITION_OCCURRENCE' as cdm_table_name
  ,'CONDITION_START_DATETIME' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_before_death.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausiblebeforedeath_condition_occurrence_condition_start_datetime' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_BEFORE_DEATH
Checks for events that occur more than 60 days after death (PLAUSIBLE_BEFORE_DEATH == Yes).
Denominator is number of events with a non-null date, of persons who died.
Parameters used in this template:
schema = cdm
cdmDatabaseSchema = cdm
cdmTableName = CONDITION_OCCURRENCE
cdmFieldName = CONDITION_START_DATETIME
**********/
SELECT 
    num_violated_rows, 
    CASE 
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM
(
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM
    (
        /*violatedRowsBegin*/
        SELECT 
            'CONDITION_OCCURRENCE.CONDITION_START_DATETIME' AS violating_field, 
            cdmTable.*
        FROM {{ ref('condition_occurrence') }} cdmTable
        JOIN {{ ref('death') }} de 
            ON cdmTable.person_id = de.person_id
        WHERE cdmTable.CONDITION_START_DATETIME IS NOT NULL 
            AND CAST(cdmTable.CONDITION_START_DATETIME AS DATE) > (de.death_date + 60*INTERVAL'1 day')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
(
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('condition_occurrence') }} cdmTable
    JOIN {{ ref('death') }}
        ON death.person_id = cdmTable.person_id
    WHERE cdmTable.CONDITION_START_DATETIME IS NOT NULL
) denominator
) cte
 UNION ALL /*********
SQL to create query for insertion into results table. These may be unioned together prior to insert.
Note that this does not include information about SQL errors or performance.
**********/
SELECT 
  cte.num_violated_rows
  ,cte.pct_violated_rows
  ,cte.num_denominator_rows
  ,'' as execution_time
  ,'' as query_text
  ,'plausibleBeforeDeath' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a date value in the DEVICE_EXPOSURE_END_DATE field of the DEVICE_EXPOSURE table that occurs after death.' as check_description
  ,'DEVICE_EXPOSURE' as cdm_table_name
  ,'DEVICE_EXPOSURE_END_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_before_death.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausiblebeforedeath_device_exposure_device_exposure_end_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_BEFORE_DEATH
Checks for events that occur more than 60 days after death (PLAUSIBLE_BEFORE_DEATH == Yes).
Denominator is number of events with a non-null date, of persons who died.
Parameters used in this template:
schema = cdm
cdmDatabaseSchema = cdm
cdmTableName = DEVICE_EXPOSURE
cdmFieldName = DEVICE_EXPOSURE_END_DATE
**********/
SELECT 
    num_violated_rows, 
    CASE 
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM
(
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM
    (
        /*violatedRowsBegin*/
        SELECT 
            'DEVICE_EXPOSURE.DEVICE_EXPOSURE_END_DATE' AS violating_field, 
            cdmTable.*
        FROM {{ ref('device_exposure') }} cdmTable
        JOIN {{ ref('death') }} de 
            ON cdmTable.person_id = de.person_id
        WHERE cdmTable.DEVICE_EXPOSURE_END_DATE IS NOT NULL 
            AND CAST(cdmTable.DEVICE_EXPOSURE_END_DATE AS DATE) > (de.death_date + 60*INTERVAL'1 day')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
(
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('device_exposure') }} cdmTable
    JOIN {{ ref('death') }}
        ON death.person_id = cdmTable.person_id
    WHERE cdmTable.DEVICE_EXPOSURE_END_DATE IS NOT NULL
) denominator
) cte
 UNION ALL /*********
SQL to create query for insertion into results table. These may be unioned together prior to insert.
Note that this does not include information about SQL errors or performance.
**********/
SELECT 
  cte.num_violated_rows
  ,cte.pct_violated_rows
  ,cte.num_denominator_rows
  ,'' as execution_time
  ,'' as query_text
  ,'plausibleBeforeDeath' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a date value in the DEVICE_EXPOSURE_END_DATETIME field of the DEVICE_EXPOSURE table that occurs after death.' as check_description
  ,'DEVICE_EXPOSURE' as cdm_table_name
  ,'DEVICE_EXPOSURE_END_DATETIME' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_before_death.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausiblebeforedeath_device_exposure_device_exposure_end_datetime' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_BEFORE_DEATH
Checks for events that occur more than 60 days after death (PLAUSIBLE_BEFORE_DEATH == Yes).
Denominator is number of events with a non-null date, of persons who died.
Parameters used in this template:
schema = cdm
cdmDatabaseSchema = cdm
cdmTableName = DEVICE_EXPOSURE
cdmFieldName = DEVICE_EXPOSURE_END_DATETIME
**********/
SELECT 
    num_violated_rows, 
    CASE 
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM
(
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM
    (
        /*violatedRowsBegin*/
        SELECT 
            'DEVICE_EXPOSURE.DEVICE_EXPOSURE_END_DATETIME' AS violating_field, 
            cdmTable.*
        FROM {{ ref('device_exposure') }} cdmTable
        JOIN {{ ref('death') }} de 
            ON cdmTable.person_id = de.person_id
        WHERE cdmTable.DEVICE_EXPOSURE_END_DATETIME IS NOT NULL 
            AND CAST(cdmTable.DEVICE_EXPOSURE_END_DATETIME AS DATE) > (de.death_date + 60*INTERVAL'1 day')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
(
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('device_exposure') }} cdmTable
    JOIN {{ ref('death') }}
        ON death.person_id = cdmTable.person_id
    WHERE cdmTable.DEVICE_EXPOSURE_END_DATETIME IS NOT NULL
) denominator
) cte
 UNION ALL /*********
SQL to create query for insertion into results table. These may be unioned together prior to insert.
Note that this does not include information about SQL errors or performance.
**********/
SELECT 
  cte.num_violated_rows
  ,cte.pct_violated_rows
  ,cte.num_denominator_rows
  ,'' as execution_time
  ,'' as query_text
  ,'plausibleBeforeDeath' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a date value in the DEVICE_EXPOSURE_START_DATE field of the DEVICE_EXPOSURE table that occurs after death.' as check_description
  ,'DEVICE_EXPOSURE' as cdm_table_name
  ,'DEVICE_EXPOSURE_START_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_before_death.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausiblebeforedeath_device_exposure_device_exposure_start_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_BEFORE_DEATH
Checks for events that occur more than 60 days after death (PLAUSIBLE_BEFORE_DEATH == Yes).
Denominator is number of events with a non-null date, of persons who died.
Parameters used in this template:
schema = cdm
cdmDatabaseSchema = cdm
cdmTableName = DEVICE_EXPOSURE
cdmFieldName = DEVICE_EXPOSURE_START_DATE
**********/
SELECT 
    num_violated_rows, 
    CASE 
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM
(
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM
    (
        /*violatedRowsBegin*/
        SELECT 
            'DEVICE_EXPOSURE.DEVICE_EXPOSURE_START_DATE' AS violating_field, 
            cdmTable.*
        FROM {{ ref('device_exposure') }} cdmTable
        JOIN {{ ref('death') }} de 
            ON cdmTable.person_id = de.person_id
        WHERE cdmTable.DEVICE_EXPOSURE_START_DATE IS NOT NULL 
            AND CAST(cdmTable.DEVICE_EXPOSURE_START_DATE AS DATE) > (de.death_date + 60*INTERVAL'1 day')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
(
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('device_exposure') }} cdmTable
    JOIN {{ ref('death') }}
        ON death.person_id = cdmTable.person_id
    WHERE cdmTable.DEVICE_EXPOSURE_START_DATE IS NOT NULL
) denominator
) cte
 UNION ALL /*********
SQL to create query for insertion into results table. These may be unioned together prior to insert.
Note that this does not include information about SQL errors or performance.
**********/
SELECT 
  cte.num_violated_rows
  ,cte.pct_violated_rows
  ,cte.num_denominator_rows
  ,'' as execution_time
  ,'' as query_text
  ,'plausibleBeforeDeath' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a date value in the DEVICE_EXPOSURE_START_DATETIME field of the DEVICE_EXPOSURE table that occurs after death.' as check_description
  ,'DEVICE_EXPOSURE' as cdm_table_name
  ,'DEVICE_EXPOSURE_START_DATETIME' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_before_death.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausiblebeforedeath_device_exposure_device_exposure_start_datetime' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_BEFORE_DEATH
Checks for events that occur more than 60 days after death (PLAUSIBLE_BEFORE_DEATH == Yes).
Denominator is number of events with a non-null date, of persons who died.
Parameters used in this template:
schema = cdm
cdmDatabaseSchema = cdm
cdmTableName = DEVICE_EXPOSURE
cdmFieldName = DEVICE_EXPOSURE_START_DATETIME
**********/
SELECT 
    num_violated_rows, 
    CASE 
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM
(
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM
    (
        /*violatedRowsBegin*/
        SELECT 
            'DEVICE_EXPOSURE.DEVICE_EXPOSURE_START_DATETIME' AS violating_field, 
            cdmTable.*
        FROM {{ ref('device_exposure') }} cdmTable
        JOIN {{ ref('death') }} de 
            ON cdmTable.person_id = de.person_id
        WHERE cdmTable.DEVICE_EXPOSURE_START_DATETIME IS NOT NULL 
            AND CAST(cdmTable.DEVICE_EXPOSURE_START_DATETIME AS DATE) > (de.death_date + 60*INTERVAL'1 day')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
(
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('device_exposure') }} cdmTable
    JOIN {{ ref('death') }}
        ON death.person_id = cdmTable.person_id
    WHERE cdmTable.DEVICE_EXPOSURE_START_DATETIME IS NOT NULL
) denominator
) cte
 UNION ALL /*********
SQL to create query for insertion into results table. These may be unioned together prior to insert.
Note that this does not include information about SQL errors or performance.
**********/
SELECT 
  cte.num_violated_rows
  ,cte.pct_violated_rows
  ,cte.num_denominator_rows
  ,'' as execution_time
  ,'' as query_text
  ,'plausibleBeforeDeath' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a date value in the DOSE_ERA_END_DATE field of the DOSE_ERA table that occurs after death.' as check_description
  ,'DOSE_ERA' as cdm_table_name
  ,'DOSE_ERA_END_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_before_death.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausiblebeforedeath_dose_era_dose_era_end_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_BEFORE_DEATH
Checks for events that occur more than 60 days after death (PLAUSIBLE_BEFORE_DEATH == Yes).
Denominator is number of events with a non-null date, of persons who died.
Parameters used in this template:
schema = cdm
cdmDatabaseSchema = cdm
cdmTableName = DOSE_ERA
cdmFieldName = DOSE_ERA_END_DATE
**********/
SELECT 
    num_violated_rows, 
    CASE 
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM
(
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM
    (
        /*violatedRowsBegin*/
        SELECT 
            'DOSE_ERA.DOSE_ERA_END_DATE' AS violating_field, 
            cdmTable.*
        FROM {{ ref('dose_era') }} cdmTable
        JOIN {{ ref('death') }} de 
            ON cdmTable.person_id = de.person_id
        WHERE cdmTable.DOSE_ERA_END_DATE IS NOT NULL 
            AND CAST(cdmTable.DOSE_ERA_END_DATE AS DATE) > (de.death_date + 60*INTERVAL'1 day')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
(
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('dose_era') }} cdmTable
    JOIN {{ ref('death') }}
        ON death.person_id = cdmTable.person_id
    WHERE cdmTable.DOSE_ERA_END_DATE IS NOT NULL
) denominator
) cte
 UNION ALL /*********
SQL to create query for insertion into results table. These may be unioned together prior to insert.
Note that this does not include information about SQL errors or performance.
**********/
SELECT 
  cte.num_violated_rows
  ,cte.pct_violated_rows
  ,cte.num_denominator_rows
  ,'' as execution_time
  ,'' as query_text
  ,'plausibleBeforeDeath' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a date value in the DOSE_ERA_START_DATE field of the DOSE_ERA table that occurs after death.' as check_description
  ,'DOSE_ERA' as cdm_table_name
  ,'DOSE_ERA_START_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_before_death.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausiblebeforedeath_dose_era_dose_era_start_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_BEFORE_DEATH
Checks for events that occur more than 60 days after death (PLAUSIBLE_BEFORE_DEATH == Yes).
Denominator is number of events with a non-null date, of persons who died.
Parameters used in this template:
schema = cdm
cdmDatabaseSchema = cdm
cdmTableName = DOSE_ERA
cdmFieldName = DOSE_ERA_START_DATE
**********/
SELECT 
    num_violated_rows, 
    CASE 
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM
(
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM
    (
        /*violatedRowsBegin*/
        SELECT 
            'DOSE_ERA.DOSE_ERA_START_DATE' AS violating_field, 
            cdmTable.*
        FROM {{ ref('dose_era') }} cdmTable
        JOIN {{ ref('death') }} de 
            ON cdmTable.person_id = de.person_id
        WHERE cdmTable.DOSE_ERA_START_DATE IS NOT NULL 
            AND CAST(cdmTable.DOSE_ERA_START_DATE AS DATE) > (de.death_date + 60*INTERVAL'1 day')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
(
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('dose_era') }} cdmTable
    JOIN {{ ref('death') }}
        ON death.person_id = cdmTable.person_id
    WHERE cdmTable.DOSE_ERA_START_DATE IS NOT NULL
) denominator
) cte
 UNION ALL /*********
SQL to create query for insertion into results table. These may be unioned together prior to insert.
Note that this does not include information about SQL errors or performance.
**********/
SELECT 
  cte.num_violated_rows
  ,cte.pct_violated_rows
  ,cte.num_denominator_rows
  ,'' as execution_time
  ,'' as query_text
  ,'plausibleBeforeDeath' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a date value in the DRUG_ERA_END_DATE field of the DRUG_ERA table that occurs after death.' as check_description
  ,'DRUG_ERA' as cdm_table_name
  ,'DRUG_ERA_END_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_before_death.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausiblebeforedeath_drug_era_drug_era_end_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_BEFORE_DEATH
Checks for events that occur more than 60 days after death (PLAUSIBLE_BEFORE_DEATH == Yes).
Denominator is number of events with a non-null date, of persons who died.
Parameters used in this template:
schema = cdm
cdmDatabaseSchema = cdm
cdmTableName = DRUG_ERA
cdmFieldName = DRUG_ERA_END_DATE
**********/
SELECT 
    num_violated_rows, 
    CASE 
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM
(
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM
    (
        /*violatedRowsBegin*/
        SELECT 
            'DRUG_ERA.DRUG_ERA_END_DATE' AS violating_field, 
            cdmTable.*
        FROM {{ ref('drug_era') }} cdmTable
        JOIN {{ ref('death') }} de 
            ON cdmTable.person_id = de.person_id
        WHERE cdmTable.DRUG_ERA_END_DATE IS NOT NULL 
            AND CAST(cdmTable.DRUG_ERA_END_DATE AS DATE) > (de.death_date + 60*INTERVAL'1 day')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
(
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('drug_era') }} cdmTable
    JOIN {{ ref('death') }}
        ON death.person_id = cdmTable.person_id
    WHERE cdmTable.DRUG_ERA_END_DATE IS NOT NULL
) denominator
) cte
 UNION ALL /*********
SQL to create query for insertion into results table. These may be unioned together prior to insert.
Note that this does not include information about SQL errors or performance.
**********/
SELECT 
  cte.num_violated_rows
  ,cte.pct_violated_rows
  ,cte.num_denominator_rows
  ,'' as execution_time
  ,'' as query_text
  ,'plausibleBeforeDeath' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a date value in the DRUG_ERA_START_DATE field of the DRUG_ERA table that occurs after death.' as check_description
  ,'DRUG_ERA' as cdm_table_name
  ,'DRUG_ERA_START_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_before_death.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausiblebeforedeath_drug_era_drug_era_start_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_BEFORE_DEATH
Checks for events that occur more than 60 days after death (PLAUSIBLE_BEFORE_DEATH == Yes).
Denominator is number of events with a non-null date, of persons who died.
Parameters used in this template:
schema = cdm
cdmDatabaseSchema = cdm
cdmTableName = DRUG_ERA
cdmFieldName = DRUG_ERA_START_DATE
**********/
SELECT 
    num_violated_rows, 
    CASE 
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM
(
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM
    (
        /*violatedRowsBegin*/
        SELECT 
            'DRUG_ERA.DRUG_ERA_START_DATE' AS violating_field, 
            cdmTable.*
        FROM {{ ref('drug_era') }} cdmTable
        JOIN {{ ref('death') }} de 
            ON cdmTable.person_id = de.person_id
        WHERE cdmTable.DRUG_ERA_START_DATE IS NOT NULL 
            AND CAST(cdmTable.DRUG_ERA_START_DATE AS DATE) > (de.death_date + 60*INTERVAL'1 day')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
(
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('drug_era') }} cdmTable
    JOIN {{ ref('death') }}
        ON death.person_id = cdmTable.person_id
    WHERE cdmTable.DRUG_ERA_START_DATE IS NOT NULL
) denominator
) cte
 UNION ALL /*********
SQL to create query for insertion into results table. These may be unioned together prior to insert.
Note that this does not include information about SQL errors or performance.
**********/
SELECT 
  cte.num_violated_rows
  ,cte.pct_violated_rows
  ,cte.num_denominator_rows
  ,'' as execution_time
  ,'' as query_text
  ,'plausibleBeforeDeath' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a date value in the DRUG_EXPOSURE_END_DATE field of the DRUG_EXPOSURE table that occurs after death.' as check_description
  ,'DRUG_EXPOSURE' as cdm_table_name
  ,'DRUG_EXPOSURE_END_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_before_death.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausiblebeforedeath_drug_exposure_drug_exposure_end_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_BEFORE_DEATH
Checks for events that occur more than 60 days after death (PLAUSIBLE_BEFORE_DEATH == Yes).
Denominator is number of events with a non-null date, of persons who died.
Parameters used in this template:
schema = cdm
cdmDatabaseSchema = cdm
cdmTableName = DRUG_EXPOSURE
cdmFieldName = DRUG_EXPOSURE_END_DATE
**********/
SELECT 
    num_violated_rows, 
    CASE 
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM
(
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM
    (
        /*violatedRowsBegin*/
        SELECT 
            'DRUG_EXPOSURE.DRUG_EXPOSURE_END_DATE' AS violating_field, 
            cdmTable.*
        FROM {{ ref('drug_exposure') }} cdmTable
        JOIN {{ ref('death') }} de 
            ON cdmTable.person_id = de.person_id
        WHERE cdmTable.DRUG_EXPOSURE_END_DATE IS NOT NULL 
            AND CAST(cdmTable.DRUG_EXPOSURE_END_DATE AS DATE) > (de.death_date + 60*INTERVAL'1 day')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
(
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('drug_exposure') }} cdmTable
    JOIN {{ ref('death') }}
        ON death.person_id = cdmTable.person_id
    WHERE cdmTable.DRUG_EXPOSURE_END_DATE IS NOT NULL
) denominator
) cte
 UNION ALL /*********
SQL to create query for insertion into results table. These may be unioned together prior to insert.
Note that this does not include information about SQL errors or performance.
**********/
SELECT 
  cte.num_violated_rows
  ,cte.pct_violated_rows
  ,cte.num_denominator_rows
  ,'' as execution_time
  ,'' as query_text
  ,'plausibleBeforeDeath' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a date value in the DRUG_EXPOSURE_END_DATETIME field of the DRUG_EXPOSURE table that occurs after death.' as check_description
  ,'DRUG_EXPOSURE' as cdm_table_name
  ,'DRUG_EXPOSURE_END_DATETIME' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_before_death.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausiblebeforedeath_drug_exposure_drug_exposure_end_datetime' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_BEFORE_DEATH
Checks for events that occur more than 60 days after death (PLAUSIBLE_BEFORE_DEATH == Yes).
Denominator is number of events with a non-null date, of persons who died.
Parameters used in this template:
schema = cdm
cdmDatabaseSchema = cdm
cdmTableName = DRUG_EXPOSURE
cdmFieldName = DRUG_EXPOSURE_END_DATETIME
**********/
SELECT 
    num_violated_rows, 
    CASE 
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM
(
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM
    (
        /*violatedRowsBegin*/
        SELECT 
            'DRUG_EXPOSURE.DRUG_EXPOSURE_END_DATETIME' AS violating_field, 
            cdmTable.*
        FROM {{ ref('drug_exposure') }} cdmTable
        JOIN {{ ref('death') }} de 
            ON cdmTable.person_id = de.person_id
        WHERE cdmTable.DRUG_EXPOSURE_END_DATETIME IS NOT NULL 
            AND CAST(cdmTable.DRUG_EXPOSURE_END_DATETIME AS DATE) > (de.death_date + 60*INTERVAL'1 day')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
(
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('drug_exposure') }} cdmTable
    JOIN {{ ref('death') }}
        ON death.person_id = cdmTable.person_id
    WHERE cdmTable.DRUG_EXPOSURE_END_DATETIME IS NOT NULL
) denominator
) cte
 UNION ALL /*********
SQL to create query for insertion into results table. These may be unioned together prior to insert.
Note that this does not include information about SQL errors or performance.
**********/
SELECT 
  cte.num_violated_rows
  ,cte.pct_violated_rows
  ,cte.num_denominator_rows
  ,'' as execution_time
  ,'' as query_text
  ,'plausibleBeforeDeath' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a date value in the DRUG_EXPOSURE_START_DATE field of the DRUG_EXPOSURE table that occurs after death.' as check_description
  ,'DRUG_EXPOSURE' as cdm_table_name
  ,'DRUG_EXPOSURE_START_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_before_death.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausiblebeforedeath_drug_exposure_drug_exposure_start_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_BEFORE_DEATH
Checks for events that occur more than 60 days after death (PLAUSIBLE_BEFORE_DEATH == Yes).
Denominator is number of events with a non-null date, of persons who died.
Parameters used in this template:
schema = cdm
cdmDatabaseSchema = cdm
cdmTableName = DRUG_EXPOSURE
cdmFieldName = DRUG_EXPOSURE_START_DATE
**********/
SELECT 
    num_violated_rows, 
    CASE 
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM
(
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM
    (
        /*violatedRowsBegin*/
        SELECT 
            'DRUG_EXPOSURE.DRUG_EXPOSURE_START_DATE' AS violating_field, 
            cdmTable.*
        FROM {{ ref('drug_exposure') }} cdmTable
        JOIN {{ ref('death') }} de 
            ON cdmTable.person_id = de.person_id
        WHERE cdmTable.DRUG_EXPOSURE_START_DATE IS NOT NULL 
            AND CAST(cdmTable.DRUG_EXPOSURE_START_DATE AS DATE) > (de.death_date + 60*INTERVAL'1 day')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
(
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('drug_exposure') }} cdmTable
    JOIN {{ ref('death') }}
        ON death.person_id = cdmTable.person_id
    WHERE cdmTable.DRUG_EXPOSURE_START_DATE IS NOT NULL
) denominator
) cte
 UNION ALL /*********
SQL to create query for insertion into results table. These may be unioned together prior to insert.
Note that this does not include information about SQL errors or performance.
**********/
SELECT 
  cte.num_violated_rows
  ,cte.pct_violated_rows
  ,cte.num_denominator_rows
  ,'' as execution_time
  ,'' as query_text
  ,'plausibleBeforeDeath' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a date value in the DRUG_EXPOSURE_START_DATETIME field of the DRUG_EXPOSURE table that occurs after death.' as check_description
  ,'DRUG_EXPOSURE' as cdm_table_name
  ,'DRUG_EXPOSURE_START_DATETIME' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_before_death.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausiblebeforedeath_drug_exposure_drug_exposure_start_datetime' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_BEFORE_DEATH
Checks for events that occur more than 60 days after death (PLAUSIBLE_BEFORE_DEATH == Yes).
Denominator is number of events with a non-null date, of persons who died.
Parameters used in this template:
schema = cdm
cdmDatabaseSchema = cdm
cdmTableName = DRUG_EXPOSURE
cdmFieldName = DRUG_EXPOSURE_START_DATETIME
**********/
SELECT 
    num_violated_rows, 
    CASE 
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM
(
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM
    (
        /*violatedRowsBegin*/
        SELECT 
            'DRUG_EXPOSURE.DRUG_EXPOSURE_START_DATETIME' AS violating_field, 
            cdmTable.*
        FROM {{ ref('drug_exposure') }} cdmTable
        JOIN {{ ref('death') }} de 
            ON cdmTable.person_id = de.person_id
        WHERE cdmTable.DRUG_EXPOSURE_START_DATETIME IS NOT NULL 
            AND CAST(cdmTable.DRUG_EXPOSURE_START_DATETIME AS DATE) > (de.death_date + 60*INTERVAL'1 day')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
(
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('drug_exposure') }} cdmTable
    JOIN {{ ref('death') }}
        ON death.person_id = cdmTable.person_id
    WHERE cdmTable.DRUG_EXPOSURE_START_DATETIME IS NOT NULL
) denominator
) cte
 UNION ALL /*********
SQL to create query for insertion into results table. These may be unioned together prior to insert.
Note that this does not include information about SQL errors or performance.
**********/
SELECT 
  cte.num_violated_rows
  ,cte.pct_violated_rows
  ,cte.num_denominator_rows
  ,'' as execution_time
  ,'' as query_text
  ,'plausibleBeforeDeath' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a date value in the VERBATIM_END_DATE field of the DRUG_EXPOSURE table that occurs after death.' as check_description
  ,'DRUG_EXPOSURE' as cdm_table_name
  ,'VERBATIM_END_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_before_death.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausiblebeforedeath_drug_exposure_verbatim_end_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_BEFORE_DEATH
Checks for events that occur more than 60 days after death (PLAUSIBLE_BEFORE_DEATH == Yes).
Denominator is number of events with a non-null date, of persons who died.
Parameters used in this template:
schema = cdm
cdmDatabaseSchema = cdm
cdmTableName = DRUG_EXPOSURE
cdmFieldName = VERBATIM_END_DATE
**********/
SELECT 
    num_violated_rows, 
    CASE 
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM
(
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM
    (
        /*violatedRowsBegin*/
        SELECT 
            'DRUG_EXPOSURE.VERBATIM_END_DATE' AS violating_field, 
            cdmTable.*
        FROM {{ ref('drug_exposure') }} cdmTable
        JOIN {{ ref('death') }} de 
            ON cdmTable.person_id = de.person_id
        WHERE cdmTable.VERBATIM_END_DATE IS NOT NULL 
            AND CAST(cdmTable.VERBATIM_END_DATE AS DATE) > (de.death_date + 60*INTERVAL'1 day')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
(
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('drug_exposure') }} cdmTable
    JOIN {{ ref('death') }}
        ON death.person_id = cdmTable.person_id
    WHERE cdmTable.VERBATIM_END_DATE IS NOT NULL
) denominator
) cte
 UNION ALL /*********
SQL to create query for insertion into results table. These may be unioned together prior to insert.
Note that this does not include information about SQL errors or performance.
**********/
SELECT 
  cte.num_violated_rows
  ,cte.pct_violated_rows
  ,cte.num_denominator_rows
  ,'' as execution_time
  ,'' as query_text
  ,'plausibleBeforeDeath' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a date value in the EPISODE_END_DATE field of the EPISODE table that occurs after death.' as check_description
  ,'EPISODE' as cdm_table_name
  ,'EPISODE_END_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_before_death.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausiblebeforedeath_episode_episode_end_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_BEFORE_DEATH
Checks for events that occur more than 60 days after death (PLAUSIBLE_BEFORE_DEATH == Yes).
Denominator is number of events with a non-null date, of persons who died.
Parameters used in this template:
schema = cdm
cdmDatabaseSchema = cdm
cdmTableName = EPISODE
cdmFieldName = EPISODE_END_DATE
**********/
SELECT 
    num_violated_rows, 
    CASE 
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM
(
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM
    (
        /*violatedRowsBegin*/
        SELECT 
            'EPISODE.EPISODE_END_DATE' AS violating_field, 
            cdmTable.*
        FROM {{ ref('episode') }} cdmTable
        JOIN {{ ref('death') }} de 
            ON cdmTable.person_id = de.person_id
        WHERE cdmTable.EPISODE_END_DATE IS NOT NULL 
            AND CAST(cdmTable.EPISODE_END_DATE AS DATE) > (de.death_date + 60*INTERVAL'1 day')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
(
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('episode') }} cdmTable
    JOIN {{ ref('death') }}
        ON death.person_id = cdmTable.person_id
    WHERE cdmTable.EPISODE_END_DATE IS NOT NULL
) denominator
) cte
 UNION ALL /*********
SQL to create query for insertion into results table. These may be unioned together prior to insert.
Note that this does not include information about SQL errors or performance.
**********/
SELECT 
  cte.num_violated_rows
  ,cte.pct_violated_rows
  ,cte.num_denominator_rows
  ,'' as execution_time
  ,'' as query_text
  ,'plausibleBeforeDeath' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a date value in the EPISODE_END_DATETIME field of the EPISODE table that occurs after death.' as check_description
  ,'EPISODE' as cdm_table_name
  ,'EPISODE_END_DATETIME' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_before_death.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausiblebeforedeath_episode_episode_end_datetime' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_BEFORE_DEATH
Checks for events that occur more than 60 days after death (PLAUSIBLE_BEFORE_DEATH == Yes).
Denominator is number of events with a non-null date, of persons who died.
Parameters used in this template:
schema = cdm
cdmDatabaseSchema = cdm
cdmTableName = EPISODE
cdmFieldName = EPISODE_END_DATETIME
**********/
SELECT 
    num_violated_rows, 
    CASE 
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM
(
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM
    (
        /*violatedRowsBegin*/
        SELECT 
            'EPISODE.EPISODE_END_DATETIME' AS violating_field, 
            cdmTable.*
        FROM {{ ref('episode') }} cdmTable
        JOIN {{ ref('death') }} de 
            ON cdmTable.person_id = de.person_id
        WHERE cdmTable.EPISODE_END_DATETIME IS NOT NULL 
            AND CAST(cdmTable.EPISODE_END_DATETIME AS DATE) > (de.death_date + 60*INTERVAL'1 day')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
(
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('episode') }} cdmTable
    JOIN {{ ref('death') }}
        ON death.person_id = cdmTable.person_id
    WHERE cdmTable.EPISODE_END_DATETIME IS NOT NULL
) denominator
) cte
 UNION ALL /*********
SQL to create query for insertion into results table. These may be unioned together prior to insert.
Note that this does not include information about SQL errors or performance.
**********/
SELECT 
  cte.num_violated_rows
  ,cte.pct_violated_rows
  ,cte.num_denominator_rows
  ,'' as execution_time
  ,'' as query_text
  ,'plausibleBeforeDeath' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a date value in the EPISODE_START_DATE field of the EPISODE table that occurs after death.' as check_description
  ,'EPISODE' as cdm_table_name
  ,'EPISODE_START_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_before_death.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausiblebeforedeath_episode_episode_start_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_BEFORE_DEATH
Checks for events that occur more than 60 days after death (PLAUSIBLE_BEFORE_DEATH == Yes).
Denominator is number of events with a non-null date, of persons who died.
Parameters used in this template:
schema = cdm
cdmDatabaseSchema = cdm
cdmTableName = EPISODE
cdmFieldName = EPISODE_START_DATE
**********/
SELECT 
    num_violated_rows, 
    CASE 
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM
(
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM
    (
        /*violatedRowsBegin*/
        SELECT 
            'EPISODE.EPISODE_START_DATE' AS violating_field, 
            cdmTable.*
        FROM {{ ref('episode') }} cdmTable
        JOIN {{ ref('death') }} de 
            ON cdmTable.person_id = de.person_id
        WHERE cdmTable.EPISODE_START_DATE IS NOT NULL 
            AND CAST(cdmTable.EPISODE_START_DATE AS DATE) > (de.death_date + 60*INTERVAL'1 day')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
(
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('episode') }} cdmTable
    JOIN {{ ref('death') }}
        ON death.person_id = cdmTable.person_id
    WHERE cdmTable.EPISODE_START_DATE IS NOT NULL
) denominator
) cte
 UNION ALL /*********
SQL to create query for insertion into results table. These may be unioned together prior to insert.
Note that this does not include information about SQL errors or performance.
**********/
SELECT 
  cte.num_violated_rows
  ,cte.pct_violated_rows
  ,cte.num_denominator_rows
  ,'' as execution_time
  ,'' as query_text
  ,'plausibleBeforeDeath' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a date value in the EPISODE_START_DATETIME field of the EPISODE table that occurs after death.' as check_description
  ,'EPISODE' as cdm_table_name
  ,'EPISODE_START_DATETIME' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_before_death.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausiblebeforedeath_episode_episode_start_datetime' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_BEFORE_DEATH
Checks for events that occur more than 60 days after death (PLAUSIBLE_BEFORE_DEATH == Yes).
Denominator is number of events with a non-null date, of persons who died.
Parameters used in this template:
schema = cdm
cdmDatabaseSchema = cdm
cdmTableName = EPISODE
cdmFieldName = EPISODE_START_DATETIME
**********/
SELECT 
    num_violated_rows, 
    CASE 
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM
(
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM
    (
        /*violatedRowsBegin*/
        SELECT 
            'EPISODE.EPISODE_START_DATETIME' AS violating_field, 
            cdmTable.*
        FROM {{ ref('episode') }} cdmTable
        JOIN {{ ref('death') }} de 
            ON cdmTable.person_id = de.person_id
        WHERE cdmTable.EPISODE_START_DATETIME IS NOT NULL 
            AND CAST(cdmTable.EPISODE_START_DATETIME AS DATE) > (de.death_date + 60*INTERVAL'1 day')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
(
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('episode') }} cdmTable
    JOIN {{ ref('death') }}
        ON death.person_id = cdmTable.person_id
    WHERE cdmTable.EPISODE_START_DATETIME IS NOT NULL
) denominator
) cte
 UNION ALL /*********
SQL to create query for insertion into results table. These may be unioned together prior to insert.
Note that this does not include information about SQL errors or performance.
**********/
SELECT 
  cte.num_violated_rows
  ,cte.pct_violated_rows
  ,cte.num_denominator_rows
  ,'' as execution_time
  ,'' as query_text
  ,'plausibleBeforeDeath' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a date value in the MEASUREMENT_DATE field of the MEASUREMENT table that occurs after death.' as check_description
  ,'MEASUREMENT' as cdm_table_name
  ,'MEASUREMENT_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_before_death.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausiblebeforedeath_measurement_measurement_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_BEFORE_DEATH
Checks for events that occur more than 60 days after death (PLAUSIBLE_BEFORE_DEATH == Yes).
Denominator is number of events with a non-null date, of persons who died.
Parameters used in this template:
schema = cdm
cdmDatabaseSchema = cdm
cdmTableName = MEASUREMENT
cdmFieldName = MEASUREMENT_DATE
**********/
SELECT 
    num_violated_rows, 
    CASE 
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM
(
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM
    (
        /*violatedRowsBegin*/
        SELECT 
            'MEASUREMENT.MEASUREMENT_DATE' AS violating_field, 
            cdmTable.*
        FROM {{ ref('measurement') }} cdmTable
        JOIN {{ ref('death') }} de 
            ON cdmTable.person_id = de.person_id
        WHERE cdmTable.MEASUREMENT_DATE IS NOT NULL 
            AND CAST(cdmTable.MEASUREMENT_DATE AS DATE) > (de.death_date + 60*INTERVAL'1 day')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
(
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('measurement') }} cdmTable
    JOIN {{ ref('death') }}
        ON death.person_id = cdmTable.person_id
    WHERE cdmTable.MEASUREMENT_DATE IS NOT NULL
) denominator
) cte
 UNION ALL /*********
SQL to create query for insertion into results table. These may be unioned together prior to insert.
Note that this does not include information about SQL errors or performance.
**********/
SELECT 
  cte.num_violated_rows
  ,cte.pct_violated_rows
  ,cte.num_denominator_rows
  ,'' as execution_time
  ,'' as query_text
  ,'plausibleBeforeDeath' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a date value in the MEASUREMENT_DATETIME field of the MEASUREMENT table that occurs after death.' as check_description
  ,'MEASUREMENT' as cdm_table_name
  ,'MEASUREMENT_DATETIME' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_before_death.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausiblebeforedeath_measurement_measurement_datetime' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_BEFORE_DEATH
Checks for events that occur more than 60 days after death (PLAUSIBLE_BEFORE_DEATH == Yes).
Denominator is number of events with a non-null date, of persons who died.
Parameters used in this template:
schema = cdm
cdmDatabaseSchema = cdm
cdmTableName = MEASUREMENT
cdmFieldName = MEASUREMENT_DATETIME
**********/
SELECT 
    num_violated_rows, 
    CASE 
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM
(
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM
    (
        /*violatedRowsBegin*/
        SELECT 
            'MEASUREMENT.MEASUREMENT_DATETIME' AS violating_field, 
            cdmTable.*
        FROM {{ ref('measurement') }} cdmTable
        JOIN {{ ref('death') }} de 
            ON cdmTable.person_id = de.person_id
        WHERE cdmTable.MEASUREMENT_DATETIME IS NOT NULL 
            AND CAST(cdmTable.MEASUREMENT_DATETIME AS DATE) > (de.death_date + 60*INTERVAL'1 day')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
(
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('measurement') }} cdmTable
    JOIN {{ ref('death') }}
        ON death.person_id = cdmTable.person_id
    WHERE cdmTable.MEASUREMENT_DATETIME IS NOT NULL
) denominator
) cte

UNION ALL
SELECT cte.num_violated_rows
  ,cte.pct_violated_rows
  ,cte.num_denominator_rows
  , CAST('' as TEXT) as execution_time
  ,'' as query_text
  ,'plausibleBeforeDeath' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a date value in the NOTE_DATE field of the NOTE table that occurs after death.' as check_description
  ,'NOTE' as cdm_table_name
  ,'NOTE_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_before_death.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausiblebeforedeath_note_note_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_BEFORE_DEATH
Checks for events that occur more than 60 days after death (PLAUSIBLE_BEFORE_DEATH == Yes).
Denominator is number of events with a non-null date, of persons who died.
Parameters used in this template:
schema = cdm
cdmDatabaseSchema = cdm
cdmTableName = NOTE
cdmFieldName = NOTE_DATE
**********/
SELECT 
    num_violated_rows, 
    CASE 
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM
(
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM
    (
        /*violatedRowsBegin*/
        SELECT 
            'NOTE.NOTE_DATE' AS violating_field, 
            cdmTable.*
        FROM {{ ref('note') }} cdmTable
        JOIN {{ ref('death') }} de 
            ON cdmTable.person_id = de.person_id
        WHERE cdmTable.NOTE_DATE IS NOT NULL 
            AND CAST(cdmTable.NOTE_DATE AS DATE) > (de.death_date + 60*INTERVAL'1 day')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
(
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('note') }} cdmTable
    JOIN {{ ref('death') }}
        ON death.person_id = cdmTable.person_id
    WHERE cdmTable.NOTE_DATE IS NOT NULL
) denominator
) cte
 UNION ALL /*********
SQL to create query for insertion into results table. These may be unioned together prior to insert.
Note that this does not include information about SQL errors or performance.
**********/
SELECT 
  cte.num_violated_rows
  ,cte.pct_violated_rows
  ,cte.num_denominator_rows
  ,'' as execution_time
  ,'' as query_text
  ,'plausibleBeforeDeath' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a date value in the NOTE_DATETIME field of the NOTE table that occurs after death.' as check_description
  ,'NOTE' as cdm_table_name
  ,'NOTE_DATETIME' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_before_death.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausiblebeforedeath_note_note_datetime' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_BEFORE_DEATH
Checks for events that occur more than 60 days after death (PLAUSIBLE_BEFORE_DEATH == Yes).
Denominator is number of events with a non-null date, of persons who died.
Parameters used in this template:
schema = cdm
cdmDatabaseSchema = cdm
cdmTableName = NOTE
cdmFieldName = NOTE_DATETIME
**********/
SELECT 
    num_violated_rows, 
    CASE 
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM
(
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM
    (
        /*violatedRowsBegin*/
        SELECT 
            'NOTE.NOTE_DATETIME' AS violating_field, 
            cdmTable.*
        FROM {{ ref('note') }} cdmTable
        JOIN {{ ref('death') }} de 
            ON cdmTable.person_id = de.person_id
        WHERE cdmTable.NOTE_DATETIME IS NOT NULL 
            AND CAST(cdmTable.NOTE_DATETIME AS DATE) > (de.death_date + 60*INTERVAL'1 day')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
(
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('note') }} cdmTable
    JOIN {{ ref('death') }}
        ON death.person_id = cdmTable.person_id
    WHERE cdmTable.NOTE_DATETIME IS NOT NULL
) denominator
) cte
 UNION ALL /*********
SQL to create query for insertion into results table. These may be unioned together prior to insert.
Note that this does not include information about SQL errors or performance.
**********/
SELECT 
  cte.num_violated_rows
  ,cte.pct_violated_rows
  ,cte.num_denominator_rows
  ,'' as execution_time
  ,'' as query_text
  ,'plausibleBeforeDeath' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a date value in the OBSERVATION_DATE field of the OBSERVATION table that occurs after death.' as check_description
  ,'OBSERVATION' as cdm_table_name
  ,'OBSERVATION_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_before_death.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausiblebeforedeath_observation_observation_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_BEFORE_DEATH
Checks for events that occur more than 60 days after death (PLAUSIBLE_BEFORE_DEATH == Yes).
Denominator is number of events with a non-null date, of persons who died.
Parameters used in this template:
schema = cdm
cdmDatabaseSchema = cdm
cdmTableName = OBSERVATION
cdmFieldName = OBSERVATION_DATE
**********/
SELECT 
    num_violated_rows, 
    CASE 
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM
(
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM
    (
        /*violatedRowsBegin*/
        SELECT 
            'OBSERVATION.OBSERVATION_DATE' AS violating_field, 
            cdmTable.*
        FROM {{ ref('observation') }} cdmTable
        JOIN {{ ref('death') }} de 
            ON cdmTable.person_id = de.person_id
        WHERE cdmTable.OBSERVATION_DATE IS NOT NULL 
            AND CAST(cdmTable.OBSERVATION_DATE AS DATE) > (de.death_date + 60*INTERVAL'1 day')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
(
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('observation') }} cdmTable
    JOIN {{ ref('death') }}
        ON death.person_id = cdmTable.person_id
    WHERE cdmTable.OBSERVATION_DATE IS NOT NULL
) denominator
) cte
 UNION ALL /*********
SQL to create query for insertion into results table. These may be unioned together prior to insert.
Note that this does not include information about SQL errors or performance.
**********/
SELECT 
  cte.num_violated_rows
  ,cte.pct_violated_rows
  ,cte.num_denominator_rows
  ,'' as execution_time
  ,'' as query_text
  ,'plausibleBeforeDeath' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a date value in the OBSERVATION_DATETIME field of the OBSERVATION table that occurs after death.' as check_description
  ,'OBSERVATION' as cdm_table_name
  ,'OBSERVATION_DATETIME' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_before_death.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausiblebeforedeath_observation_observation_datetime' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_BEFORE_DEATH
Checks for events that occur more than 60 days after death (PLAUSIBLE_BEFORE_DEATH == Yes).
Denominator is number of events with a non-null date, of persons who died.
Parameters used in this template:
schema = cdm
cdmDatabaseSchema = cdm
cdmTableName = OBSERVATION
cdmFieldName = OBSERVATION_DATETIME
**********/
SELECT 
    num_violated_rows, 
    CASE 
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM
(
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM
    (
        /*violatedRowsBegin*/
        SELECT 
            'OBSERVATION.OBSERVATION_DATETIME' AS violating_field, 
            cdmTable.*
        FROM {{ ref('observation') }} cdmTable
        JOIN {{ ref('death') }} de 
            ON cdmTable.person_id = de.person_id
        WHERE cdmTable.OBSERVATION_DATETIME IS NOT NULL 
            AND CAST(cdmTable.OBSERVATION_DATETIME AS DATE) > (de.death_date + 60*INTERVAL'1 day')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
(
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('observation') }} cdmTable
    JOIN {{ ref('death') }}
        ON death.person_id = cdmTable.person_id
    WHERE cdmTable.OBSERVATION_DATETIME IS NOT NULL
) denominator
) cte
 UNION ALL /*********
SQL to create query for insertion into results table. These may be unioned together prior to insert.
Note that this does not include information about SQL errors or performance.
**********/
SELECT 
  cte.num_violated_rows
  ,cte.pct_violated_rows
  ,cte.num_denominator_rows
  ,'' as execution_time
  ,'' as query_text
  ,'plausibleBeforeDeath' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a date value in the OBSERVATION_PERIOD_END_DATE field of the OBSERVATION_PERIOD table that occurs after death.' as check_description
  ,'OBSERVATION_PERIOD' as cdm_table_name
  ,'OBSERVATION_PERIOD_END_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_before_death.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausiblebeforedeath_observation_period_observation_period_end_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_BEFORE_DEATH
Checks for events that occur more than 60 days after death (PLAUSIBLE_BEFORE_DEATH == Yes).
Denominator is number of events with a non-null date, of persons who died.
Parameters used in this template:
schema = cdm
cdmDatabaseSchema = cdm
cdmTableName = OBSERVATION_PERIOD
cdmFieldName = OBSERVATION_PERIOD_END_DATE
**********/
SELECT 
    num_violated_rows, 
    CASE 
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM
(
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM
    (
        /*violatedRowsBegin*/
        SELECT 
            'OBSERVATION_PERIOD.OBSERVATION_PERIOD_END_DATE' AS violating_field, 
            cdmTable.*
        FROM {{ ref('observation_period') }} cdmTable
        JOIN {{ ref('death') }} de 
            ON cdmTable.person_id = de.person_id
        WHERE cdmTable.OBSERVATION_PERIOD_END_DATE IS NOT NULL 
            AND CAST(cdmTable.OBSERVATION_PERIOD_END_DATE AS DATE) > (de.death_date + 60*INTERVAL'1 day')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
(
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('observation_period') }} cdmTable
    JOIN {{ ref('death') }}
        ON death.person_id = cdmTable.person_id
    WHERE cdmTable.OBSERVATION_PERIOD_END_DATE IS NOT NULL
) denominator
) cte
 UNION ALL /*********
SQL to create query for insertion into results table. These may be unioned together prior to insert.
Note that this does not include information about SQL errors or performance.
**********/
SELECT 
  cte.num_violated_rows
  ,cte.pct_violated_rows
  ,cte.num_denominator_rows
  ,'' as execution_time
  ,'' as query_text
  ,'plausibleBeforeDeath' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a date value in the OBSERVATION_PERIOD_START_DATE field of the OBSERVATION_PERIOD table that occurs after death.' as check_description
  ,'OBSERVATION_PERIOD' as cdm_table_name
  ,'OBSERVATION_PERIOD_START_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_before_death.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausiblebeforedeath_observation_period_observation_period_start_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_BEFORE_DEATH
Checks for events that occur more than 60 days after death (PLAUSIBLE_BEFORE_DEATH == Yes).
Denominator is number of events with a non-null date, of persons who died.
Parameters used in this template:
schema = cdm
cdmDatabaseSchema = cdm
cdmTableName = OBSERVATION_PERIOD
cdmFieldName = OBSERVATION_PERIOD_START_DATE
**********/
SELECT 
    num_violated_rows, 
    CASE 
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM
(
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM
    (
        /*violatedRowsBegin*/
        SELECT 
            'OBSERVATION_PERIOD.OBSERVATION_PERIOD_START_DATE' AS violating_field, 
            cdmTable.*
        FROM {{ ref('observation_period') }} cdmTable
        JOIN {{ ref('death') }} de 
            ON cdmTable.person_id = de.person_id
        WHERE cdmTable.OBSERVATION_PERIOD_START_DATE IS NOT NULL 
            AND CAST(cdmTable.OBSERVATION_PERIOD_START_DATE AS DATE) > (de.death_date + 60*INTERVAL'1 day')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
(
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('observation_period') }} cdmTable
    JOIN {{ ref('death') }}
        ON death.person_id = cdmTable.person_id
    WHERE cdmTable.OBSERVATION_PERIOD_START_DATE IS NOT NULL
) denominator
) cte
 UNION ALL /*********
SQL to create query for insertion into results table. These may be unioned together prior to insert.
Note that this does not include information about SQL errors or performance.
**********/
SELECT 
  cte.num_violated_rows
  ,cte.pct_violated_rows
  ,cte.num_denominator_rows
  ,'' as execution_time
  ,'' as query_text
  ,'plausibleBeforeDeath' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a date value in the PAYER_PLAN_PERIOD_END_DATE field of the PAYER_PLAN_PERIOD table that occurs after death.' as check_description
  ,'PAYER_PLAN_PERIOD' as cdm_table_name
  ,'PAYER_PLAN_PERIOD_END_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_before_death.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausiblebeforedeath_payer_plan_period_payer_plan_period_end_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_BEFORE_DEATH
Checks for events that occur more than 60 days after death (PLAUSIBLE_BEFORE_DEATH == Yes).
Denominator is number of events with a non-null date, of persons who died.
Parameters used in this template:
schema = cdm
cdmDatabaseSchema = cdm
cdmTableName = PAYER_PLAN_PERIOD
cdmFieldName = PAYER_PLAN_PERIOD_END_DATE
**********/
SELECT 
    num_violated_rows, 
    CASE 
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM
(
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM
    (
        /*violatedRowsBegin*/
        SELECT 
            'PAYER_PLAN_PERIOD.PAYER_PLAN_PERIOD_END_DATE' AS violating_field, 
            cdmTable.*
        FROM {{ ref('payer_plan_period') }} cdmTable
        JOIN {{ ref('death') }} de 
            ON cdmTable.person_id = de.person_id
        WHERE cdmTable.PAYER_PLAN_PERIOD_END_DATE IS NOT NULL 
            AND CAST(cdmTable.PAYER_PLAN_PERIOD_END_DATE AS DATE) > (de.death_date + 60*INTERVAL'1 day')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
(
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('payer_plan_period') }} cdmTable
    JOIN {{ ref('death') }}
        ON death.person_id = cdmTable.person_id
    WHERE cdmTable.PAYER_PLAN_PERIOD_END_DATE IS NOT NULL
) denominator
) cte
 UNION ALL /*********
SQL to create query for insertion into results table. These may be unioned together prior to insert.
Note that this does not include information about SQL errors or performance.
**********/
SELECT 
  cte.num_violated_rows
  ,cte.pct_violated_rows
  ,cte.num_denominator_rows
  ,'' as execution_time
  ,'' as query_text
  ,'plausibleBeforeDeath' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a date value in the PAYER_PLAN_PERIOD_START_DATE field of the PAYER_PLAN_PERIOD table that occurs after death.' as check_description
  ,'PAYER_PLAN_PERIOD' as cdm_table_name
  ,'PAYER_PLAN_PERIOD_START_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_before_death.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausiblebeforedeath_payer_plan_period_payer_plan_period_start_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_BEFORE_DEATH
Checks for events that occur more than 60 days after death (PLAUSIBLE_BEFORE_DEATH == Yes).
Denominator is number of events with a non-null date, of persons who died.
Parameters used in this template:
schema = cdm
cdmDatabaseSchema = cdm
cdmTableName = PAYER_PLAN_PERIOD
cdmFieldName = PAYER_PLAN_PERIOD_START_DATE
**********/
SELECT 
    num_violated_rows, 
    CASE 
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM
(
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM
    (
        /*violatedRowsBegin*/
        SELECT 
            'PAYER_PLAN_PERIOD.PAYER_PLAN_PERIOD_START_DATE' AS violating_field, 
            cdmTable.*
        FROM {{ ref('payer_plan_period') }} cdmTable
        JOIN {{ ref('death') }} de 
            ON cdmTable.person_id = de.person_id
        WHERE cdmTable.PAYER_PLAN_PERIOD_START_DATE IS NOT NULL 
            AND CAST(cdmTable.PAYER_PLAN_PERIOD_START_DATE AS DATE) > (de.death_date + 60*INTERVAL'1 day')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
(
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('payer_plan_period') }} cdmTable
    JOIN {{ ref('death') }}
        ON death.person_id = cdmTable.person_id
    WHERE cdmTable.PAYER_PLAN_PERIOD_START_DATE IS NOT NULL
) denominator
) cte
 UNION ALL /*********
SQL to create query for insertion into results table. These may be unioned together prior to insert.
Note that this does not include information about SQL errors or performance.
**********/
SELECT 
  cte.num_violated_rows
  ,cte.pct_violated_rows
  ,cte.num_denominator_rows
  ,'' as execution_time
  ,'' as query_text
  ,'plausibleBeforeDeath' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a date value in the PROCEDURE_DATE field of the PROCEDURE_OCCURRENCE table that occurs after death.' as check_description
  ,'PROCEDURE_OCCURRENCE' as cdm_table_name
  ,'PROCEDURE_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_before_death.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausiblebeforedeath_procedure_occurrence_procedure_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_BEFORE_DEATH
Checks for events that occur more than 60 days after death (PLAUSIBLE_BEFORE_DEATH == Yes).
Denominator is number of events with a non-null date, of persons who died.
Parameters used in this template:
schema = cdm
cdmDatabaseSchema = cdm
cdmTableName = PROCEDURE_OCCURRENCE
cdmFieldName = PROCEDURE_DATE
**********/
SELECT 
    num_violated_rows, 
    CASE 
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM
(
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM
    (
        /*violatedRowsBegin*/
        SELECT 
            'PROCEDURE_OCCURRENCE.PROCEDURE_DATE' AS violating_field, 
            cdmTable.*
        FROM {{ ref('procedure_occurrence') }} cdmTable
        JOIN {{ ref('death') }} de 
            ON cdmTable.person_id = de.person_id
        WHERE cdmTable.PROCEDURE_DATE IS NOT NULL 
            AND CAST(cdmTable.PROCEDURE_DATE AS DATE) > (de.death_date + 60*INTERVAL'1 day')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
(
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('procedure_occurrence') }} cdmTable
    JOIN {{ ref('death') }}
        ON death.person_id = cdmTable.person_id
    WHERE cdmTable.PROCEDURE_DATE IS NOT NULL
) denominator
) cte
 UNION ALL /*********
SQL to create query for insertion into results table. These may be unioned together prior to insert.
Note that this does not include information about SQL errors or performance.
**********/
SELECT 
  cte.num_violated_rows
  ,cte.pct_violated_rows
  ,cte.num_denominator_rows
  ,'' as execution_time
  ,'' as query_text
  ,'plausibleBeforeDeath' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a date value in the PROCEDURE_DATETIME field of the PROCEDURE_OCCURRENCE table that occurs after death.' as check_description
  ,'PROCEDURE_OCCURRENCE' as cdm_table_name
  ,'PROCEDURE_DATETIME' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_before_death.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausiblebeforedeath_procedure_occurrence_procedure_datetime' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_BEFORE_DEATH
Checks for events that occur more than 60 days after death (PLAUSIBLE_BEFORE_DEATH == Yes).
Denominator is number of events with a non-null date, of persons who died.
Parameters used in this template:
schema = cdm
cdmDatabaseSchema = cdm
cdmTableName = PROCEDURE_OCCURRENCE
cdmFieldName = PROCEDURE_DATETIME
**********/
SELECT 
    num_violated_rows, 
    CASE 
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM
(
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM
    (
        /*violatedRowsBegin*/
        SELECT 
            'PROCEDURE_OCCURRENCE.PROCEDURE_DATETIME' AS violating_field, 
            cdmTable.*
        FROM {{ ref('procedure_occurrence') }} cdmTable
        JOIN {{ ref('death') }} de 
            ON cdmTable.person_id = de.person_id
        WHERE cdmTable.PROCEDURE_DATETIME IS NOT NULL 
            AND CAST(cdmTable.PROCEDURE_DATETIME AS DATE) > (de.death_date + 60*INTERVAL'1 day')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
(
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('procedure_occurrence') }} cdmTable
    JOIN {{ ref('death') }}
        ON death.person_id = cdmTable.person_id
    WHERE cdmTable.PROCEDURE_DATETIME IS NOT NULL
) denominator
) cte
 UNION ALL /*********
SQL to create query for insertion into results table. These may be unioned together prior to insert.
Note that this does not include information about SQL errors or performance.
**********/
SELECT 
  cte.num_violated_rows
  ,cte.pct_violated_rows
  ,cte.num_denominator_rows
  ,'' as execution_time
  ,'' as query_text
  ,'plausibleBeforeDeath' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a date value in the PROCEDURE_END_DATE field of the PROCEDURE_OCCURRENCE table that occurs after death.' as check_description
  ,'PROCEDURE_OCCURRENCE' as cdm_table_name
  ,'PROCEDURE_END_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_before_death.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausiblebeforedeath_procedure_occurrence_procedure_end_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_BEFORE_DEATH
Checks for events that occur more than 60 days after death (PLAUSIBLE_BEFORE_DEATH == Yes).
Denominator is number of events with a non-null date, of persons who died.
Parameters used in this template:
schema = cdm
cdmDatabaseSchema = cdm
cdmTableName = PROCEDURE_OCCURRENCE
cdmFieldName = PROCEDURE_END_DATE
**********/
SELECT 
    num_violated_rows, 
    CASE 
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM
(
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM
    (
        /*violatedRowsBegin*/
        SELECT 
            'PROCEDURE_OCCURRENCE.PROCEDURE_END_DATE' AS violating_field, 
            cdmTable.*
        FROM {{ ref('procedure_occurrence') }} cdmTable
        JOIN {{ ref('death') }} de 
            ON cdmTable.person_id = de.person_id
        WHERE cdmTable.PROCEDURE_END_DATE IS NOT NULL 
            AND CAST(cdmTable.PROCEDURE_END_DATE AS DATE) > (de.death_date + 60*INTERVAL'1 day')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
(
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('procedure_occurrence') }} cdmTable
    JOIN {{ ref('death') }}
        ON death.person_id = cdmTable.person_id
    WHERE cdmTable.PROCEDURE_END_DATE IS NOT NULL
) denominator
) cte
 UNION ALL /*********
SQL to create query for insertion into results table. These may be unioned together prior to insert.
Note that this does not include information about SQL errors or performance.
**********/
SELECT 
  cte.num_violated_rows
  ,cte.pct_violated_rows
  ,cte.num_denominator_rows
  ,'' as execution_time
  ,'' as query_text
  ,'plausibleBeforeDeath' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a date value in the PROCEDURE_END_DATETIME field of the PROCEDURE_OCCURRENCE table that occurs after death.' as check_description
  ,'PROCEDURE_OCCURRENCE' as cdm_table_name
  ,'PROCEDURE_END_DATETIME' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_before_death.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausiblebeforedeath_procedure_occurrence_procedure_end_datetime' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_BEFORE_DEATH
Checks for events that occur more than 60 days after death (PLAUSIBLE_BEFORE_DEATH == Yes).
Denominator is number of events with a non-null date, of persons who died.
Parameters used in this template:
schema = cdm
cdmDatabaseSchema = cdm
cdmTableName = PROCEDURE_OCCURRENCE
cdmFieldName = PROCEDURE_END_DATETIME
**********/
SELECT 
    num_violated_rows, 
    CASE 
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM
(
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM
    (
        /*violatedRowsBegin*/
        SELECT 
            'PROCEDURE_OCCURRENCE.PROCEDURE_END_DATETIME' AS violating_field, 
            cdmTable.*
        FROM {{ ref('procedure_occurrence') }} cdmTable
        JOIN {{ ref('death') }} de 
            ON cdmTable.person_id = de.person_id
        WHERE cdmTable.PROCEDURE_END_DATETIME IS NOT NULL 
            AND CAST(cdmTable.PROCEDURE_END_DATETIME AS DATE) > (de.death_date + 60*INTERVAL'1 day')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
(
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('procedure_occurrence') }} cdmTable
    JOIN {{ ref('death') }}
        ON death.person_id = cdmTable.person_id
    WHERE cdmTable.PROCEDURE_END_DATETIME IS NOT NULL
) denominator
) cte
 UNION ALL /*********
SQL to create query for insertion into results table. These may be unioned together prior to insert.
Note that this does not include information about SQL errors or performance.
**********/
SELECT 
  cte.num_violated_rows
  ,cte.pct_violated_rows
  ,cte.num_denominator_rows
  ,'' as execution_time
  ,'' as query_text
  ,'plausibleBeforeDeath' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a date value in the SPECIMEN_DATE field of the SPECIMEN table that occurs after death.' as check_description
  ,'SPECIMEN' as cdm_table_name
  ,'SPECIMEN_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_before_death.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausiblebeforedeath_specimen_specimen_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_BEFORE_DEATH
Checks for events that occur more than 60 days after death (PLAUSIBLE_BEFORE_DEATH == Yes).
Denominator is number of events with a non-null date, of persons who died.
Parameters used in this template:
schema = cdm
cdmDatabaseSchema = cdm
cdmTableName = SPECIMEN
cdmFieldName = SPECIMEN_DATE
**********/
SELECT 
    num_violated_rows, 
    CASE 
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM
(
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM
    (
        /*violatedRowsBegin*/
        SELECT 
            'SPECIMEN.SPECIMEN_DATE' AS violating_field, 
            cdmTable.*
        FROM {{ ref('specimen') }} cdmTable
        JOIN {{ ref('death') }} de 
            ON cdmTable.person_id = de.person_id
        WHERE cdmTable.SPECIMEN_DATE IS NOT NULL 
            AND CAST(cdmTable.SPECIMEN_DATE AS DATE) > (de.death_date + 60*INTERVAL'1 day')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
(
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('specimen') }} cdmTable
    JOIN {{ ref('death') }}
        ON death.person_id = cdmTable.person_id
    WHERE cdmTable.SPECIMEN_DATE IS NOT NULL
) denominator
) cte
 UNION ALL /*********
SQL to create query for insertion into results table. These may be unioned together prior to insert.
Note that this does not include information about SQL errors or performance.
**********/
SELECT 
  cte.num_violated_rows
  ,cte.pct_violated_rows
  ,cte.num_denominator_rows
  ,'' as execution_time
  ,'' as query_text
  ,'plausibleBeforeDeath' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a date value in the SPECIMEN_DATETIME field of the SPECIMEN table that occurs after death.' as check_description
  ,'SPECIMEN' as cdm_table_name
  ,'SPECIMEN_DATETIME' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_before_death.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausiblebeforedeath_specimen_specimen_datetime' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_BEFORE_DEATH
Checks for events that occur more than 60 days after death (PLAUSIBLE_BEFORE_DEATH == Yes).
Denominator is number of events with a non-null date, of persons who died.
Parameters used in this template:
schema = cdm
cdmDatabaseSchema = cdm
cdmTableName = SPECIMEN
cdmFieldName = SPECIMEN_DATETIME
**********/
SELECT 
    num_violated_rows, 
    CASE 
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM
(
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM
    (
        /*violatedRowsBegin*/
        SELECT 
            'SPECIMEN.SPECIMEN_DATETIME' AS violating_field, 
            cdmTable.*
        FROM {{ ref('specimen') }} cdmTable
        JOIN {{ ref('death') }} de 
            ON cdmTable.person_id = de.person_id
        WHERE cdmTable.SPECIMEN_DATETIME IS NOT NULL 
            AND CAST(cdmTable.SPECIMEN_DATETIME AS DATE) > (de.death_date + 60*INTERVAL'1 day')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
(
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('specimen') }} cdmTable
    JOIN {{ ref('death') }}
        ON death.person_id = cdmTable.person_id
    WHERE cdmTable.SPECIMEN_DATETIME IS NOT NULL
) denominator
) cte
 UNION ALL /*********
SQL to create query for insertion into results table. These may be unioned together prior to insert.
Note that this does not include information about SQL errors or performance.
**********/
SELECT 
  cte.num_violated_rows
  ,cte.pct_violated_rows
  ,cte.num_denominator_rows
  ,'' as execution_time
  ,'' as query_text
  ,'plausibleBeforeDeath' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a date value in the VISIT_DETAIL_END_DATE field of the VISIT_DETAIL table that occurs after death.' as check_description
  ,'VISIT_DETAIL' as cdm_table_name
  ,'VISIT_DETAIL_END_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_before_death.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausiblebeforedeath_visit_detail_visit_detail_end_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_BEFORE_DEATH
Checks for events that occur more than 60 days after death (PLAUSIBLE_BEFORE_DEATH == Yes).
Denominator is number of events with a non-null date, of persons who died.
Parameters used in this template:
schema = cdm
cdmDatabaseSchema = cdm
cdmTableName = VISIT_DETAIL
cdmFieldName = VISIT_DETAIL_END_DATE
**********/
SELECT 
    num_violated_rows, 
    CASE 
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM
(
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM
    (
        /*violatedRowsBegin*/
        SELECT 
            'VISIT_DETAIL.VISIT_DETAIL_END_DATE' AS violating_field, 
            cdmTable.*
        FROM {{ ref('visit_detail') }} cdmTable
        JOIN {{ ref('death') }} de 
            ON cdmTable.person_id = de.person_id
        WHERE cdmTable.VISIT_DETAIL_END_DATE IS NOT NULL 
            AND CAST(cdmTable.VISIT_DETAIL_END_DATE AS DATE) > (de.death_date + 60*INTERVAL'1 day')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
(
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('visit_detail') }} cdmTable
    JOIN {{ ref('death') }}
        ON death.person_id = cdmTable.person_id
    WHERE cdmTable.VISIT_DETAIL_END_DATE IS NOT NULL
) denominator
) cte
 UNION ALL /*********
SQL to create query for insertion into results table. These may be unioned together prior to insert.
Note that this does not include information about SQL errors or performance.
**********/
SELECT 
  cte.num_violated_rows
  ,cte.pct_violated_rows
  ,cte.num_denominator_rows
  ,'' as execution_time
  ,'' as query_text
  ,'plausibleBeforeDeath' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a date value in the VISIT_DETAIL_END_DATETIME field of the VISIT_DETAIL table that occurs after death.' as check_description
  ,'VISIT_DETAIL' as cdm_table_name
  ,'VISIT_DETAIL_END_DATETIME' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_before_death.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausiblebeforedeath_visit_detail_visit_detail_end_datetime' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_BEFORE_DEATH
Checks for events that occur more than 60 days after death (PLAUSIBLE_BEFORE_DEATH == Yes).
Denominator is number of events with a non-null date, of persons who died.
Parameters used in this template:
schema = cdm
cdmDatabaseSchema = cdm
cdmTableName = VISIT_DETAIL
cdmFieldName = VISIT_DETAIL_END_DATETIME
**********/
SELECT 
    num_violated_rows, 
    CASE 
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM
(
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM
    (
        /*violatedRowsBegin*/
        SELECT 
            'VISIT_DETAIL.VISIT_DETAIL_END_DATETIME' AS violating_field, 
            cdmTable.*
        FROM {{ ref('visit_detail') }} cdmTable
        JOIN {{ ref('death') }} de 
            ON cdmTable.person_id = de.person_id
        WHERE cdmTable.VISIT_DETAIL_END_DATETIME IS NOT NULL 
            AND CAST(cdmTable.VISIT_DETAIL_END_DATETIME AS DATE) > (de.death_date + 60*INTERVAL'1 day')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
(
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('visit_detail') }} cdmTable
    JOIN {{ ref('death') }}
        ON death.person_id = cdmTable.person_id
    WHERE cdmTable.VISIT_DETAIL_END_DATETIME IS NOT NULL
) denominator
) cte
 UNION ALL /*********
SQL to create query for insertion into results table. These may be unioned together prior to insert.
Note that this does not include information about SQL errors or performance.
**********/
SELECT 
  cte.num_violated_rows
  ,cte.pct_violated_rows
  ,cte.num_denominator_rows
  ,'' as execution_time
  ,'' as query_text
  ,'plausibleBeforeDeath' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a date value in the VISIT_DETAIL_START_DATE field of the VISIT_DETAIL table that occurs after death.' as check_description
  ,'VISIT_DETAIL' as cdm_table_name
  ,'VISIT_DETAIL_START_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_before_death.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausiblebeforedeath_visit_detail_visit_detail_start_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_BEFORE_DEATH
Checks for events that occur more than 60 days after death (PLAUSIBLE_BEFORE_DEATH == Yes).
Denominator is number of events with a non-null date, of persons who died.
Parameters used in this template:
schema = cdm
cdmDatabaseSchema = cdm
cdmTableName = VISIT_DETAIL
cdmFieldName = VISIT_DETAIL_START_DATE
**********/
SELECT 
    num_violated_rows, 
    CASE 
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM
(
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM
    (
        /*violatedRowsBegin*/
        SELECT 
            'VISIT_DETAIL.VISIT_DETAIL_START_DATE' AS violating_field, 
            cdmTable.*
        FROM {{ ref('visit_detail') }} cdmTable
        JOIN {{ ref('death') }} de 
            ON cdmTable.person_id = de.person_id
        WHERE cdmTable.VISIT_DETAIL_START_DATE IS NOT NULL 
            AND CAST(cdmTable.VISIT_DETAIL_START_DATE AS DATE) > (de.death_date + 60*INTERVAL'1 day')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
(
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('visit_detail') }} cdmTable
    JOIN {{ ref('death') }}
        ON death.person_id = cdmTable.person_id
    WHERE cdmTable.VISIT_DETAIL_START_DATE IS NOT NULL
) denominator
) cte
 UNION ALL /*********
SQL to create query for insertion into results table. These may be unioned together prior to insert.
Note that this does not include information about SQL errors or performance.
**********/
SELECT 
  cte.num_violated_rows
  ,cte.pct_violated_rows
  ,cte.num_denominator_rows
  ,'' as execution_time
  ,'' as query_text
  ,'plausibleBeforeDeath' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a date value in the VISIT_DETAIL_START_DATETIME field of the VISIT_DETAIL table that occurs after death.' as check_description
  ,'VISIT_DETAIL' as cdm_table_name
  ,'VISIT_DETAIL_START_DATETIME' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_before_death.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausiblebeforedeath_visit_detail_visit_detail_start_datetime' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_BEFORE_DEATH
Checks for events that occur more than 60 days after death (PLAUSIBLE_BEFORE_DEATH == Yes).
Denominator is number of events with a non-null date, of persons who died.
Parameters used in this template:
schema = cdm
cdmDatabaseSchema = cdm
cdmTableName = VISIT_DETAIL
cdmFieldName = VISIT_DETAIL_START_DATETIME
**********/
SELECT 
    num_violated_rows, 
    CASE 
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM
(
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM
    (
        /*violatedRowsBegin*/
        SELECT 
            'VISIT_DETAIL.VISIT_DETAIL_START_DATETIME' AS violating_field, 
            cdmTable.*
        FROM {{ ref('visit_detail') }} cdmTable
        JOIN {{ ref('death') }} de 
            ON cdmTable.person_id = de.person_id
        WHERE cdmTable.VISIT_DETAIL_START_DATETIME IS NOT NULL 
            AND CAST(cdmTable.VISIT_DETAIL_START_DATETIME AS DATE) > (de.death_date + 60*INTERVAL'1 day')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
(
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('visit_detail') }} cdmTable
    JOIN {{ ref('death') }}
        ON death.person_id = cdmTable.person_id
    WHERE cdmTable.VISIT_DETAIL_START_DATETIME IS NOT NULL
) denominator
) cte
 UNION ALL /*********
SQL to create query for insertion into results table. These may be unioned together prior to insert.
Note that this does not include information about SQL errors or performance.
**********/
SELECT 
  cte.num_violated_rows
  ,cte.pct_violated_rows
  ,cte.num_denominator_rows
  ,'' as execution_time
  ,'' as query_text
  ,'plausibleBeforeDeath' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a date value in the VISIT_END_DATE field of the VISIT_OCCURRENCE table that occurs after death.' as check_description
  ,'VISIT_OCCURRENCE' as cdm_table_name
  ,'VISIT_END_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_before_death.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausiblebeforedeath_visit_occurrence_visit_end_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_BEFORE_DEATH
Checks for events that occur more than 60 days after death (PLAUSIBLE_BEFORE_DEATH == Yes).
Denominator is number of events with a non-null date, of persons who died.
Parameters used in this template:
schema = cdm
cdmDatabaseSchema = cdm
cdmTableName = VISIT_OCCURRENCE
cdmFieldName = VISIT_END_DATE
**********/
SELECT 
    num_violated_rows, 
    CASE 
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM
(
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM
    (
        /*violatedRowsBegin*/
        SELECT 
            'VISIT_OCCURRENCE.VISIT_END_DATE' AS violating_field, 
            cdmTable.*
        FROM {{ ref('visit_occurrence') }} cdmTable
        JOIN {{ ref('death') }} de 
            ON cdmTable.person_id = de.person_id
        WHERE cdmTable.VISIT_END_DATE IS NOT NULL 
            AND CAST(cdmTable.VISIT_END_DATE AS DATE) > (de.death_date + 60*INTERVAL'1 day')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
(
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('visit_occurrence') }} cdmTable
    JOIN {{ ref('death') }}
        ON death.person_id = cdmTable.person_id
    WHERE cdmTable.VISIT_END_DATE IS NOT NULL
) denominator
) cte
 UNION ALL /*********
SQL to create query for insertion into results table. These may be unioned together prior to insert.
Note that this does not include information about SQL errors or performance.
**********/
SELECT 
  cte.num_violated_rows
  ,cte.pct_violated_rows
  ,cte.num_denominator_rows
  ,'' as execution_time
  ,'' as query_text
  ,'plausibleBeforeDeath' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a date value in the VISIT_END_DATETIME field of the VISIT_OCCURRENCE table that occurs after death.' as check_description
  ,'VISIT_OCCURRENCE' as cdm_table_name
  ,'VISIT_END_DATETIME' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_before_death.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausiblebeforedeath_visit_occurrence_visit_end_datetime' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_BEFORE_DEATH
Checks for events that occur more than 60 days after death (PLAUSIBLE_BEFORE_DEATH == Yes).
Denominator is number of events with a non-null date, of persons who died.
Parameters used in this template:
schema = cdm
cdmDatabaseSchema = cdm
cdmTableName = VISIT_OCCURRENCE
cdmFieldName = VISIT_END_DATETIME
**********/
SELECT 
    num_violated_rows, 
    CASE 
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM
(
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM
    (
        /*violatedRowsBegin*/
        SELECT 
            'VISIT_OCCURRENCE.VISIT_END_DATETIME' AS violating_field, 
            cdmTable.*
        FROM {{ ref('visit_occurrence') }} cdmTable
        JOIN {{ ref('death') }} de 
            ON cdmTable.person_id = de.person_id
        WHERE cdmTable.VISIT_END_DATETIME IS NOT NULL 
            AND CAST(cdmTable.VISIT_END_DATETIME AS DATE) > (de.death_date + 60*INTERVAL'1 day')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
(
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('visit_occurrence') }} cdmTable
    JOIN {{ ref('death') }}
        ON death.person_id = cdmTable.person_id
    WHERE cdmTable.VISIT_END_DATETIME IS NOT NULL
) denominator
) cte
 UNION ALL /*********
SQL to create query for insertion into results table. These may be unioned together prior to insert.
Note that this does not include information about SQL errors or performance.
**********/
SELECT 
  cte.num_violated_rows
  ,cte.pct_violated_rows
  ,cte.num_denominator_rows
  ,'' as execution_time
  ,'' as query_text
  ,'plausibleBeforeDeath' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a date value in the VISIT_START_DATE field of the VISIT_OCCURRENCE table that occurs after death.' as check_description
  ,'VISIT_OCCURRENCE' as cdm_table_name
  ,'VISIT_START_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_before_death.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausiblebeforedeath_visit_occurrence_visit_start_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_BEFORE_DEATH
Checks for events that occur more than 60 days after death (PLAUSIBLE_BEFORE_DEATH == Yes).
Denominator is number of events with a non-null date, of persons who died.
Parameters used in this template:
schema = cdm
cdmDatabaseSchema = cdm
cdmTableName = VISIT_OCCURRENCE
cdmFieldName = VISIT_START_DATE
**********/
SELECT 
    num_violated_rows, 
    CASE 
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM
(
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM
    (
        /*violatedRowsBegin*/
        SELECT 
            'VISIT_OCCURRENCE.VISIT_START_DATE' AS violating_field, 
            cdmTable.*
        FROM {{ ref('visit_occurrence') }} cdmTable
        JOIN {{ ref('death') }} de 
            ON cdmTable.person_id = de.person_id
        WHERE cdmTable.VISIT_START_DATE IS NOT NULL 
            AND CAST(cdmTable.VISIT_START_DATE AS DATE) > (de.death_date + 60*INTERVAL'1 day')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
(
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('visit_occurrence') }} cdmTable
    JOIN {{ ref('death') }}
        ON death.person_id = cdmTable.person_id
    WHERE cdmTable.VISIT_START_DATE IS NOT NULL
) denominator
) cte
 UNION ALL /*********
SQL to create query for insertion into results table. These may be unioned together prior to insert.
Note that this does not include information about SQL errors or performance.
**********/
SELECT 
  cte.num_violated_rows
  ,cte.pct_violated_rows
  ,cte.num_denominator_rows
  ,'' as execution_time
  ,'' as query_text
  ,'plausibleBeforeDeath' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a date value in the VISIT_START_DATETIME field of the VISIT_OCCURRENCE table that occurs after death.' as check_description
  ,'VISIT_OCCURRENCE' as cdm_table_name
  ,'VISIT_START_DATETIME' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_before_death.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausiblebeforedeath_visit_occurrence_visit_start_datetime' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_BEFORE_DEATH
Checks for events that occur more than 60 days after death (PLAUSIBLE_BEFORE_DEATH == Yes).
Denominator is number of events with a non-null date, of persons who died.
Parameters used in this template:
schema = cdm
cdmDatabaseSchema = cdm
cdmTableName = VISIT_OCCURRENCE
cdmFieldName = VISIT_START_DATETIME
**********/
SELECT 
    num_violated_rows, 
    CASE 
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM
(
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM
    (
        /*violatedRowsBegin*/
        SELECT 
            'VISIT_OCCURRENCE.VISIT_START_DATETIME' AS violating_field, 
            cdmTable.*
        FROM {{ ref('visit_occurrence') }} cdmTable
        JOIN {{ ref('death') }} de 
            ON cdmTable.person_id = de.person_id
        WHERE cdmTable.VISIT_START_DATETIME IS NOT NULL 
            AND CAST(cdmTable.VISIT_START_DATETIME AS DATE) > (de.death_date + 60*INTERVAL'1 day')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
(
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('visit_occurrence') }} cdmTable
    JOIN {{ ref('death') }}
        ON death.person_id = cdmTable.person_id
    WHERE cdmTable.VISIT_START_DATETIME IS NOT NULL
) denominator
) cte
)
SELECT * FROM cte_all
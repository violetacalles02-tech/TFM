

/*********
SQL to insert individual DQD results directly into output table, rather than waiting until collecting all results.
Note that this  does not include information about SQL errors or performance
**********/
WITH cte_all  AS (SELECT cte.num_violated_rows
  ,cte.pct_violated_rows
  ,cte.num_denominator_rows
  , CAST('' as TEXT) as execution_time
  ,'' as query_text
  ,'plausibleStartBeforeEnd' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a value in the SOURCE_RELEASE_DATE field of the CDM_SOURCE that occurs after the date in the SOURCE_RELEASE_DATE.' as check_description
  ,'CDM_SOURCE' as cdm_table_name
  ,'SOURCE_RELEASE_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_start_before_end.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausiblestartbeforeend_cdm_source_source_release_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_START_BEFORE_END
Checks that all start dates are before their corresponding end dates (PLAUSIBLE_START_BEFORE_END == Yes).
SOURCE_RELEASE_DATE is the start date and SOURCE_RELEASE_DATE is the end date.
Parameters used in this template:
schema = cdm
cdmTableName = CDM_SOURCE
cdmFieldName = SOURCE_RELEASE_DATE
plausibleStartBeforeEndFieldName = SOURCE_RELEASE_DATE
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
            'CDM_SOURCE.SOURCE_RELEASE_DATE' AS violating_field, 
            cdmTable.*
        FROM {{ ref('cdm_source') }} cdmTable
        WHERE cdmTable.SOURCE_RELEASE_DATE IS NOT NULL 
            AND cdmTable.SOURCE_RELEASE_DATE IS NOT NULL 
            AND CAST(cdmTable.SOURCE_RELEASE_DATE AS DATE) > CAST(cdmTable.SOURCE_RELEASE_DATE AS DATE)
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
(
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('cdm_source') }} cdmTable
    WHERE cdmTable.SOURCE_RELEASE_DATE IS NOT NULL 
        AND cdmTable.SOURCE_RELEASE_DATE IS NOT NULL
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
  ,'plausibleStartBeforeEnd' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a value in the CONDITION_ERA_START_DATE field of the CONDITION_ERA that occurs after the date in the CONDITION_ERA_END_DATE.' as check_description
  ,'CONDITION_ERA' as cdm_table_name
  ,'CONDITION_ERA_START_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_start_before_end.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausiblestartbeforeend_condition_era_condition_era_start_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_START_BEFORE_END
Checks that all start dates are before their corresponding end dates (PLAUSIBLE_START_BEFORE_END == Yes).
CONDITION_ERA_START_DATE is the start date and CONDITION_ERA_END_DATE is the end date.
Parameters used in this template:
schema = cdm
cdmTableName = CONDITION_ERA
cdmFieldName = CONDITION_ERA_START_DATE
plausibleStartBeforeEndFieldName = CONDITION_ERA_END_DATE
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
        WHERE cdmTable.CONDITION_ERA_START_DATE IS NOT NULL 
            AND cdmTable.CONDITION_ERA_END_DATE IS NOT NULL 
            AND CAST(cdmTable.CONDITION_ERA_START_DATE AS DATE) > CAST(cdmTable.CONDITION_ERA_END_DATE AS DATE)
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
(
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('condition_era') }} cdmTable
    WHERE cdmTable.CONDITION_ERA_START_DATE IS NOT NULL 
        AND cdmTable.CONDITION_ERA_END_DATE IS NOT NULL
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
  ,'plausibleStartBeforeEnd' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a value in the CONDITION_START_DATE field of the CONDITION_OCCURRENCE that occurs after the date in the CONDITION_END_DATE.' as check_description
  ,'CONDITION_OCCURRENCE' as cdm_table_name
  ,'CONDITION_START_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_start_before_end.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausiblestartbeforeend_condition_occurrence_condition_start_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_START_BEFORE_END
Checks that all start dates are before their corresponding end dates (PLAUSIBLE_START_BEFORE_END == Yes).
CONDITION_START_DATE is the start date and CONDITION_END_DATE is the end date.
Parameters used in this template:
schema = cdm
cdmTableName = CONDITION_OCCURRENCE
cdmFieldName = CONDITION_START_DATE
plausibleStartBeforeEndFieldName = CONDITION_END_DATE
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
        WHERE cdmTable.CONDITION_START_DATE IS NOT NULL 
            AND cdmTable.CONDITION_END_DATE IS NOT NULL 
            AND CAST(cdmTable.CONDITION_START_DATE AS DATE) > CAST(cdmTable.CONDITION_END_DATE AS DATE)
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
(
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('condition_occurrence') }} cdmTable
    WHERE cdmTable.CONDITION_START_DATE IS NOT NULL 
        AND cdmTable.CONDITION_END_DATE IS NOT NULL
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
  ,'plausibleStartBeforeEnd' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a value in the CONDITION_START_DATETIME field of the CONDITION_OCCURRENCE that occurs after the date in the CONDITION_END_DATETIME.' as check_description
  ,'CONDITION_OCCURRENCE' as cdm_table_name
  ,'CONDITION_START_DATETIME' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_start_before_end.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausiblestartbeforeend_condition_occurrence_condition_start_datetime' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_START_BEFORE_END
Checks that all start dates are before their corresponding end dates (PLAUSIBLE_START_BEFORE_END == Yes).
CONDITION_START_DATETIME is the start date and CONDITION_END_DATETIME is the end date.
Parameters used in this template:
schema = cdm
cdmTableName = CONDITION_OCCURRENCE
cdmFieldName = CONDITION_START_DATETIME
plausibleStartBeforeEndFieldName = CONDITION_END_DATETIME
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
        WHERE cdmTable.CONDITION_START_DATETIME IS NOT NULL 
            AND cdmTable.CONDITION_END_DATETIME IS NOT NULL 
            AND CAST(cdmTable.CONDITION_START_DATETIME AS DATE) > CAST(cdmTable.CONDITION_END_DATETIME AS DATE)
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
(
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('condition_occurrence') }} cdmTable
    WHERE cdmTable.CONDITION_START_DATETIME IS NOT NULL 
        AND cdmTable.CONDITION_END_DATETIME IS NOT NULL
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
  ,'plausibleStartBeforeEnd' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a value in the DEVICE_EXPOSURE_START_DATE field of the DEVICE_EXPOSURE that occurs after the date in the DEVICE_EXPOSURE_END_DATE.' as check_description
  ,'DEVICE_EXPOSURE' as cdm_table_name
  ,'DEVICE_EXPOSURE_START_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_start_before_end.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausiblestartbeforeend_device_exposure_device_exposure_start_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_START_BEFORE_END
Checks that all start dates are before their corresponding end dates (PLAUSIBLE_START_BEFORE_END == Yes).
DEVICE_EXPOSURE_START_DATE is the start date and DEVICE_EXPOSURE_END_DATE is the end date.
Parameters used in this template:
schema = cdm
cdmTableName = DEVICE_EXPOSURE
cdmFieldName = DEVICE_EXPOSURE_START_DATE
plausibleStartBeforeEndFieldName = DEVICE_EXPOSURE_END_DATE
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
        WHERE cdmTable.DEVICE_EXPOSURE_START_DATE IS NOT NULL 
            AND cdmTable.DEVICE_EXPOSURE_END_DATE IS NOT NULL 
            AND CAST(cdmTable.DEVICE_EXPOSURE_START_DATE AS DATE) > CAST(cdmTable.DEVICE_EXPOSURE_END_DATE AS DATE)
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
(
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('device_exposure') }} cdmTable
    WHERE cdmTable.DEVICE_EXPOSURE_START_DATE IS NOT NULL 
        AND cdmTable.DEVICE_EXPOSURE_END_DATE IS NOT NULL
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
  ,'plausibleStartBeforeEnd' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a value in the DEVICE_EXPOSURE_START_DATETIME field of the DEVICE_EXPOSURE that occurs after the date in the DEVICE_EXPOSURE_END_DATETIME.' as check_description
  ,'DEVICE_EXPOSURE' as cdm_table_name
  ,'DEVICE_EXPOSURE_START_DATETIME' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_start_before_end.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausiblestartbeforeend_device_exposure_device_exposure_start_datetime' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_START_BEFORE_END
Checks that all start dates are before their corresponding end dates (PLAUSIBLE_START_BEFORE_END == Yes).
DEVICE_EXPOSURE_START_DATETIME is the start date and DEVICE_EXPOSURE_END_DATETIME is the end date.
Parameters used in this template:
schema = cdm
cdmTableName = DEVICE_EXPOSURE
cdmFieldName = DEVICE_EXPOSURE_START_DATETIME
plausibleStartBeforeEndFieldName = DEVICE_EXPOSURE_END_DATETIME
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
        WHERE cdmTable.DEVICE_EXPOSURE_START_DATETIME IS NOT NULL 
            AND cdmTable.DEVICE_EXPOSURE_END_DATETIME IS NOT NULL 
            AND CAST(cdmTable.DEVICE_EXPOSURE_START_DATETIME AS DATE) > CAST(cdmTable.DEVICE_EXPOSURE_END_DATETIME AS DATE)
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
(
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('device_exposure') }} cdmTable
    WHERE cdmTable.DEVICE_EXPOSURE_START_DATETIME IS NOT NULL 
        AND cdmTable.DEVICE_EXPOSURE_END_DATETIME IS NOT NULL
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
  ,'plausibleStartBeforeEnd' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a value in the DOSE_ERA_START_DATE field of the DOSE_ERA that occurs after the date in the DOSE_ERA_END_DATE.' as check_description
  ,'DOSE_ERA' as cdm_table_name
  ,'DOSE_ERA_START_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_start_before_end.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausiblestartbeforeend_dose_era_dose_era_start_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_START_BEFORE_END
Checks that all start dates are before their corresponding end dates (PLAUSIBLE_START_BEFORE_END == Yes).
DOSE_ERA_START_DATE is the start date and DOSE_ERA_END_DATE is the end date.
Parameters used in this template:
schema = cdm
cdmTableName = DOSE_ERA
cdmFieldName = DOSE_ERA_START_DATE
plausibleStartBeforeEndFieldName = DOSE_ERA_END_DATE
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
        WHERE cdmTable.DOSE_ERA_START_DATE IS NOT NULL 
            AND cdmTable.DOSE_ERA_END_DATE IS NOT NULL 
            AND CAST(cdmTable.DOSE_ERA_START_DATE AS DATE) > CAST(cdmTable.DOSE_ERA_END_DATE AS DATE)
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
(
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('dose_era') }} cdmTable
    WHERE cdmTable.DOSE_ERA_START_DATE IS NOT NULL 
        AND cdmTable.DOSE_ERA_END_DATE IS NOT NULL
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
  ,'plausibleStartBeforeEnd' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a value in the DRUG_ERA_START_DATE field of the DRUG_ERA that occurs after the date in the DRUG_ERA_END_DATE.' as check_description
  ,'DRUG_ERA' as cdm_table_name
  ,'DRUG_ERA_START_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_start_before_end.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausiblestartbeforeend_drug_era_drug_era_start_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_START_BEFORE_END
Checks that all start dates are before their corresponding end dates (PLAUSIBLE_START_BEFORE_END == Yes).
DRUG_ERA_START_DATE is the start date and DRUG_ERA_END_DATE is the end date.
Parameters used in this template:
schema = cdm
cdmTableName = DRUG_ERA
cdmFieldName = DRUG_ERA_START_DATE
plausibleStartBeforeEndFieldName = DRUG_ERA_END_DATE
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
        WHERE cdmTable.DRUG_ERA_START_DATE IS NOT NULL 
            AND cdmTable.DRUG_ERA_END_DATE IS NOT NULL 
            AND CAST(cdmTable.DRUG_ERA_START_DATE AS DATE) > CAST(cdmTable.DRUG_ERA_END_DATE AS DATE)
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
(
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('drug_era') }} cdmTable
    WHERE cdmTable.DRUG_ERA_START_DATE IS NOT NULL 
        AND cdmTable.DRUG_ERA_END_DATE IS NOT NULL
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
  ,'plausibleStartBeforeEnd' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a value in the DRUG_EXPOSURE_START_DATE field of the DRUG_EXPOSURE that occurs after the date in the DRUG_EXPOSURE_END_DATE.' as check_description
  ,'DRUG_EXPOSURE' as cdm_table_name
  ,'DRUG_EXPOSURE_START_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_start_before_end.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausiblestartbeforeend_drug_exposure_drug_exposure_start_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_START_BEFORE_END
Checks that all start dates are before their corresponding end dates (PLAUSIBLE_START_BEFORE_END == Yes).
DRUG_EXPOSURE_START_DATE is the start date and DRUG_EXPOSURE_END_DATE is the end date.
Parameters used in this template:
schema = cdm
cdmTableName = DRUG_EXPOSURE
cdmFieldName = DRUG_EXPOSURE_START_DATE
plausibleStartBeforeEndFieldName = DRUG_EXPOSURE_END_DATE
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
        WHERE cdmTable.DRUG_EXPOSURE_START_DATE IS NOT NULL 
            AND cdmTable.DRUG_EXPOSURE_END_DATE IS NOT NULL 
            AND CAST(cdmTable.DRUG_EXPOSURE_START_DATE AS DATE) > CAST(cdmTable.DRUG_EXPOSURE_END_DATE AS DATE)
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
(
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('drug_exposure') }} cdmTable
    WHERE cdmTable.DRUG_EXPOSURE_START_DATE IS NOT NULL 
        AND cdmTable.DRUG_EXPOSURE_END_DATE IS NOT NULL
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
  ,'plausibleStartBeforeEnd' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a value in the DRUG_EXPOSURE_START_DATETIME field of the DRUG_EXPOSURE that occurs after the date in the DRUG_EXPOSURE_END_DATETIME.' as check_description
  ,'DRUG_EXPOSURE' as cdm_table_name
  ,'DRUG_EXPOSURE_START_DATETIME' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_start_before_end.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausiblestartbeforeend_drug_exposure_drug_exposure_start_datetime' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_START_BEFORE_END
Checks that all start dates are before their corresponding end dates (PLAUSIBLE_START_BEFORE_END == Yes).
DRUG_EXPOSURE_START_DATETIME is the start date and DRUG_EXPOSURE_END_DATETIME is the end date.
Parameters used in this template:
schema = cdm
cdmTableName = DRUG_EXPOSURE
cdmFieldName = DRUG_EXPOSURE_START_DATETIME
plausibleStartBeforeEndFieldName = DRUG_EXPOSURE_END_DATETIME
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
        WHERE cdmTable.DRUG_EXPOSURE_START_DATETIME IS NOT NULL 
            AND cdmTable.DRUG_EXPOSURE_END_DATETIME IS NOT NULL 
            AND CAST(cdmTable.DRUG_EXPOSURE_START_DATETIME AS DATE) > CAST(cdmTable.DRUG_EXPOSURE_END_DATETIME AS DATE)
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
(
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('drug_exposure') }} cdmTable
    WHERE cdmTable.DRUG_EXPOSURE_START_DATETIME IS NOT NULL 
        AND cdmTable.DRUG_EXPOSURE_END_DATETIME IS NOT NULL
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
  ,'plausibleStartBeforeEnd' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a value in the EPISODE_START_DATE field of the EPISODE that occurs after the date in the EPISODE_END_DATE.' as check_description
  ,'EPISODE' as cdm_table_name
  ,'EPISODE_START_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_start_before_end.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausiblestartbeforeend_episode_episode_start_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_START_BEFORE_END
Checks that all start dates are before their corresponding end dates (PLAUSIBLE_START_BEFORE_END == Yes).
EPISODE_START_DATE is the start date and EPISODE_END_DATE is the end date.
Parameters used in this template:
schema = cdm
cdmTableName = EPISODE
cdmFieldName = EPISODE_START_DATE
plausibleStartBeforeEndFieldName = EPISODE_END_DATE
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
        WHERE cdmTable.EPISODE_START_DATE IS NOT NULL 
            AND cdmTable.EPISODE_END_DATE IS NOT NULL 
            AND CAST(cdmTable.EPISODE_START_DATE AS DATE) > CAST(cdmTable.EPISODE_END_DATE AS DATE)
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
(
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('episode') }} cdmTable
    WHERE cdmTable.EPISODE_START_DATE IS NOT NULL 
        AND cdmTable.EPISODE_END_DATE IS NOT NULL
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
  ,'plausibleStartBeforeEnd' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a value in the EPISODE_START_DATETIME field of the EPISODE that occurs after the date in the EPISODE_END_DATETIME.' as check_description
  ,'EPISODE' as cdm_table_name
  ,'EPISODE_START_DATETIME' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_start_before_end.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausiblestartbeforeend_episode_episode_start_datetime' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_START_BEFORE_END
Checks that all start dates are before their corresponding end dates (PLAUSIBLE_START_BEFORE_END == Yes).
EPISODE_START_DATETIME is the start date and EPISODE_END_DATETIME is the end date.
Parameters used in this template:
schema = cdm
cdmTableName = EPISODE
cdmFieldName = EPISODE_START_DATETIME
plausibleStartBeforeEndFieldName = EPISODE_END_DATETIME
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
        WHERE cdmTable.EPISODE_START_DATETIME IS NOT NULL 
            AND cdmTable.EPISODE_END_DATETIME IS NOT NULL 
            AND CAST(cdmTable.EPISODE_START_DATETIME AS DATE) > CAST(cdmTable.EPISODE_END_DATETIME AS DATE)
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
(
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('episode') }} cdmTable
    WHERE cdmTable.EPISODE_START_DATETIME IS NOT NULL 
        AND cdmTable.EPISODE_END_DATETIME IS NOT NULL
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
  ,'plausibleStartBeforeEnd' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a value in the OBSERVATION_PERIOD_START_DATE field of the OBSERVATION_PERIOD that occurs after the date in the OBSERVATION_PERIOD_END_DATE.' as check_description
  ,'OBSERVATION_PERIOD' as cdm_table_name
  ,'OBSERVATION_PERIOD_START_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_start_before_end.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausiblestartbeforeend_observation_period_observation_period_start_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_START_BEFORE_END
Checks that all start dates are before their corresponding end dates (PLAUSIBLE_START_BEFORE_END == Yes).
OBSERVATION_PERIOD_START_DATE is the start date and OBSERVATION_PERIOD_END_DATE is the end date.
Parameters used in this template:
schema = cdm
cdmTableName = OBSERVATION_PERIOD
cdmFieldName = OBSERVATION_PERIOD_START_DATE
plausibleStartBeforeEndFieldName = OBSERVATION_PERIOD_END_DATE
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
        WHERE cdmTable.OBSERVATION_PERIOD_START_DATE IS NOT NULL 
            AND cdmTable.OBSERVATION_PERIOD_END_DATE IS NOT NULL 
            AND CAST(cdmTable.OBSERVATION_PERIOD_START_DATE AS DATE) > CAST(cdmTable.OBSERVATION_PERIOD_END_DATE AS DATE)
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
(
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('observation_period') }} cdmTable
    WHERE cdmTable.OBSERVATION_PERIOD_START_DATE IS NOT NULL 
        AND cdmTable.OBSERVATION_PERIOD_END_DATE IS NOT NULL
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
  ,'plausibleStartBeforeEnd' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a value in the PAYER_PLAN_PERIOD_START_DATE field of the PAYER_PLAN_PERIOD that occurs after the date in the PAYER_PLAN_PERIOD_END_DATE.' as check_description
  ,'PAYER_PLAN_PERIOD' as cdm_table_name
  ,'PAYER_PLAN_PERIOD_START_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_start_before_end.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausiblestartbeforeend_payer_plan_period_payer_plan_period_start_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_START_BEFORE_END
Checks that all start dates are before their corresponding end dates (PLAUSIBLE_START_BEFORE_END == Yes).
PAYER_PLAN_PERIOD_START_DATE is the start date and PAYER_PLAN_PERIOD_END_DATE is the end date.
Parameters used in this template:
schema = cdm
cdmTableName = PAYER_PLAN_PERIOD
cdmFieldName = PAYER_PLAN_PERIOD_START_DATE
plausibleStartBeforeEndFieldName = PAYER_PLAN_PERIOD_END_DATE
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
        WHERE cdmTable.PAYER_PLAN_PERIOD_START_DATE IS NOT NULL 
            AND cdmTable.PAYER_PLAN_PERIOD_END_DATE IS NOT NULL 
            AND CAST(cdmTable.PAYER_PLAN_PERIOD_START_DATE AS DATE) > CAST(cdmTable.PAYER_PLAN_PERIOD_END_DATE AS DATE)
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
(
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('payer_plan_period') }} cdmTable
    WHERE cdmTable.PAYER_PLAN_PERIOD_START_DATE IS NOT NULL 
        AND cdmTable.PAYER_PLAN_PERIOD_END_DATE IS NOT NULL
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
  ,'plausibleStartBeforeEnd' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a value in the PROCEDURE_DATE field of the PROCEDURE_OCCURRENCE that occurs after the date in the PROCEDURE_END_DATE.' as check_description
  ,'PROCEDURE_OCCURRENCE' as cdm_table_name
  ,'PROCEDURE_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_start_before_end.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausiblestartbeforeend_procedure_occurrence_procedure_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_START_BEFORE_END
Checks that all start dates are before their corresponding end dates (PLAUSIBLE_START_BEFORE_END == Yes).
PROCEDURE_DATE is the start date and PROCEDURE_END_DATE is the end date.
Parameters used in this template:
schema = cdm
cdmTableName = PROCEDURE_OCCURRENCE
cdmFieldName = PROCEDURE_DATE
plausibleStartBeforeEndFieldName = PROCEDURE_END_DATE
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
        WHERE cdmTable.PROCEDURE_DATE IS NOT NULL 
            AND cdmTable.PROCEDURE_END_DATE IS NOT NULL 
            AND CAST(cdmTable.PROCEDURE_DATE AS DATE) > CAST(cdmTable.PROCEDURE_END_DATE AS DATE)
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
(
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('procedure_occurrence') }} cdmTable
    WHERE cdmTable.PROCEDURE_DATE IS NOT NULL 
        AND cdmTable.PROCEDURE_END_DATE IS NOT NULL
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
  ,'plausibleStartBeforeEnd' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a value in the PROCEDURE_DATETIME field of the PROCEDURE_OCCURRENCE that occurs after the date in the PROCEDURE_END_DATETIME.' as check_description
  ,'PROCEDURE_OCCURRENCE' as cdm_table_name
  ,'PROCEDURE_DATETIME' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_start_before_end.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausiblestartbeforeend_procedure_occurrence_procedure_datetime' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_START_BEFORE_END
Checks that all start dates are before their corresponding end dates (PLAUSIBLE_START_BEFORE_END == Yes).
PROCEDURE_DATETIME is the start date and PROCEDURE_END_DATETIME is the end date.
Parameters used in this template:
schema = cdm
cdmTableName = PROCEDURE_OCCURRENCE
cdmFieldName = PROCEDURE_DATETIME
plausibleStartBeforeEndFieldName = PROCEDURE_END_DATETIME
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
        WHERE cdmTable.PROCEDURE_DATETIME IS NOT NULL 
            AND cdmTable.PROCEDURE_END_DATETIME IS NOT NULL 
            AND CAST(cdmTable.PROCEDURE_DATETIME AS DATE) > CAST(cdmTable.PROCEDURE_END_DATETIME AS DATE)
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
(
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('procedure_occurrence') }} cdmTable
    WHERE cdmTable.PROCEDURE_DATETIME IS NOT NULL 
        AND cdmTable.PROCEDURE_END_DATETIME IS NOT NULL
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
  ,'plausibleStartBeforeEnd' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a value in the VISIT_DETAIL_START_DATE field of the VISIT_DETAIL that occurs after the date in the VISIT_DETAIL_END_DATE.' as check_description
  ,'VISIT_DETAIL' as cdm_table_name
  ,'VISIT_DETAIL_START_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_start_before_end.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausiblestartbeforeend_visit_detail_visit_detail_start_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_START_BEFORE_END
Checks that all start dates are before their corresponding end dates (PLAUSIBLE_START_BEFORE_END == Yes).
VISIT_DETAIL_START_DATE is the start date and VISIT_DETAIL_END_DATE is the end date.
Parameters used in this template:
schema = cdm
cdmTableName = VISIT_DETAIL
cdmFieldName = VISIT_DETAIL_START_DATE
plausibleStartBeforeEndFieldName = VISIT_DETAIL_END_DATE
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
        WHERE cdmTable.VISIT_DETAIL_START_DATE IS NOT NULL 
            AND cdmTable.VISIT_DETAIL_END_DATE IS NOT NULL 
            AND CAST(cdmTable.VISIT_DETAIL_START_DATE AS DATE) > CAST(cdmTable.VISIT_DETAIL_END_DATE AS DATE)
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
(
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('visit_detail') }} cdmTable
    WHERE cdmTable.VISIT_DETAIL_START_DATE IS NOT NULL 
        AND cdmTable.VISIT_DETAIL_END_DATE IS NOT NULL
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
  ,'plausibleStartBeforeEnd' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a value in the VISIT_DETAIL_START_DATETIME field of the VISIT_DETAIL that occurs after the date in the VISIT_DETAIL_END_DATETIME.' as check_description
  ,'VISIT_DETAIL' as cdm_table_name
  ,'VISIT_DETAIL_START_DATETIME' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_start_before_end.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausiblestartbeforeend_visit_detail_visit_detail_start_datetime' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_START_BEFORE_END
Checks that all start dates are before their corresponding end dates (PLAUSIBLE_START_BEFORE_END == Yes).
VISIT_DETAIL_START_DATETIME is the start date and VISIT_DETAIL_END_DATETIME is the end date.
Parameters used in this template:
schema = cdm
cdmTableName = VISIT_DETAIL
cdmFieldName = VISIT_DETAIL_START_DATETIME
plausibleStartBeforeEndFieldName = VISIT_DETAIL_END_DATETIME
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
        WHERE cdmTable.VISIT_DETAIL_START_DATETIME IS NOT NULL 
            AND cdmTable.VISIT_DETAIL_END_DATETIME IS NOT NULL 
            AND CAST(cdmTable.VISIT_DETAIL_START_DATETIME AS DATE) > CAST(cdmTable.VISIT_DETAIL_END_DATETIME AS DATE)
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
(
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('visit_detail') }} cdmTable
    WHERE cdmTable.VISIT_DETAIL_START_DATETIME IS NOT NULL 
        AND cdmTable.VISIT_DETAIL_END_DATETIME IS NOT NULL
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
  ,'plausibleStartBeforeEnd' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a value in the VISIT_START_DATE field of the VISIT_OCCURRENCE that occurs after the date in the VISIT_END_DATE.' as check_description
  ,'VISIT_OCCURRENCE' as cdm_table_name
  ,'VISIT_START_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_start_before_end.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausiblestartbeforeend_visit_occurrence_visit_start_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_START_BEFORE_END
Checks that all start dates are before their corresponding end dates (PLAUSIBLE_START_BEFORE_END == Yes).
VISIT_START_DATE is the start date and VISIT_END_DATE is the end date.
Parameters used in this template:
schema = cdm
cdmTableName = VISIT_OCCURRENCE
cdmFieldName = VISIT_START_DATE
plausibleStartBeforeEndFieldName = VISIT_END_DATE
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
        WHERE cdmTable.VISIT_START_DATE IS NOT NULL 
            AND cdmTable.VISIT_END_DATE IS NOT NULL 
            AND CAST(cdmTable.VISIT_START_DATE AS DATE) > CAST(cdmTable.VISIT_END_DATE AS DATE)
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
(
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('visit_occurrence') }} cdmTable
    WHERE cdmTable.VISIT_START_DATE IS NOT NULL 
        AND cdmTable.VISIT_END_DATE IS NOT NULL
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
  ,'plausibleStartBeforeEnd' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a value in the VISIT_START_DATETIME field of the VISIT_OCCURRENCE that occurs after the date in the VISIT_END_DATETIME.' as check_description
  ,'VISIT_OCCURRENCE' as cdm_table_name
  ,'VISIT_START_DATETIME' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_start_before_end.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausiblestartbeforeend_visit_occurrence_visit_start_datetime' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_START_BEFORE_END
Checks that all start dates are before their corresponding end dates (PLAUSIBLE_START_BEFORE_END == Yes).
VISIT_START_DATETIME is the start date and VISIT_END_DATETIME is the end date.
Parameters used in this template:
schema = cdm
cdmTableName = VISIT_OCCURRENCE
cdmFieldName = VISIT_START_DATETIME
plausibleStartBeforeEndFieldName = VISIT_END_DATETIME
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
        WHERE cdmTable.VISIT_START_DATETIME IS NOT NULL 
            AND cdmTable.VISIT_END_DATETIME IS NOT NULL 
            AND CAST(cdmTable.VISIT_START_DATETIME AS DATE) > CAST(cdmTable.VISIT_END_DATETIME AS DATE)
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
(
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('visit_occurrence') }} cdmTable
    WHERE cdmTable.VISIT_START_DATETIME IS NOT NULL 
        AND cdmTable.VISIT_END_DATETIME IS NOT NULL
) denominator
) cte
)
SELECT * FROM cte_all
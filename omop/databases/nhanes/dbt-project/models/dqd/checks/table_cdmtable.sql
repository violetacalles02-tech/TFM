

/*********
SQL to insert individual DQD results directly into output table, rather than waiting until collecting all results.
Note that this  does not include information about SQL errors or performance
**********/
WITH cte_all  AS (SELECT cte.num_violated_rows
  ,cte.pct_violated_rows
  ,cte.num_denominator_rows
  , CAST('' as TEXT) as execution_time
  ,'' as query_text
  ,'cdmTable' as check_name
  ,'TABLE' as check_level
  ,'A yes or no value indicating if PERSON table is present as expected based on the specification.' as check_description
  ,'PERSON' as cdm_table_name
  ,'NA' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'table_cdm_table.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'table_cdmtable_person' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
CDM_TABLE
Verify the table exists.
Parameters used in this template:
schema = cdm
cdmTableName = PERSON
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
        num_violated_rows 
    FROM
    (
        SELECT
            CASE 
                WHEN COUNT(*) = 0 THEN 0
                ELSE 0
            END AS num_violated_rows
        FROM {{ ref('person') }} cdmTable
    ) violated_rows
) violated_row_count,
( 
    SELECT 1 AS num_rows
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
  ,'cdmTable' as check_name
  ,'TABLE' as check_level
  ,'A yes or no value indicating if OBSERVATION_PERIOD table is present as expected based on the specification.' as check_description
  ,'OBSERVATION_PERIOD' as cdm_table_name
  ,'NA' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'table_cdm_table.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'table_cdmtable_observation_period' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
CDM_TABLE
Verify the table exists.
Parameters used in this template:
schema = cdm
cdmTableName = OBSERVATION_PERIOD
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
        num_violated_rows 
    FROM
    (
        SELECT
            CASE 
                WHEN COUNT(*) = 0 THEN 0
                ELSE 0
            END AS num_violated_rows
        FROM {{ ref('observation_period') }} cdmTable
    ) violated_rows
) violated_row_count,
( 
    SELECT 1 AS num_rows
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
  ,'cdmTable' as check_name
  ,'TABLE' as check_level
  ,'A yes or no value indicating if VISIT_OCCURRENCE table is present as expected based on the specification.' as check_description
  ,'VISIT_OCCURRENCE' as cdm_table_name
  ,'NA' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'table_cdm_table.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'table_cdmtable_visit_occurrence' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
CDM_TABLE
Verify the table exists.
Parameters used in this template:
schema = cdm
cdmTableName = VISIT_OCCURRENCE
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
        num_violated_rows 
    FROM
    (
        SELECT
            CASE 
                WHEN COUNT(*) = 0 THEN 0
                ELSE 0
            END AS num_violated_rows
        FROM {{ ref('visit_occurrence') }} cdmTable
    ) violated_rows
) violated_row_count,
( 
    SELECT 1 AS num_rows
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
  ,'cdmTable' as check_name
  ,'TABLE' as check_level
  ,'A yes or no value indicating if VISIT_DETAIL table is present as expected based on the specification.' as check_description
  ,'VISIT_DETAIL' as cdm_table_name
  ,'NA' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'table_cdm_table.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'table_cdmtable_visit_detail' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
CDM_TABLE
Verify the table exists.
Parameters used in this template:
schema = cdm
cdmTableName = VISIT_DETAIL
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
        num_violated_rows 
    FROM
    (
        SELECT
            CASE 
                WHEN COUNT(*) = 0 THEN 0
                ELSE 0
            END AS num_violated_rows
        FROM {{ ref('visit_detail') }} cdmTable
    ) violated_rows
) violated_row_count,
( 
    SELECT 1 AS num_rows
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
  ,'cdmTable' as check_name
  ,'TABLE' as check_level
  ,'A yes or no value indicating if CONDITION_OCCURRENCE table is present as expected based on the specification.' as check_description
  ,'CONDITION_OCCURRENCE' as cdm_table_name
  ,'NA' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'table_cdm_table.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'table_cdmtable_condition_occurrence' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
CDM_TABLE
Verify the table exists.
Parameters used in this template:
schema = cdm
cdmTableName = CONDITION_OCCURRENCE
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
        num_violated_rows 
    FROM
    (
        SELECT
            CASE 
                WHEN COUNT(*) = 0 THEN 0
                ELSE 0
            END AS num_violated_rows
        FROM {{ ref('condition_occurrence') }} cdmTable
    ) violated_rows
) violated_row_count,
( 
    SELECT 1 AS num_rows
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
  ,'cdmTable' as check_name
  ,'TABLE' as check_level
  ,'A yes or no value indicating if DRUG_EXPOSURE table is present as expected based on the specification.' as check_description
  ,'DRUG_EXPOSURE' as cdm_table_name
  ,'NA' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'table_cdm_table.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'table_cdmtable_drug_exposure' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
CDM_TABLE
Verify the table exists.
Parameters used in this template:
schema = cdm
cdmTableName = DRUG_EXPOSURE
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
        num_violated_rows 
    FROM
    (
        SELECT
            CASE 
                WHEN COUNT(*) = 0 THEN 0
                ELSE 0
            END AS num_violated_rows
        FROM {{ ref('drug_exposure') }} cdmTable
    ) violated_rows
) violated_row_count,
( 
    SELECT 1 AS num_rows
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
  ,'cdmTable' as check_name
  ,'TABLE' as check_level
  ,'A yes or no value indicating if PROCEDURE_OCCURRENCE table is present as expected based on the specification.' as check_description
  ,'PROCEDURE_OCCURRENCE' as cdm_table_name
  ,'NA' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'table_cdm_table.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'table_cdmtable_procedure_occurrence' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
CDM_TABLE
Verify the table exists.
Parameters used in this template:
schema = cdm
cdmTableName = PROCEDURE_OCCURRENCE
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
        num_violated_rows 
    FROM
    (
        SELECT
            CASE 
                WHEN COUNT(*) = 0 THEN 0
                ELSE 0
            END AS num_violated_rows
        FROM {{ ref('procedure_occurrence') }} cdmTable
    ) violated_rows
) violated_row_count,
( 
    SELECT 1 AS num_rows
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
  ,'cdmTable' as check_name
  ,'TABLE' as check_level
  ,'A yes or no value indicating if DEVICE_EXPOSURE table is present as expected based on the specification.' as check_description
  ,'DEVICE_EXPOSURE' as cdm_table_name
  ,'NA' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'table_cdm_table.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'table_cdmtable_device_exposure' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
CDM_TABLE
Verify the table exists.
Parameters used in this template:
schema = cdm
cdmTableName = DEVICE_EXPOSURE
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
        num_violated_rows 
    FROM
    (
        SELECT
            CASE 
                WHEN COUNT(*) = 0 THEN 0
                ELSE 0
            END AS num_violated_rows
        FROM {{ ref('device_exposure') }} cdmTable
    ) violated_rows
) violated_row_count,
( 
    SELECT 1 AS num_rows
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
  ,'cdmTable' as check_name
  ,'TABLE' as check_level
  ,'A yes or no value indicating if MEASUREMENT table is present as expected based on the specification.' as check_description
  ,'MEASUREMENT' as cdm_table_name
  ,'NA' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'table_cdm_table.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'table_cdmtable_measurement' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
CDM_TABLE
Verify the table exists.
Parameters used in this template:
schema = cdm
cdmTableName = MEASUREMENT
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
        num_violated_rows 
    FROM
    (
        SELECT
            CASE 
                WHEN COUNT(*) = 0 THEN 0
                ELSE 0
            END AS num_violated_rows
        FROM {{ ref('measurement') }} cdmTable
    ) violated_rows
) violated_row_count,
( 
    SELECT 1 AS num_rows
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
  ,'cdmTable' as check_name
  ,'TABLE' as check_level
  ,'A yes or no value indicating if OBSERVATION table is present as expected based on the specification.' as check_description
  ,'OBSERVATION' as cdm_table_name
  ,'NA' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'table_cdm_table.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'table_cdmtable_observation' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
CDM_TABLE
Verify the table exists.
Parameters used in this template:
schema = cdm
cdmTableName = OBSERVATION
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
        num_violated_rows 
    FROM
    (
        SELECT
            CASE 
                WHEN COUNT(*) = 0 THEN 0
                ELSE 0
            END AS num_violated_rows
        FROM {{ ref('observation') }} cdmTable
    ) violated_rows
) violated_row_count,
( 
    SELECT 1 AS num_rows
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
  ,'cdmTable' as check_name
  ,'TABLE' as check_level
  ,'A yes or no value indicating if DEATH table is present as expected based on the specification.' as check_description
  ,'DEATH' as cdm_table_name
  ,'NA' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'table_cdm_table.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'table_cdmtable_death' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
CDM_TABLE
Verify the table exists.
Parameters used in this template:
schema = cdm
cdmTableName = DEATH
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
        num_violated_rows 
    FROM
    (
        SELECT
            CASE 
                WHEN COUNT(*) = 0 THEN 0
                ELSE 0
            END AS num_violated_rows
        FROM {{ ref('death') }} cdmTable
    ) violated_rows
) violated_row_count,
( 
    SELECT 1 AS num_rows
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
  ,'cdmTable' as check_name
  ,'TABLE' as check_level
  ,'A yes or no value indicating if NOTE table is present as expected based on the specification.' as check_description
  ,'NOTE' as cdm_table_name
  ,'NA' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'table_cdm_table.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'table_cdmtable_note' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
CDM_TABLE
Verify the table exists.
Parameters used in this template:
schema = cdm
cdmTableName = NOTE
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
        num_violated_rows 
    FROM
    (
        SELECT
            CASE 
                WHEN COUNT(*) = 0 THEN 0
                ELSE 0
            END AS num_violated_rows
        FROM {{ ref('note') }} cdmTable
    ) violated_rows
) violated_row_count,
( 
    SELECT 1 AS num_rows
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
  ,'cdmTable' as check_name
  ,'TABLE' as check_level
  ,'A yes or no value indicating if NOTE_NLP table is present as expected based on the specification.' as check_description
  ,'NOTE_NLP' as cdm_table_name
  ,'NA' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'table_cdm_table.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'table_cdmtable_note_nlp' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
CDM_TABLE
Verify the table exists.
Parameters used in this template:
schema = cdm
cdmTableName = NOTE_NLP
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
        num_violated_rows 
    FROM
    (
        SELECT
            CASE 
                WHEN COUNT(*) = 0 THEN 0
                ELSE 0
            END AS num_violated_rows
        FROM {{ ref('note_nlp') }} cdmTable
    ) violated_rows
) violated_row_count,
( 
    SELECT 1 AS num_rows
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
  ,'cdmTable' as check_name
  ,'TABLE' as check_level
  ,'A yes or no value indicating if SPECIMEN table is present as expected based on the specification.' as check_description
  ,'SPECIMEN' as cdm_table_name
  ,'NA' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'table_cdm_table.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'table_cdmtable_specimen' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
CDM_TABLE
Verify the table exists.
Parameters used in this template:
schema = cdm
cdmTableName = SPECIMEN
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
        num_violated_rows 
    FROM
    (
        SELECT
            CASE 
                WHEN COUNT(*) = 0 THEN 0
                ELSE 0
            END AS num_violated_rows
        FROM {{ ref('specimen') }} cdmTable
    ) violated_rows
) violated_row_count,
( 
    SELECT 1 AS num_rows
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
  ,'cdmTable' as check_name
  ,'TABLE' as check_level
  ,'A yes or no value indicating if FACT_RELATIONSHIP table is present as expected based on the specification.' as check_description
  ,'FACT_RELATIONSHIP' as cdm_table_name
  ,'NA' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'table_cdm_table.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'table_cdmtable_fact_relationship' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
CDM_TABLE
Verify the table exists.
Parameters used in this template:
schema = cdm
cdmTableName = FACT_RELATIONSHIP
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
        num_violated_rows 
    FROM
    (
        SELECT
            CASE 
                WHEN COUNT(*) = 0 THEN 0
                ELSE 0
            END AS num_violated_rows
        FROM {{ ref('fact_relationship') }} cdmTable
    ) violated_rows
) violated_row_count,
( 
    SELECT 1 AS num_rows
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
  ,'cdmTable' as check_name
  ,'TABLE' as check_level
  ,'A yes or no value indicating if LOCATION table is present as expected based on the specification.' as check_description
  ,'LOCATION' as cdm_table_name
  ,'NA' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'table_cdm_table.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'table_cdmtable_location' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
CDM_TABLE
Verify the table exists.
Parameters used in this template:
schema = cdm
cdmTableName = LOCATION
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
        num_violated_rows 
    FROM
    (
        SELECT
            CASE 
                WHEN COUNT(*) = 0 THEN 0
                ELSE 0
            END AS num_violated_rows
        FROM {{ ref('location') }} cdmTable
    ) violated_rows
) violated_row_count,
( 
    SELECT 1 AS num_rows
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
  ,'cdmTable' as check_name
  ,'TABLE' as check_level
  ,'A yes or no value indicating if CARE_SITE table is present as expected based on the specification.' as check_description
  ,'CARE_SITE' as cdm_table_name
  ,'NA' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'table_cdm_table.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'table_cdmtable_care_site' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
CDM_TABLE
Verify the table exists.
Parameters used in this template:
schema = cdm
cdmTableName = CARE_SITE
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
        num_violated_rows 
    FROM
    (
        SELECT
            CASE 
                WHEN COUNT(*) = 0 THEN 0
                ELSE 0
            END AS num_violated_rows
        FROM {{ ref('care_site') }} cdmTable
    ) violated_rows
) violated_row_count,
( 
    SELECT 1 AS num_rows
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
  ,'cdmTable' as check_name
  ,'TABLE' as check_level
  ,'A yes or no value indicating if PROVIDER table is present as expected based on the specification.' as check_description
  ,'PROVIDER' as cdm_table_name
  ,'NA' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'table_cdm_table.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'table_cdmtable_provider' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
CDM_TABLE
Verify the table exists.
Parameters used in this template:
schema = cdm
cdmTableName = PROVIDER
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
        num_violated_rows 
    FROM
    (
        SELECT
            CASE 
                WHEN COUNT(*) = 0 THEN 0
                ELSE 0
            END AS num_violated_rows
        FROM {{ ref('provider') }} cdmTable
    ) violated_rows
) violated_row_count,
( 
    SELECT 1 AS num_rows
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
  ,'cdmTable' as check_name
  ,'TABLE' as check_level
  ,'A yes or no value indicating if PAYER_PLAN_PERIOD table is present as expected based on the specification.' as check_description
  ,'PAYER_PLAN_PERIOD' as cdm_table_name
  ,'NA' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'table_cdm_table.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'table_cdmtable_payer_plan_period' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
CDM_TABLE
Verify the table exists.
Parameters used in this template:
schema = cdm
cdmTableName = PAYER_PLAN_PERIOD
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
        num_violated_rows 
    FROM
    (
        SELECT
            CASE 
                WHEN COUNT(*) = 0 THEN 0
                ELSE 0
            END AS num_violated_rows
        FROM {{ ref('payer_plan_period') }} cdmTable
    ) violated_rows
) violated_row_count,
( 
    SELECT 1 AS num_rows
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
  ,'cdmTable' as check_name
  ,'TABLE' as check_level
  ,'A yes or no value indicating if COST table is present as expected based on the specification.' as check_description
  ,'COST' as cdm_table_name
  ,'NA' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'table_cdm_table.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'table_cdmtable_cost' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
CDM_TABLE
Verify the table exists.
Parameters used in this template:
schema = cdm
cdmTableName = COST
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
        num_violated_rows 
    FROM
    (
        SELECT
            CASE 
                WHEN COUNT(*) = 0 THEN 0
                ELSE 0
            END AS num_violated_rows
        FROM {{ ref('cost') }} cdmTable
    ) violated_rows
) violated_row_count,
( 
    SELECT 1 AS num_rows
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
  ,'cdmTable' as check_name
  ,'TABLE' as check_level
  ,'A yes or no value indicating if DRUG_ERA table is present as expected based on the specification.' as check_description
  ,'DRUG_ERA' as cdm_table_name
  ,'NA' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'table_cdm_table.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'table_cdmtable_drug_era' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
CDM_TABLE
Verify the table exists.
Parameters used in this template:
schema = cdm
cdmTableName = DRUG_ERA
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
        num_violated_rows 
    FROM
    (
        SELECT
            CASE 
                WHEN COUNT(*) = 0 THEN 0
                ELSE 0
            END AS num_violated_rows
        FROM {{ ref('drug_era') }} cdmTable
    ) violated_rows
) violated_row_count,
( 
    SELECT 1 AS num_rows
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
  ,'cdmTable' as check_name
  ,'TABLE' as check_level
  ,'A yes or no value indicating if DOSE_ERA table is present as expected based on the specification.' as check_description
  ,'DOSE_ERA' as cdm_table_name
  ,'NA' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'table_cdm_table.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'table_cdmtable_dose_era' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
CDM_TABLE
Verify the table exists.
Parameters used in this template:
schema = cdm
cdmTableName = DOSE_ERA
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
        num_violated_rows 
    FROM
    (
        SELECT
            CASE 
                WHEN COUNT(*) = 0 THEN 0
                ELSE 0
            END AS num_violated_rows
        FROM {{ ref('dose_era') }} cdmTable
    ) violated_rows
) violated_row_count,
( 
    SELECT 1 AS num_rows
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
  ,'cdmTable' as check_name
  ,'TABLE' as check_level
  ,'A yes or no value indicating if CONDITION_ERA table is present as expected based on the specification.' as check_description
  ,'CONDITION_ERA' as cdm_table_name
  ,'NA' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'table_cdm_table.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'table_cdmtable_condition_era' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
CDM_TABLE
Verify the table exists.
Parameters used in this template:
schema = cdm
cdmTableName = CONDITION_ERA
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
        num_violated_rows 
    FROM
    (
        SELECT
            CASE 
                WHEN COUNT(*) = 0 THEN 0
                ELSE 0
            END AS num_violated_rows
        FROM {{ ref('condition_era') }} cdmTable
    ) violated_rows
) violated_row_count,
( 
    SELECT 1 AS num_rows
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
  ,'cdmTable' as check_name
  ,'TABLE' as check_level
  ,'A yes or no value indicating if EPISODE table is present as expected based on the specification.' as check_description
  ,'EPISODE' as cdm_table_name
  ,'NA' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'table_cdm_table.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'table_cdmtable_episode' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
CDM_TABLE
Verify the table exists.
Parameters used in this template:
schema = cdm
cdmTableName = EPISODE
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
        num_violated_rows 
    FROM
    (
        SELECT
            CASE 
                WHEN COUNT(*) = 0 THEN 0
                ELSE 0
            END AS num_violated_rows
        FROM {{ ref('episode') }} cdmTable
    ) violated_rows
) violated_row_count,
( 
    SELECT 1 AS num_rows
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
  ,'cdmTable' as check_name
  ,'TABLE' as check_level
  ,'A yes or no value indicating if EPISODE_EVENT table is present as expected based on the specification.' as check_description
  ,'EPISODE_EVENT' as cdm_table_name
  ,'NA' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'table_cdm_table.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'table_cdmtable_episode_event' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
CDM_TABLE
Verify the table exists.
Parameters used in this template:
schema = cdm
cdmTableName = EPISODE_EVENT
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
        num_violated_rows 
    FROM
    (
        SELECT
            CASE 
                WHEN COUNT(*) = 0 THEN 0
                ELSE 0
            END AS num_violated_rows
        FROM {{ ref('episode_event') }} cdmTable
    ) violated_rows
) violated_row_count,
( 
    SELECT 1 AS num_rows
) denominator
) cte

UNION ALL
SELECT cte.num_violated_rows
  ,cte.pct_violated_rows
  ,cte.num_denominator_rows
  , CAST('' as TEXT) as execution_time
  ,'' as query_text
  ,'cdmTable' as check_name
  ,'TABLE' as check_level
  ,'A yes or no value indicating if METADATA table is present as expected based on the specification.' as check_description
  ,'METADATA' as cdm_table_name
  ,'NA' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'table_cdm_table.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'table_cdmtable_metadata' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
CDM_TABLE
Verify the table exists.
Parameters used in this template:
schema = cdm
cdmTableName = METADATA
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
        num_violated_rows 
    FROM
    (
        SELECT
            CASE 
                WHEN COUNT(*) = 0 THEN 0
                ELSE 0
            END AS num_violated_rows
        FROM {{ ref('metadata') }} cdmTable
    ) violated_rows
) violated_row_count,
( 
    SELECT 1 AS num_rows
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
  ,'cdmTable' as check_name
  ,'TABLE' as check_level
  ,'A yes or no value indicating if CDM_SOURCE table is present as expected based on the specification.' as check_description
  ,'CDM_SOURCE' as cdm_table_name
  ,'NA' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'table_cdm_table.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'table_cdmtable_cdm_source' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
CDM_TABLE
Verify the table exists.
Parameters used in this template:
schema = cdm
cdmTableName = CDM_SOURCE
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
        num_violated_rows 
    FROM
    (
        SELECT
            CASE 
                WHEN COUNT(*) = 0 THEN 0
                ELSE 0
            END AS num_violated_rows
        FROM {{ ref('cdm_source') }} cdmTable
    ) violated_rows
) violated_row_count,
( 
    SELECT 1 AS num_rows
) denominator
) cte
)
SELECT * FROM cte_all
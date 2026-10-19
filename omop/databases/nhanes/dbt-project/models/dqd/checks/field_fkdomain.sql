

/*********
SQL to insert individual DQD results directly into output table, rather than waiting until collecting all results.
Note that this  does not include information about SQL errors or performance
**********/
WITH cte_all  AS (SELECT cte.num_violated_rows
  ,cte.pct_violated_rows
  ,cte.num_denominator_rows
  , CAST('' as TEXT) as execution_time
  ,'' as query_text
  ,'fkDomain' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records that have a value in the CDM_VERSION_CONCEPT_ID field in the CDM_SOURCE table that do not conform to the METADATA domain.' as check_description
  ,'CDM_SOURCE' as cdm_table_name
  ,'CDM_VERSION_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_fk_domain.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_fkdomain_cdm_source_cdm_version_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_FK_DOMAIN
Check that all standard concept IDs belong to the appropriate domain for a given table and field.
Parameters used in this template:
schema = cdm
vocabDatabaseSchema = vocabularies
cdmTableName = CDM_SOURCE
cdmFieldName = CDM_VERSION_CONCEPT_ID
fkDomain = Metadata
**********/
SELECT 
    num_violated_rows, 
    CASE
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM (
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM (
        /*violatedRowsBegin*/
        SELECT 
            'CDM_SOURCE.CDM_VERSION_CONCEPT_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('cdm_source') }} cdmTable
            LEFT JOIN {{ source('vocabularies', 'concept') }} co
            ON cdmTable.CDM_VERSION_CONCEPT_ID = co.concept_id
        WHERE co.concept_id != 0 
            AND co.domain_id NOT IN ('Metadata')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
( 
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('cdm_source') }} cdmTable
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
  ,'fkDomain' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records that have a value in the CONDITION_CONCEPT_ID field in the CONDITION_ERA table that do not conform to the CONDITION domain.' as check_description
  ,'CONDITION_ERA' as cdm_table_name
  ,'CONDITION_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_fk_domain.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_fkdomain_condition_era_condition_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_FK_DOMAIN
Check that all standard concept IDs belong to the appropriate domain for a given table and field.
Parameters used in this template:
schema = cdm
vocabDatabaseSchema = vocabularies
cdmTableName = CONDITION_ERA
cdmFieldName = CONDITION_CONCEPT_ID
fkDomain = Condition
**********/
SELECT 
    num_violated_rows, 
    CASE
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM (
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM (
        /*violatedRowsBegin*/
        SELECT 
            'CONDITION_ERA.CONDITION_CONCEPT_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('condition_era') }} cdmTable
            LEFT JOIN {{ source('vocabularies', 'concept') }} co
            ON cdmTable.CONDITION_CONCEPT_ID = co.concept_id
        WHERE co.concept_id != 0 
            AND co.domain_id NOT IN ('Condition')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
( 
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('condition_era') }} cdmTable
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
  ,'fkDomain' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records that have a value in the CONDITION_CONCEPT_ID field in the CONDITION_OCCURRENCE table that do not conform to the CONDITION domain.' as check_description
  ,'CONDITION_OCCURRENCE' as cdm_table_name
  ,'CONDITION_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_fk_domain.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_fkdomain_condition_occurrence_condition_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_FK_DOMAIN
Check that all standard concept IDs belong to the appropriate domain for a given table and field.
Parameters used in this template:
schema = cdm
vocabDatabaseSchema = vocabularies
cdmTableName = CONDITION_OCCURRENCE
cdmFieldName = CONDITION_CONCEPT_ID
fkDomain = Condition
**********/
SELECT 
    num_violated_rows, 
    CASE
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM (
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM (
        /*violatedRowsBegin*/
        SELECT 
            'CONDITION_OCCURRENCE.CONDITION_CONCEPT_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('condition_occurrence') }} cdmTable
            LEFT JOIN {{ source('vocabularies', 'concept') }} co
            ON cdmTable.CONDITION_CONCEPT_ID = co.concept_id
        WHERE co.concept_id != 0 
            AND co.domain_id NOT IN ('Condition')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
( 
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('condition_occurrence') }} cdmTable
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
  ,'fkDomain' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records that have a value in the CONDITION_STATUS_CONCEPT_ID field in the CONDITION_OCCURRENCE table that do not conform to the CONDITION STATUS domain.' as check_description
  ,'CONDITION_OCCURRENCE' as cdm_table_name
  ,'CONDITION_STATUS_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_fk_domain.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_fkdomain_condition_occurrence_condition_status_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_FK_DOMAIN
Check that all standard concept IDs belong to the appropriate domain for a given table and field.
Parameters used in this template:
schema = cdm
vocabDatabaseSchema = vocabularies
cdmTableName = CONDITION_OCCURRENCE
cdmFieldName = CONDITION_STATUS_CONCEPT_ID
fkDomain = Condition Status
**********/
SELECT 
    num_violated_rows, 
    CASE
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM (
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM (
        /*violatedRowsBegin*/
        SELECT 
            'CONDITION_OCCURRENCE.CONDITION_STATUS_CONCEPT_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('condition_occurrence') }} cdmTable
            LEFT JOIN {{ source('vocabularies', 'concept') }} co
            ON cdmTable.CONDITION_STATUS_CONCEPT_ID = co.concept_id
        WHERE co.concept_id != 0 
            AND co.domain_id NOT IN ('Condition Status')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
( 
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('condition_occurrence') }} cdmTable
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
  ,'fkDomain' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records that have a value in the CONDITION_TYPE_CONCEPT_ID field in the CONDITION_OCCURRENCE table that do not conform to the TYPE CONCEPT domain.' as check_description
  ,'CONDITION_OCCURRENCE' as cdm_table_name
  ,'CONDITION_TYPE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_fk_domain.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_fkdomain_condition_occurrence_condition_type_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_FK_DOMAIN
Check that all standard concept IDs belong to the appropriate domain for a given table and field.
Parameters used in this template:
schema = cdm
vocabDatabaseSchema = vocabularies
cdmTableName = CONDITION_OCCURRENCE
cdmFieldName = CONDITION_TYPE_CONCEPT_ID
fkDomain = Type Concept
**********/
SELECT 
    num_violated_rows, 
    CASE
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM (
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM (
        /*violatedRowsBegin*/
        SELECT 
            'CONDITION_OCCURRENCE.CONDITION_TYPE_CONCEPT_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('condition_occurrence') }} cdmTable
            LEFT JOIN {{ source('vocabularies', 'concept') }} co
            ON cdmTable.CONDITION_TYPE_CONCEPT_ID = co.concept_id
        WHERE co.concept_id != 0 
            AND co.domain_id NOT IN ('Type Concept')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
( 
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('condition_occurrence') }} cdmTable
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
  ,'fkDomain' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records that have a value in the DEATH_TYPE_CONCEPT_ID field in the DEATH table that do not conform to the TYPE CONCEPT domain.' as check_description
  ,'DEATH' as cdm_table_name
  ,'DEATH_TYPE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_fk_domain.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_fkdomain_death_death_type_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_FK_DOMAIN
Check that all standard concept IDs belong to the appropriate domain for a given table and field.
Parameters used in this template:
schema = cdm
vocabDatabaseSchema = vocabularies
cdmTableName = DEATH
cdmFieldName = DEATH_TYPE_CONCEPT_ID
fkDomain = Type Concept
**********/
SELECT 
    num_violated_rows, 
    CASE
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM (
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM (
        /*violatedRowsBegin*/
        SELECT 
            'DEATH.DEATH_TYPE_CONCEPT_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('death') }} cdmTable
            LEFT JOIN {{ source('vocabularies', 'concept') }} co
            ON cdmTable.DEATH_TYPE_CONCEPT_ID = co.concept_id
        WHERE co.concept_id != 0 
            AND co.domain_id NOT IN ('Type Concept')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
( 
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('death') }} cdmTable
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
  ,'fkDomain' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records that have a value in the DEVICE_CONCEPT_ID field in the DEVICE_EXPOSURE table that do not conform to the DEVICE domain.' as check_description
  ,'DEVICE_EXPOSURE' as cdm_table_name
  ,'DEVICE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_fk_domain.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_fkdomain_device_exposure_device_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_FK_DOMAIN
Check that all standard concept IDs belong to the appropriate domain for a given table and field.
Parameters used in this template:
schema = cdm
vocabDatabaseSchema = vocabularies
cdmTableName = DEVICE_EXPOSURE
cdmFieldName = DEVICE_CONCEPT_ID
fkDomain = Device
**********/
SELECT 
    num_violated_rows, 
    CASE
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM (
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM (
        /*violatedRowsBegin*/
        SELECT 
            'DEVICE_EXPOSURE.DEVICE_CONCEPT_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('device_exposure') }} cdmTable
            LEFT JOIN {{ source('vocabularies', 'concept') }} co
            ON cdmTable.DEVICE_CONCEPT_ID = co.concept_id
        WHERE co.concept_id != 0 
            AND co.domain_id NOT IN ('Device')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
( 
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('device_exposure') }} cdmTable
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
  ,'fkDomain' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records that have a value in the DEVICE_TYPE_CONCEPT_ID field in the DEVICE_EXPOSURE table that do not conform to the TYPE CONCEPT domain.' as check_description
  ,'DEVICE_EXPOSURE' as cdm_table_name
  ,'DEVICE_TYPE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_fk_domain.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_fkdomain_device_exposure_device_type_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_FK_DOMAIN
Check that all standard concept IDs belong to the appropriate domain for a given table and field.
Parameters used in this template:
schema = cdm
vocabDatabaseSchema = vocabularies
cdmTableName = DEVICE_EXPOSURE
cdmFieldName = DEVICE_TYPE_CONCEPT_ID
fkDomain = Type Concept
**********/
SELECT 
    num_violated_rows, 
    CASE
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM (
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM (
        /*violatedRowsBegin*/
        SELECT 
            'DEVICE_EXPOSURE.DEVICE_TYPE_CONCEPT_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('device_exposure') }} cdmTable
            LEFT JOIN {{ source('vocabularies', 'concept') }} co
            ON cdmTable.DEVICE_TYPE_CONCEPT_ID = co.concept_id
        WHERE co.concept_id != 0 
            AND co.domain_id NOT IN ('Type Concept')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
( 
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('device_exposure') }} cdmTable
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
  ,'fkDomain' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records that have a value in the UNIT_CONCEPT_ID field in the DEVICE_EXPOSURE table that do not conform to the UNIT domain.' as check_description
  ,'DEVICE_EXPOSURE' as cdm_table_name
  ,'UNIT_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_fk_domain.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_fkdomain_device_exposure_unit_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_FK_DOMAIN
Check that all standard concept IDs belong to the appropriate domain for a given table and field.
Parameters used in this template:
schema = cdm
vocabDatabaseSchema = vocabularies
cdmTableName = DEVICE_EXPOSURE
cdmFieldName = UNIT_CONCEPT_ID
fkDomain = Unit
**********/
SELECT 
    num_violated_rows, 
    CASE
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM (
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM (
        /*violatedRowsBegin*/
        SELECT 
            'DEVICE_EXPOSURE.UNIT_CONCEPT_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('device_exposure') }} cdmTable
            LEFT JOIN {{ source('vocabularies', 'concept') }} co
            ON cdmTable.UNIT_CONCEPT_ID = co.concept_id
        WHERE co.concept_id != 0 
            AND co.domain_id NOT IN ('Unit')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
( 
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('device_exposure') }} cdmTable
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
  ,'fkDomain' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records that have a value in the DRUG_CONCEPT_ID field in the DOSE_ERA table that do not conform to the DRUG domain.' as check_description
  ,'DOSE_ERA' as cdm_table_name
  ,'DRUG_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_fk_domain.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_fkdomain_dose_era_drug_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_FK_DOMAIN
Check that all standard concept IDs belong to the appropriate domain for a given table and field.
Parameters used in this template:
schema = cdm
vocabDatabaseSchema = vocabularies
cdmTableName = DOSE_ERA
cdmFieldName = DRUG_CONCEPT_ID
fkDomain = Drug
**********/
SELECT 
    num_violated_rows, 
    CASE
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM (
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM (
        /*violatedRowsBegin*/
        SELECT 
            'DOSE_ERA.DRUG_CONCEPT_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('dose_era') }} cdmTable
            LEFT JOIN {{ source('vocabularies', 'concept') }} co
            ON cdmTable.DRUG_CONCEPT_ID = co.concept_id
        WHERE co.concept_id != 0 
            AND co.domain_id NOT IN ('Drug')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
( 
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('dose_era') }} cdmTable
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
  ,'fkDomain' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records that have a value in the UNIT_CONCEPT_ID field in the DOSE_ERA table that do not conform to the UNIT domain.' as check_description
  ,'DOSE_ERA' as cdm_table_name
  ,'UNIT_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_fk_domain.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_fkdomain_dose_era_unit_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_FK_DOMAIN
Check that all standard concept IDs belong to the appropriate domain for a given table and field.
Parameters used in this template:
schema = cdm
vocabDatabaseSchema = vocabularies
cdmTableName = DOSE_ERA
cdmFieldName = UNIT_CONCEPT_ID
fkDomain = Unit
**********/
SELECT 
    num_violated_rows, 
    CASE
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM (
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM (
        /*violatedRowsBegin*/
        SELECT 
            'DOSE_ERA.UNIT_CONCEPT_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('dose_era') }} cdmTable
            LEFT JOIN {{ source('vocabularies', 'concept') }} co
            ON cdmTable.UNIT_CONCEPT_ID = co.concept_id
        WHERE co.concept_id != 0 
            AND co.domain_id NOT IN ('Unit')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
( 
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('dose_era') }} cdmTable
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
  ,'fkDomain' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records that have a value in the DRUG_CONCEPT_ID field in the DRUG_ERA table that do not conform to the DRUG domain.' as check_description
  ,'DRUG_ERA' as cdm_table_name
  ,'DRUG_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_fk_domain.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_fkdomain_drug_era_drug_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_FK_DOMAIN
Check that all standard concept IDs belong to the appropriate domain for a given table and field.
Parameters used in this template:
schema = cdm
vocabDatabaseSchema = vocabularies
cdmTableName = DRUG_ERA
cdmFieldName = DRUG_CONCEPT_ID
fkDomain = Drug
**********/
SELECT 
    num_violated_rows, 
    CASE
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM (
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM (
        /*violatedRowsBegin*/
        SELECT 
            'DRUG_ERA.DRUG_CONCEPT_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('drug_era') }} cdmTable
            LEFT JOIN {{ source('vocabularies', 'concept') }} co
            ON cdmTable.DRUG_CONCEPT_ID = co.concept_id
        WHERE co.concept_id != 0 
            AND co.domain_id NOT IN ('Drug')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
( 
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('drug_era') }} cdmTable
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
  ,'fkDomain' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records that have a value in the DRUG_CONCEPT_ID field in the DRUG_EXPOSURE table that do not conform to the DRUG domain.' as check_description
  ,'DRUG_EXPOSURE' as cdm_table_name
  ,'DRUG_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_fk_domain.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_fkdomain_drug_exposure_drug_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_FK_DOMAIN
Check that all standard concept IDs belong to the appropriate domain for a given table and field.
Parameters used in this template:
schema = cdm
vocabDatabaseSchema = vocabularies
cdmTableName = DRUG_EXPOSURE
cdmFieldName = DRUG_CONCEPT_ID
fkDomain = Drug
**********/
SELECT 
    num_violated_rows, 
    CASE
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM (
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM (
        /*violatedRowsBegin*/
        SELECT 
            'DRUG_EXPOSURE.DRUG_CONCEPT_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('drug_exposure') }} cdmTable
            LEFT JOIN {{ source('vocabularies', 'concept') }} co
            ON cdmTable.DRUG_CONCEPT_ID = co.concept_id
        WHERE co.concept_id != 0 
            AND co.domain_id NOT IN ('Drug')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
( 
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('drug_exposure') }} cdmTable
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
  ,'fkDomain' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records that have a value in the DRUG_TYPE_CONCEPT_ID field in the DRUG_EXPOSURE table that do not conform to the TYPE CONCEPT domain.' as check_description
  ,'DRUG_EXPOSURE' as cdm_table_name
  ,'DRUG_TYPE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_fk_domain.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_fkdomain_drug_exposure_drug_type_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_FK_DOMAIN
Check that all standard concept IDs belong to the appropriate domain for a given table and field.
Parameters used in this template:
schema = cdm
vocabDatabaseSchema = vocabularies
cdmTableName = DRUG_EXPOSURE
cdmFieldName = DRUG_TYPE_CONCEPT_ID
fkDomain = Type Concept
**********/
SELECT 
    num_violated_rows, 
    CASE
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM (
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM (
        /*violatedRowsBegin*/
        SELECT 
            'DRUG_EXPOSURE.DRUG_TYPE_CONCEPT_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('drug_exposure') }} cdmTable
            LEFT JOIN {{ source('vocabularies', 'concept') }} co
            ON cdmTable.DRUG_TYPE_CONCEPT_ID = co.concept_id
        WHERE co.concept_id != 0 
            AND co.domain_id NOT IN ('Type Concept')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
( 
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('drug_exposure') }} cdmTable
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
  ,'fkDomain' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records that have a value in the ROUTE_CONCEPT_ID field in the DRUG_EXPOSURE table that do not conform to the ROUTE domain.' as check_description
  ,'DRUG_EXPOSURE' as cdm_table_name
  ,'ROUTE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_fk_domain.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_fkdomain_drug_exposure_route_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_FK_DOMAIN
Check that all standard concept IDs belong to the appropriate domain for a given table and field.
Parameters used in this template:
schema = cdm
vocabDatabaseSchema = vocabularies
cdmTableName = DRUG_EXPOSURE
cdmFieldName = ROUTE_CONCEPT_ID
fkDomain = Route
**********/
SELECT 
    num_violated_rows, 
    CASE
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM (
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM (
        /*violatedRowsBegin*/
        SELECT 
            'DRUG_EXPOSURE.ROUTE_CONCEPT_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('drug_exposure') }} cdmTable
            LEFT JOIN {{ source('vocabularies', 'concept') }} co
            ON cdmTable.ROUTE_CONCEPT_ID = co.concept_id
        WHERE co.concept_id != 0 
            AND co.domain_id NOT IN ('Route')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
( 
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('drug_exposure') }} cdmTable
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
  ,'fkDomain' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records that have a value in the EPISODE_CONCEPT_ID field in the EPISODE table that do not conform to the EPISODE domain.' as check_description
  ,'EPISODE' as cdm_table_name
  ,'EPISODE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_fk_domain.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_fkdomain_episode_episode_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_FK_DOMAIN
Check that all standard concept IDs belong to the appropriate domain for a given table and field.
Parameters used in this template:
schema = cdm
vocabDatabaseSchema = vocabularies
cdmTableName = EPISODE
cdmFieldName = EPISODE_CONCEPT_ID
fkDomain = Episode
**********/
SELECT 
    num_violated_rows, 
    CASE
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM (
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM (
        /*violatedRowsBegin*/
        SELECT 
            'EPISODE.EPISODE_CONCEPT_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('episode') }} cdmTable
            LEFT JOIN {{ source('vocabularies', 'concept') }} co
            ON cdmTable.EPISODE_CONCEPT_ID = co.concept_id
        WHERE co.concept_id != 0 
            AND co.domain_id NOT IN ('Episode')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
( 
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('episode') }} cdmTable
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
  ,'fkDomain' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records that have a value in the EPISODE_TYPE_CONCEPT_ID field in the EPISODE table that do not conform to the TYPE CONCEPT domain.' as check_description
  ,'EPISODE' as cdm_table_name
  ,'EPISODE_TYPE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_fk_domain.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_fkdomain_episode_episode_type_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_FK_DOMAIN
Check that all standard concept IDs belong to the appropriate domain for a given table and field.
Parameters used in this template:
schema = cdm
vocabDatabaseSchema = vocabularies
cdmTableName = EPISODE
cdmFieldName = EPISODE_TYPE_CONCEPT_ID
fkDomain = Type Concept
**********/
SELECT 
    num_violated_rows, 
    CASE
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM (
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM (
        /*violatedRowsBegin*/
        SELECT 
            'EPISODE.EPISODE_TYPE_CONCEPT_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('episode') }} cdmTable
            LEFT JOIN {{ source('vocabularies', 'concept') }} co
            ON cdmTable.EPISODE_TYPE_CONCEPT_ID = co.concept_id
        WHERE co.concept_id != 0 
            AND co.domain_id NOT IN ('Type Concept')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
( 
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('episode') }} cdmTable
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
  ,'fkDomain' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records that have a value in the EPISODE_EVENT_FIELD_CONCEPT_ID field in the EPISODE_EVENT table that do not conform to the METADATA domain.' as check_description
  ,'EPISODE_EVENT' as cdm_table_name
  ,'EPISODE_EVENT_FIELD_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_fk_domain.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_fkdomain_episode_event_episode_event_field_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_FK_DOMAIN
Check that all standard concept IDs belong to the appropriate domain for a given table and field.
Parameters used in this template:
schema = cdm
vocabDatabaseSchema = vocabularies
cdmTableName = EPISODE_EVENT
cdmFieldName = EPISODE_EVENT_FIELD_CONCEPT_ID
fkDomain = Metadata
**********/
SELECT 
    num_violated_rows, 
    CASE
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM (
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM (
        /*violatedRowsBegin*/
        SELECT 
            'EPISODE_EVENT.EPISODE_EVENT_FIELD_CONCEPT_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('episode_event') }} cdmTable
            LEFT JOIN {{ source('vocabularies', 'concept') }} co
            ON cdmTable.EPISODE_EVENT_FIELD_CONCEPT_ID = co.concept_id
        WHERE co.concept_id != 0 
            AND co.domain_id NOT IN ('Metadata')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
( 
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('episode_event') }} cdmTable
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
  ,'fkDomain' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records that have a value in the COUNTRY_CONCEPT_ID field in the LOCATION table that do not conform to the GEOGRAPHY domain.' as check_description
  ,'LOCATION' as cdm_table_name
  ,'COUNTRY_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_fk_domain.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_fkdomain_location_country_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_FK_DOMAIN
Check that all standard concept IDs belong to the appropriate domain for a given table and field.
Parameters used in this template:
schema = cdm
vocabDatabaseSchema = vocabularies
cdmTableName = LOCATION
cdmFieldName = COUNTRY_CONCEPT_ID
fkDomain = Geography
**********/
SELECT 
    num_violated_rows, 
    CASE
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM (
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM (
        /*violatedRowsBegin*/
        SELECT 
            'LOCATION.COUNTRY_CONCEPT_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('location') }} cdmTable
            LEFT JOIN {{ source('vocabularies', 'concept') }} co
            ON cdmTable.COUNTRY_CONCEPT_ID = co.concept_id
        WHERE co.concept_id != 0 
            AND co.domain_id NOT IN ('Geography')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
( 
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('location') }} cdmTable
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
  ,'fkDomain' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records that have a value in the MEASUREMENT_CONCEPT_ID field in the MEASUREMENT table that do not conform to the MEASUREMENT domain.' as check_description
  ,'MEASUREMENT' as cdm_table_name
  ,'MEASUREMENT_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_fk_domain.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_fkdomain_measurement_measurement_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_FK_DOMAIN
Check that all standard concept IDs belong to the appropriate domain for a given table and field.
Parameters used in this template:
schema = cdm
vocabDatabaseSchema = vocabularies
cdmTableName = MEASUREMENT
cdmFieldName = MEASUREMENT_CONCEPT_ID
fkDomain = Measurement
**********/
SELECT 
    num_violated_rows, 
    CASE
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM (
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM (
        /*violatedRowsBegin*/
        SELECT 
            'MEASUREMENT.MEASUREMENT_CONCEPT_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('measurement') }} cdmTable
            LEFT JOIN {{ source('vocabularies', 'concept') }} co
            ON cdmTable.MEASUREMENT_CONCEPT_ID = co.concept_id
        WHERE co.concept_id != 0 
            AND co.domain_id NOT IN ('Measurement')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
( 
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('measurement') }} cdmTable
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
  ,'fkDomain' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records that have a value in the MEASUREMENT_TYPE_CONCEPT_ID field in the MEASUREMENT table that do not conform to the TYPE CONCEPT domain.' as check_description
  ,'MEASUREMENT' as cdm_table_name
  ,'MEASUREMENT_TYPE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_fk_domain.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_fkdomain_measurement_measurement_type_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_FK_DOMAIN
Check that all standard concept IDs belong to the appropriate domain for a given table and field.
Parameters used in this template:
schema = cdm
vocabDatabaseSchema = vocabularies
cdmTableName = MEASUREMENT
cdmFieldName = MEASUREMENT_TYPE_CONCEPT_ID
fkDomain = Type Concept
**********/
SELECT 
    num_violated_rows, 
    CASE
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM (
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM (
        /*violatedRowsBegin*/
        SELECT 
            'MEASUREMENT.MEASUREMENT_TYPE_CONCEPT_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('measurement') }} cdmTable
            LEFT JOIN {{ source('vocabularies', 'concept') }} co
            ON cdmTable.MEASUREMENT_TYPE_CONCEPT_ID = co.concept_id
        WHERE co.concept_id != 0 
            AND co.domain_id NOT IN ('Type Concept')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
( 
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('measurement') }} cdmTable
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
  ,'fkDomain' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records that have a value in the OPERATOR_CONCEPT_ID field in the MEASUREMENT table that do not conform to the MEAS VALUE OPERATOR domain.' as check_description
  ,'MEASUREMENT' as cdm_table_name
  ,'OPERATOR_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_fk_domain.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_fkdomain_measurement_operator_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_FK_DOMAIN
Check that all standard concept IDs belong to the appropriate domain for a given table and field.
Parameters used in this template:
schema = cdm
vocabDatabaseSchema = vocabularies
cdmTableName = MEASUREMENT
cdmFieldName = OPERATOR_CONCEPT_ID
fkDomain = Meas Value Operator
**********/
SELECT 
    num_violated_rows, 
    CASE
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM (
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM (
        /*violatedRowsBegin*/
        SELECT 
            'MEASUREMENT.OPERATOR_CONCEPT_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('measurement') }} cdmTable
            LEFT JOIN {{ source('vocabularies', 'concept') }} co
            ON cdmTable.OPERATOR_CONCEPT_ID = co.concept_id
        WHERE co.concept_id != 0 
            AND co.domain_id NOT IN ('Meas Value Operator')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
( 
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('measurement') }} cdmTable
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
  ,'fkDomain' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records that have a value in the UNIT_CONCEPT_ID field in the MEASUREMENT table that do not conform to the UNIT domain.' as check_description
  ,'MEASUREMENT' as cdm_table_name
  ,'UNIT_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_fk_domain.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_fkdomain_measurement_unit_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_FK_DOMAIN
Check that all standard concept IDs belong to the appropriate domain for a given table and field.
Parameters used in this template:
schema = cdm
vocabDatabaseSchema = vocabularies
cdmTableName = MEASUREMENT
cdmFieldName = UNIT_CONCEPT_ID
fkDomain = Unit
**********/
SELECT 
    num_violated_rows, 
    CASE
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM (
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM (
        /*violatedRowsBegin*/
        SELECT 
            'MEASUREMENT.UNIT_CONCEPT_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('measurement') }} cdmTable
            LEFT JOIN {{ source('vocabularies', 'concept') }} co
            ON cdmTable.UNIT_CONCEPT_ID = co.concept_id
        WHERE co.concept_id != 0 
            AND co.domain_id NOT IN ('Unit')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
( 
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('measurement') }} cdmTable
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
  ,'fkDomain' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records that have a value in the NOTE_TYPE_CONCEPT_ID field in the NOTE table that do not conform to the TYPE CONCEPT domain.' as check_description
  ,'NOTE' as cdm_table_name
  ,'NOTE_TYPE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_fk_domain.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_fkdomain_note_note_type_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_FK_DOMAIN
Check that all standard concept IDs belong to the appropriate domain for a given table and field.
Parameters used in this template:
schema = cdm
vocabDatabaseSchema = vocabularies
cdmTableName = NOTE
cdmFieldName = NOTE_TYPE_CONCEPT_ID
fkDomain = Type Concept
**********/
SELECT 
    num_violated_rows, 
    CASE
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM (
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM (
        /*violatedRowsBegin*/
        SELECT 
            'NOTE.NOTE_TYPE_CONCEPT_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('note') }} cdmTable
            LEFT JOIN {{ source('vocabularies', 'concept') }} co
            ON cdmTable.NOTE_TYPE_CONCEPT_ID = co.concept_id
        WHERE co.concept_id != 0 
            AND co.domain_id NOT IN ('Type Concept')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
( 
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('note') }} cdmTable
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
  ,'fkDomain' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records that have a value in the OBSERVATION_TYPE_CONCEPT_ID field in the OBSERVATION table that do not conform to the TYPE CONCEPT domain.' as check_description
  ,'OBSERVATION' as cdm_table_name
  ,'OBSERVATION_TYPE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_fk_domain.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_fkdomain_observation_observation_type_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_FK_DOMAIN
Check that all standard concept IDs belong to the appropriate domain for a given table and field.
Parameters used in this template:
schema = cdm
vocabDatabaseSchema = vocabularies
cdmTableName = OBSERVATION
cdmFieldName = OBSERVATION_TYPE_CONCEPT_ID
fkDomain = Type Concept
**********/
SELECT 
    num_violated_rows, 
    CASE
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM (
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM (
        /*violatedRowsBegin*/
        SELECT 
            'OBSERVATION.OBSERVATION_TYPE_CONCEPT_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('observation') }} cdmTable
            LEFT JOIN {{ source('vocabularies', 'concept') }} co
            ON cdmTable.OBSERVATION_TYPE_CONCEPT_ID = co.concept_id
        WHERE co.concept_id != 0 
            AND co.domain_id NOT IN ('Type Concept')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
( 
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('observation') }} cdmTable
) denominator
) cte

UNION ALL
SELECT cte.num_violated_rows
  ,cte.pct_violated_rows
  ,cte.num_denominator_rows
  , CAST('' as TEXT) as execution_time
  ,'' as query_text
  ,'fkDomain' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records that have a value in the UNIT_CONCEPT_ID field in the OBSERVATION table that do not conform to the UNIT domain.' as check_description
  ,'OBSERVATION' as cdm_table_name
  ,'UNIT_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_fk_domain.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_fkdomain_observation_unit_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_FK_DOMAIN
Check that all standard concept IDs belong to the appropriate domain for a given table and field.
Parameters used in this template:
schema = cdm
vocabDatabaseSchema = vocabularies
cdmTableName = OBSERVATION
cdmFieldName = UNIT_CONCEPT_ID
fkDomain = Unit
**********/
SELECT 
    num_violated_rows, 
    CASE
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM (
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM (
        /*violatedRowsBegin*/
        SELECT 
            'OBSERVATION.UNIT_CONCEPT_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('observation') }} cdmTable
            LEFT JOIN {{ source('vocabularies', 'concept') }} co
            ON cdmTable.UNIT_CONCEPT_ID = co.concept_id
        WHERE co.concept_id != 0 
            AND co.domain_id NOT IN ('Unit')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
( 
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('observation') }} cdmTable
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
  ,'fkDomain' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records that have a value in the PERIOD_TYPE_CONCEPT_ID field in the OBSERVATION_PERIOD table that do not conform to the TYPE CONCEPT domain.' as check_description
  ,'OBSERVATION_PERIOD' as cdm_table_name
  ,'PERIOD_TYPE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_fk_domain.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_fkdomain_observation_period_period_type_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_FK_DOMAIN
Check that all standard concept IDs belong to the appropriate domain for a given table and field.
Parameters used in this template:
schema = cdm
vocabDatabaseSchema = vocabularies
cdmTableName = OBSERVATION_PERIOD
cdmFieldName = PERIOD_TYPE_CONCEPT_ID
fkDomain = Type Concept
**********/
SELECT 
    num_violated_rows, 
    CASE
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM (
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM (
        /*violatedRowsBegin*/
        SELECT 
            'OBSERVATION_PERIOD.PERIOD_TYPE_CONCEPT_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('observation_period') }} cdmTable
            LEFT JOIN {{ source('vocabularies', 'concept') }} co
            ON cdmTable.PERIOD_TYPE_CONCEPT_ID = co.concept_id
        WHERE co.concept_id != 0 
            AND co.domain_id NOT IN ('Type Concept')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
( 
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('observation_period') }} cdmTable
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
  ,'fkDomain' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records that have a value in the ETHNICITY_CONCEPT_ID field in the PERSON table that do not conform to the ETHNICITY domain.' as check_description
  ,'PERSON' as cdm_table_name
  ,'ETHNICITY_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_fk_domain.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_fkdomain_person_ethnicity_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_FK_DOMAIN
Check that all standard concept IDs belong to the appropriate domain for a given table and field.
Parameters used in this template:
schema = cdm
vocabDatabaseSchema = vocabularies
cdmTableName = PERSON
cdmFieldName = ETHNICITY_CONCEPT_ID
fkDomain = Ethnicity
**********/
SELECT 
    num_violated_rows, 
    CASE
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM (
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM (
        /*violatedRowsBegin*/
        SELECT 
            'PERSON.ETHNICITY_CONCEPT_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('person') }} cdmTable
            LEFT JOIN {{ source('vocabularies', 'concept') }} co
            ON cdmTable.ETHNICITY_CONCEPT_ID = co.concept_id
        WHERE co.concept_id != 0 
            AND co.domain_id NOT IN ('Ethnicity')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
( 
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('person') }} cdmTable
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
  ,'fkDomain' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records that have a value in the GENDER_CONCEPT_ID field in the PERSON table that do not conform to the GENDER domain.' as check_description
  ,'PERSON' as cdm_table_name
  ,'GENDER_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_fk_domain.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_fkdomain_person_gender_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_FK_DOMAIN
Check that all standard concept IDs belong to the appropriate domain for a given table and field.
Parameters used in this template:
schema = cdm
vocabDatabaseSchema = vocabularies
cdmTableName = PERSON
cdmFieldName = GENDER_CONCEPT_ID
fkDomain = Gender
**********/
SELECT 
    num_violated_rows, 
    CASE
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM (
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM (
        /*violatedRowsBegin*/
        SELECT 
            'PERSON.GENDER_CONCEPT_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('person') }} cdmTable
            LEFT JOIN {{ source('vocabularies', 'concept') }} co
            ON cdmTable.GENDER_CONCEPT_ID = co.concept_id
        WHERE co.concept_id != 0 
            AND co.domain_id NOT IN ('Gender')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
( 
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('person') }} cdmTable
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
  ,'fkDomain' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records that have a value in the RACE_CONCEPT_ID field in the PERSON table that do not conform to the RACE domain.' as check_description
  ,'PERSON' as cdm_table_name
  ,'RACE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_fk_domain.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_fkdomain_person_race_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_FK_DOMAIN
Check that all standard concept IDs belong to the appropriate domain for a given table and field.
Parameters used in this template:
schema = cdm
vocabDatabaseSchema = vocabularies
cdmTableName = PERSON
cdmFieldName = RACE_CONCEPT_ID
fkDomain = Race
**********/
SELECT 
    num_violated_rows, 
    CASE
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM (
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM (
        /*violatedRowsBegin*/
        SELECT 
            'PERSON.RACE_CONCEPT_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('person') }} cdmTable
            LEFT JOIN {{ source('vocabularies', 'concept') }} co
            ON cdmTable.RACE_CONCEPT_ID = co.concept_id
        WHERE co.concept_id != 0 
            AND co.domain_id NOT IN ('Race')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
( 
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('person') }} cdmTable
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
  ,'fkDomain' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records that have a value in the PROCEDURE_CONCEPT_ID field in the PROCEDURE_OCCURRENCE table that do not conform to the PROCEDURE domain.' as check_description
  ,'PROCEDURE_OCCURRENCE' as cdm_table_name
  ,'PROCEDURE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_fk_domain.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_fkdomain_procedure_occurrence_procedure_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_FK_DOMAIN
Check that all standard concept IDs belong to the appropriate domain for a given table and field.
Parameters used in this template:
schema = cdm
vocabDatabaseSchema = vocabularies
cdmTableName = PROCEDURE_OCCURRENCE
cdmFieldName = PROCEDURE_CONCEPT_ID
fkDomain = Procedure
**********/
SELECT 
    num_violated_rows, 
    CASE
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM (
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM (
        /*violatedRowsBegin*/
        SELECT 
            'PROCEDURE_OCCURRENCE.PROCEDURE_CONCEPT_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('procedure_occurrence') }} cdmTable
            LEFT JOIN {{ source('vocabularies', 'concept') }} co
            ON cdmTable.PROCEDURE_CONCEPT_ID = co.concept_id
        WHERE co.concept_id != 0 
            AND co.domain_id NOT IN ('Procedure')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
( 
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('procedure_occurrence') }} cdmTable
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
  ,'fkDomain' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records that have a value in the PROCEDURE_TYPE_CONCEPT_ID field in the PROCEDURE_OCCURRENCE table that do not conform to the TYPE CONCEPT domain.' as check_description
  ,'PROCEDURE_OCCURRENCE' as cdm_table_name
  ,'PROCEDURE_TYPE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_fk_domain.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_fkdomain_procedure_occurrence_procedure_type_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_FK_DOMAIN
Check that all standard concept IDs belong to the appropriate domain for a given table and field.
Parameters used in this template:
schema = cdm
vocabDatabaseSchema = vocabularies
cdmTableName = PROCEDURE_OCCURRENCE
cdmFieldName = PROCEDURE_TYPE_CONCEPT_ID
fkDomain = Type Concept
**********/
SELECT 
    num_violated_rows, 
    CASE
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM (
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM (
        /*violatedRowsBegin*/
        SELECT 
            'PROCEDURE_OCCURRENCE.PROCEDURE_TYPE_CONCEPT_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('procedure_occurrence') }} cdmTable
            LEFT JOIN {{ source('vocabularies', 'concept') }} co
            ON cdmTable.PROCEDURE_TYPE_CONCEPT_ID = co.concept_id
        WHERE co.concept_id != 0 
            AND co.domain_id NOT IN ('Type Concept')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
( 
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('procedure_occurrence') }} cdmTable
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
  ,'fkDomain' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records that have a value in the GENDER_CONCEPT_ID field in the PROVIDER table that do not conform to the GENDER domain.' as check_description
  ,'PROVIDER' as cdm_table_name
  ,'GENDER_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_fk_domain.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_fkdomain_provider_gender_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_FK_DOMAIN
Check that all standard concept IDs belong to the appropriate domain for a given table and field.
Parameters used in this template:
schema = cdm
vocabDatabaseSchema = vocabularies
cdmTableName = PROVIDER
cdmFieldName = GENDER_CONCEPT_ID
fkDomain = Gender
**********/
SELECT 
    num_violated_rows, 
    CASE
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM (
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM (
        /*violatedRowsBegin*/
        SELECT 
            'PROVIDER.GENDER_CONCEPT_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('provider') }} cdmTable
            LEFT JOIN {{ source('vocabularies', 'concept') }} co
            ON cdmTable.GENDER_CONCEPT_ID = co.concept_id
        WHERE co.concept_id != 0 
            AND co.domain_id NOT IN ('Gender')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
( 
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('provider') }} cdmTable
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
  ,'fkDomain' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records that have a value in the SPECIMEN_TYPE_CONCEPT_ID field in the SPECIMEN table that do not conform to the TYPE CONCEPT domain.' as check_description
  ,'SPECIMEN' as cdm_table_name
  ,'SPECIMEN_TYPE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_fk_domain.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_fkdomain_specimen_specimen_type_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_FK_DOMAIN
Check that all standard concept IDs belong to the appropriate domain for a given table and field.
Parameters used in this template:
schema = cdm
vocabDatabaseSchema = vocabularies
cdmTableName = SPECIMEN
cdmFieldName = SPECIMEN_TYPE_CONCEPT_ID
fkDomain = Type Concept
**********/
SELECT 
    num_violated_rows, 
    CASE
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM (
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM (
        /*violatedRowsBegin*/
        SELECT 
            'SPECIMEN.SPECIMEN_TYPE_CONCEPT_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('specimen') }} cdmTable
            LEFT JOIN {{ source('vocabularies', 'concept') }} co
            ON cdmTable.SPECIMEN_TYPE_CONCEPT_ID = co.concept_id
        WHERE co.concept_id != 0 
            AND co.domain_id NOT IN ('Type Concept')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
( 
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('specimen') }} cdmTable
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
  ,'fkDomain' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records that have a value in the ADMITTED_FROM_CONCEPT_ID field in the VISIT_DETAIL table that do not conform to the VISIT domain.' as check_description
  ,'VISIT_DETAIL' as cdm_table_name
  ,'ADMITTED_FROM_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_fk_domain.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_fkdomain_visit_detail_admitted_from_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_FK_DOMAIN
Check that all standard concept IDs belong to the appropriate domain for a given table and field.
Parameters used in this template:
schema = cdm
vocabDatabaseSchema = vocabularies
cdmTableName = VISIT_DETAIL
cdmFieldName = ADMITTED_FROM_CONCEPT_ID
fkDomain = Visit
**********/
SELECT 
    num_violated_rows, 
    CASE
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM (
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM (
        /*violatedRowsBegin*/
        SELECT 
            'VISIT_DETAIL.ADMITTED_FROM_CONCEPT_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('visit_detail') }} cdmTable
            LEFT JOIN {{ source('vocabularies', 'concept') }} co
            ON cdmTable.ADMITTED_FROM_CONCEPT_ID = co.concept_id
        WHERE co.concept_id != 0 
            AND co.domain_id NOT IN ('Visit')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
( 
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('visit_detail') }} cdmTable
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
  ,'fkDomain' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records that have a value in the DISCHARGED_TO_CONCEPT_ID field in the VISIT_DETAIL table that do not conform to the VISIT domain.' as check_description
  ,'VISIT_DETAIL' as cdm_table_name
  ,'DISCHARGED_TO_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_fk_domain.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_fkdomain_visit_detail_discharged_to_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_FK_DOMAIN
Check that all standard concept IDs belong to the appropriate domain for a given table and field.
Parameters used in this template:
schema = cdm
vocabDatabaseSchema = vocabularies
cdmTableName = VISIT_DETAIL
cdmFieldName = DISCHARGED_TO_CONCEPT_ID
fkDomain = Visit
**********/
SELECT 
    num_violated_rows, 
    CASE
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM (
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM (
        /*violatedRowsBegin*/
        SELECT 
            'VISIT_DETAIL.DISCHARGED_TO_CONCEPT_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('visit_detail') }} cdmTable
            LEFT JOIN {{ source('vocabularies', 'concept') }} co
            ON cdmTable.DISCHARGED_TO_CONCEPT_ID = co.concept_id
        WHERE co.concept_id != 0 
            AND co.domain_id NOT IN ('Visit')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
( 
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('visit_detail') }} cdmTable
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
  ,'fkDomain' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records that have a value in the VISIT_DETAIL_CONCEPT_ID field in the VISIT_DETAIL table that do not conform to the VISIT domain.' as check_description
  ,'VISIT_DETAIL' as cdm_table_name
  ,'VISIT_DETAIL_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_fk_domain.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_fkdomain_visit_detail_visit_detail_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_FK_DOMAIN
Check that all standard concept IDs belong to the appropriate domain for a given table and field.
Parameters used in this template:
schema = cdm
vocabDatabaseSchema = vocabularies
cdmTableName = VISIT_DETAIL
cdmFieldName = VISIT_DETAIL_CONCEPT_ID
fkDomain = Visit
**********/
SELECT 
    num_violated_rows, 
    CASE
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM (
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM (
        /*violatedRowsBegin*/
        SELECT 
            'VISIT_DETAIL.VISIT_DETAIL_CONCEPT_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('visit_detail') }} cdmTable
            LEFT JOIN {{ source('vocabularies', 'concept') }} co
            ON cdmTable.VISIT_DETAIL_CONCEPT_ID = co.concept_id
        WHERE co.concept_id != 0 
            AND co.domain_id NOT IN ('Visit')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
( 
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('visit_detail') }} cdmTable
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
  ,'fkDomain' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records that have a value in the VISIT_DETAIL_TYPE_CONCEPT_ID field in the VISIT_DETAIL table that do not conform to the TYPE CONCEPT domain.' as check_description
  ,'VISIT_DETAIL' as cdm_table_name
  ,'VISIT_DETAIL_TYPE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_fk_domain.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_fkdomain_visit_detail_visit_detail_type_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_FK_DOMAIN
Check that all standard concept IDs belong to the appropriate domain for a given table and field.
Parameters used in this template:
schema = cdm
vocabDatabaseSchema = vocabularies
cdmTableName = VISIT_DETAIL
cdmFieldName = VISIT_DETAIL_TYPE_CONCEPT_ID
fkDomain = Type Concept
**********/
SELECT 
    num_violated_rows, 
    CASE
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM (
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM (
        /*violatedRowsBegin*/
        SELECT 
            'VISIT_DETAIL.VISIT_DETAIL_TYPE_CONCEPT_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('visit_detail') }} cdmTable
            LEFT JOIN {{ source('vocabularies', 'concept') }} co
            ON cdmTable.VISIT_DETAIL_TYPE_CONCEPT_ID = co.concept_id
        WHERE co.concept_id != 0 
            AND co.domain_id NOT IN ('Type Concept')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
( 
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('visit_detail') }} cdmTable
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
  ,'fkDomain' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records that have a value in the ADMITTED_FROM_CONCEPT_ID field in the VISIT_OCCURRENCE table that do not conform to the VISIT domain.' as check_description
  ,'VISIT_OCCURRENCE' as cdm_table_name
  ,'ADMITTED_FROM_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_fk_domain.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_fkdomain_visit_occurrence_admitted_from_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_FK_DOMAIN
Check that all standard concept IDs belong to the appropriate domain for a given table and field.
Parameters used in this template:
schema = cdm
vocabDatabaseSchema = vocabularies
cdmTableName = VISIT_OCCURRENCE
cdmFieldName = ADMITTED_FROM_CONCEPT_ID
fkDomain = Visit
**********/
SELECT 
    num_violated_rows, 
    CASE
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM (
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM (
        /*violatedRowsBegin*/
        SELECT 
            'VISIT_OCCURRENCE.ADMITTED_FROM_CONCEPT_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('visit_occurrence') }} cdmTable
            LEFT JOIN {{ source('vocabularies', 'concept') }} co
            ON cdmTable.ADMITTED_FROM_CONCEPT_ID = co.concept_id
        WHERE co.concept_id != 0 
            AND co.domain_id NOT IN ('Visit')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
( 
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('visit_occurrence') }} cdmTable
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
  ,'fkDomain' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records that have a value in the DISCHARGED_TO_CONCEPT_ID field in the VISIT_OCCURRENCE table that do not conform to the VISIT domain.' as check_description
  ,'VISIT_OCCURRENCE' as cdm_table_name
  ,'DISCHARGED_TO_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_fk_domain.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_fkdomain_visit_occurrence_discharged_to_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_FK_DOMAIN
Check that all standard concept IDs belong to the appropriate domain for a given table and field.
Parameters used in this template:
schema = cdm
vocabDatabaseSchema = vocabularies
cdmTableName = VISIT_OCCURRENCE
cdmFieldName = DISCHARGED_TO_CONCEPT_ID
fkDomain = Visit
**********/
SELECT 
    num_violated_rows, 
    CASE
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM (
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM (
        /*violatedRowsBegin*/
        SELECT 
            'VISIT_OCCURRENCE.DISCHARGED_TO_CONCEPT_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('visit_occurrence') }} cdmTable
            LEFT JOIN {{ source('vocabularies', 'concept') }} co
            ON cdmTable.DISCHARGED_TO_CONCEPT_ID = co.concept_id
        WHERE co.concept_id != 0 
            AND co.domain_id NOT IN ('Visit')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
( 
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('visit_occurrence') }} cdmTable
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
  ,'fkDomain' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records that have a value in the VISIT_CONCEPT_ID field in the VISIT_OCCURRENCE table that do not conform to the VISIT domain.' as check_description
  ,'VISIT_OCCURRENCE' as cdm_table_name
  ,'VISIT_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_fk_domain.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_fkdomain_visit_occurrence_visit_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_FK_DOMAIN
Check that all standard concept IDs belong to the appropriate domain for a given table and field.
Parameters used in this template:
schema = cdm
vocabDatabaseSchema = vocabularies
cdmTableName = VISIT_OCCURRENCE
cdmFieldName = VISIT_CONCEPT_ID
fkDomain = Visit
**********/
SELECT 
    num_violated_rows, 
    CASE
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM (
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM (
        /*violatedRowsBegin*/
        SELECT 
            'VISIT_OCCURRENCE.VISIT_CONCEPT_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('visit_occurrence') }} cdmTable
            LEFT JOIN {{ source('vocabularies', 'concept') }} co
            ON cdmTable.VISIT_CONCEPT_ID = co.concept_id
        WHERE co.concept_id != 0 
            AND co.domain_id NOT IN ('Visit')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
( 
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('visit_occurrence') }} cdmTable
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
  ,'fkDomain' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records that have a value in the VISIT_TYPE_CONCEPT_ID field in the VISIT_OCCURRENCE table that do not conform to the TYPE CONCEPT domain.' as check_description
  ,'VISIT_OCCURRENCE' as cdm_table_name
  ,'VISIT_TYPE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_fk_domain.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_fkdomain_visit_occurrence_visit_type_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_FK_DOMAIN
Check that all standard concept IDs belong to the appropriate domain for a given table and field.
Parameters used in this template:
schema = cdm
vocabDatabaseSchema = vocabularies
cdmTableName = VISIT_OCCURRENCE
cdmFieldName = VISIT_TYPE_CONCEPT_ID
fkDomain = Type Concept
**********/
SELECT 
    num_violated_rows, 
    CASE
        WHEN denominator.num_rows = 0 THEN 0 
        ELSE 1.0*num_violated_rows/denominator.num_rows 
    END AS pct_violated_rows, 
    denominator.num_rows AS num_denominator_rows
FROM (
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM (
        /*violatedRowsBegin*/
        SELECT 
            'VISIT_OCCURRENCE.VISIT_TYPE_CONCEPT_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('visit_occurrence') }} cdmTable
            LEFT JOIN {{ source('vocabularies', 'concept') }} co
            ON cdmTable.VISIT_TYPE_CONCEPT_ID = co.concept_id
        WHERE co.concept_id != 0 
            AND co.domain_id NOT IN ('Type Concept')
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
( 
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('visit_occurrence') }} cdmTable
) denominator
) cte
)
SELECT * FROM cte_all
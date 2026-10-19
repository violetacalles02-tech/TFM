

/*********
SQL to insert individual DQD results directly into output table, rather than waiting until collecting all results.
Note that this  does not include information about SQL errors or performance
**********/
WITH cte_all  AS (SELECT cte.num_violated_rows
  ,cte.pct_violated_rows
  ,cte.num_denominator_rows
  , CAST('' as TEXT) as execution_time
  ,'' as query_text
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the CARE_SITE_ID of the CARE_SITE that is considered not nullable.' as check_description
  ,'CARE_SITE' as cdm_table_name
  ,'CARE_SITE_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_care_site_care_site_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = CARE_SITE
cdmFieldName = CARE_SITE_ID
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
            'CARE_SITE.CARE_SITE_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('care_site') }} cdmTable
        WHERE cdmTable.CARE_SITE_ID IS NULL
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
( 
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('care_site') }} cdmTable
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the CDM_HOLDER of the CDM_SOURCE that is considered not nullable.' as check_description
  ,'CDM_SOURCE' as cdm_table_name
  ,'CDM_HOLDER' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_cdm_source_cdm_holder' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = CDM_SOURCE
cdmFieldName = CDM_HOLDER
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
            'CDM_SOURCE.CDM_HOLDER' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('cdm_source') }} cdmTable
        WHERE cdmTable.CDM_HOLDER IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the CDM_RELEASE_DATE of the CDM_SOURCE that is considered not nullable.' as check_description
  ,'CDM_SOURCE' as cdm_table_name
  ,'CDM_RELEASE_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_cdm_source_cdm_release_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = CDM_SOURCE
cdmFieldName = CDM_RELEASE_DATE
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
            'CDM_SOURCE.CDM_RELEASE_DATE' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('cdm_source') }} cdmTable
        WHERE cdmTable.CDM_RELEASE_DATE IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the CDM_SOURCE_ABBREVIATION of the CDM_SOURCE that is considered not nullable.' as check_description
  ,'CDM_SOURCE' as cdm_table_name
  ,'CDM_SOURCE_ABBREVIATION' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_cdm_source_cdm_source_abbreviation' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = CDM_SOURCE
cdmFieldName = CDM_SOURCE_ABBREVIATION
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
            'CDM_SOURCE.CDM_SOURCE_ABBREVIATION' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('cdm_source') }} cdmTable
        WHERE cdmTable.CDM_SOURCE_ABBREVIATION IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the CDM_SOURCE_NAME of the CDM_SOURCE that is considered not nullable.' as check_description
  ,'CDM_SOURCE' as cdm_table_name
  ,'CDM_SOURCE_NAME' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_cdm_source_cdm_source_name' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = CDM_SOURCE
cdmFieldName = CDM_SOURCE_NAME
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
            'CDM_SOURCE.CDM_SOURCE_NAME' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('cdm_source') }} cdmTable
        WHERE cdmTable.CDM_SOURCE_NAME IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the CDM_VERSION_CONCEPT_ID of the CDM_SOURCE that is considered not nullable.' as check_description
  ,'CDM_SOURCE' as cdm_table_name
  ,'CDM_VERSION_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_cdm_source_cdm_version_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = CDM_SOURCE
cdmFieldName = CDM_VERSION_CONCEPT_ID
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
        WHERE cdmTable.CDM_VERSION_CONCEPT_ID IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the SOURCE_RELEASE_DATE of the CDM_SOURCE that is considered not nullable.' as check_description
  ,'CDM_SOURCE' as cdm_table_name
  ,'SOURCE_RELEASE_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_cdm_source_source_release_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = CDM_SOURCE
cdmFieldName = SOURCE_RELEASE_DATE
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
            'CDM_SOURCE.SOURCE_RELEASE_DATE' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('cdm_source') }} cdmTable
        WHERE cdmTable.SOURCE_RELEASE_DATE IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the VOCABULARY_VERSION of the CDM_SOURCE that is considered not nullable.' as check_description
  ,'CDM_SOURCE' as cdm_table_name
  ,'VOCABULARY_VERSION' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_cdm_source_vocabulary_version' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = CDM_SOURCE
cdmFieldName = VOCABULARY_VERSION
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
            'CDM_SOURCE.VOCABULARY_VERSION' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('cdm_source') }} cdmTable
        WHERE cdmTable.VOCABULARY_VERSION IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the CONDITION_CONCEPT_ID of the CONDITION_ERA that is considered not nullable.' as check_description
  ,'CONDITION_ERA' as cdm_table_name
  ,'CONDITION_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_condition_era_condition_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = CONDITION_ERA
cdmFieldName = CONDITION_CONCEPT_ID
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
        WHERE cdmTable.CONDITION_CONCEPT_ID IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the CONDITION_ERA_END_DATE of the CONDITION_ERA that is considered not nullable.' as check_description
  ,'CONDITION_ERA' as cdm_table_name
  ,'CONDITION_ERA_END_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_condition_era_condition_era_end_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
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
FROM (
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM (
        /*violatedRowsBegin*/
        SELECT 
            'CONDITION_ERA.CONDITION_ERA_END_DATE' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('condition_era') }} cdmTable
        WHERE cdmTable.CONDITION_ERA_END_DATE IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the CONDITION_ERA_ID of the CONDITION_ERA that is considered not nullable.' as check_description
  ,'CONDITION_ERA' as cdm_table_name
  ,'CONDITION_ERA_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_condition_era_condition_era_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = CONDITION_ERA
cdmFieldName = CONDITION_ERA_ID
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
            'CONDITION_ERA.CONDITION_ERA_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('condition_era') }} cdmTable
        WHERE cdmTable.CONDITION_ERA_ID IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the CONDITION_ERA_START_DATE of the CONDITION_ERA that is considered not nullable.' as check_description
  ,'CONDITION_ERA' as cdm_table_name
  ,'CONDITION_ERA_START_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_condition_era_condition_era_start_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
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
FROM (
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM (
        /*violatedRowsBegin*/
        SELECT 
            'CONDITION_ERA.CONDITION_ERA_START_DATE' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('condition_era') }} cdmTable
        WHERE cdmTable.CONDITION_ERA_START_DATE IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the PERSON_ID of the CONDITION_ERA that is considered not nullable.' as check_description
  ,'CONDITION_ERA' as cdm_table_name
  ,'PERSON_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_condition_era_person_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = CONDITION_ERA
cdmFieldName = PERSON_ID
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
            'CONDITION_ERA.PERSON_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('condition_era') }} cdmTable
        WHERE cdmTable.PERSON_ID IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the CONDITION_CONCEPT_ID of the CONDITION_OCCURRENCE that is considered not nullable.' as check_description
  ,'CONDITION_OCCURRENCE' as cdm_table_name
  ,'CONDITION_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_condition_occurrence_condition_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = CONDITION_OCCURRENCE
cdmFieldName = CONDITION_CONCEPT_ID
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
        WHERE cdmTable.CONDITION_CONCEPT_ID IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the CONDITION_OCCURRENCE_ID of the CONDITION_OCCURRENCE that is considered not nullable.' as check_description
  ,'CONDITION_OCCURRENCE' as cdm_table_name
  ,'CONDITION_OCCURRENCE_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_condition_occurrence_condition_occurrence_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = CONDITION_OCCURRENCE
cdmFieldName = CONDITION_OCCURRENCE_ID
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
            'CONDITION_OCCURRENCE.CONDITION_OCCURRENCE_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('condition_occurrence') }} cdmTable
        WHERE cdmTable.CONDITION_OCCURRENCE_ID IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the CONDITION_START_DATE of the CONDITION_OCCURRENCE that is considered not nullable.' as check_description
  ,'CONDITION_OCCURRENCE' as cdm_table_name
  ,'CONDITION_START_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_condition_occurrence_condition_start_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
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
FROM (
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM (
        /*violatedRowsBegin*/
        SELECT 
            'CONDITION_OCCURRENCE.CONDITION_START_DATE' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('condition_occurrence') }} cdmTable
        WHERE cdmTable.CONDITION_START_DATE IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the CONDITION_TYPE_CONCEPT_ID of the CONDITION_OCCURRENCE that is considered not nullable.' as check_description
  ,'CONDITION_OCCURRENCE' as cdm_table_name
  ,'CONDITION_TYPE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_condition_occurrence_condition_type_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = CONDITION_OCCURRENCE
cdmFieldName = CONDITION_TYPE_CONCEPT_ID
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
        WHERE cdmTable.CONDITION_TYPE_CONCEPT_ID IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the PERSON_ID of the CONDITION_OCCURRENCE that is considered not nullable.' as check_description
  ,'CONDITION_OCCURRENCE' as cdm_table_name
  ,'PERSON_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_condition_occurrence_person_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = CONDITION_OCCURRENCE
cdmFieldName = PERSON_ID
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
            'CONDITION_OCCURRENCE.PERSON_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('condition_occurrence') }} cdmTable
        WHERE cdmTable.PERSON_ID IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the COST_DOMAIN_ID of the COST that is considered not nullable.' as check_description
  ,'COST' as cdm_table_name
  ,'COST_DOMAIN_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_cost_cost_domain_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = COST
cdmFieldName = COST_DOMAIN_ID
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
            'COST.COST_DOMAIN_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('cost') }} cdmTable
        WHERE cdmTable.COST_DOMAIN_ID IS NULL
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
( 
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('cost') }} cdmTable
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the COST_EVENT_ID of the COST that is considered not nullable.' as check_description
  ,'COST' as cdm_table_name
  ,'COST_EVENT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_cost_cost_event_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = COST
cdmFieldName = COST_EVENT_ID
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
            'COST.COST_EVENT_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('cost') }} cdmTable
        WHERE cdmTable.COST_EVENT_ID IS NULL
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
( 
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('cost') }} cdmTable
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the COST_ID of the COST that is considered not nullable.' as check_description
  ,'COST' as cdm_table_name
  ,'COST_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_cost_cost_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = COST
cdmFieldName = COST_ID
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
            'COST.COST_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('cost') }} cdmTable
        WHERE cdmTable.COST_ID IS NULL
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
( 
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('cost') }} cdmTable
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the COST_TYPE_CONCEPT_ID of the COST that is considered not nullable.' as check_description
  ,'COST' as cdm_table_name
  ,'COST_TYPE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_cost_cost_type_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = COST
cdmFieldName = COST_TYPE_CONCEPT_ID
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
            'COST.COST_TYPE_CONCEPT_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('cost') }} cdmTable
        WHERE cdmTable.COST_TYPE_CONCEPT_ID IS NULL
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
( 
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('cost') }} cdmTable
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the DEATH_DATE of the DEATH that is considered not nullable.' as check_description
  ,'DEATH' as cdm_table_name
  ,'DEATH_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_death_death_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = DEATH
cdmFieldName = DEATH_DATE
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
            'DEATH.DEATH_DATE' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('death') }} cdmTable
        WHERE cdmTable.DEATH_DATE IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the PERSON_ID of the DEATH that is considered not nullable.' as check_description
  ,'DEATH' as cdm_table_name
  ,'PERSON_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_death_person_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = DEATH
cdmFieldName = PERSON_ID
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
            'DEATH.PERSON_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('death') }} cdmTable
        WHERE cdmTable.PERSON_ID IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the DEVICE_CONCEPT_ID of the DEVICE_EXPOSURE that is considered not nullable.' as check_description
  ,'DEVICE_EXPOSURE' as cdm_table_name
  ,'DEVICE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_device_exposure_device_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = DEVICE_EXPOSURE
cdmFieldName = DEVICE_CONCEPT_ID
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
        WHERE cdmTable.DEVICE_CONCEPT_ID IS NULL
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
( 
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('device_exposure') }} cdmTable
) denominator
) cte

UNION ALL
SELECT cte.num_violated_rows
  ,cte.pct_violated_rows
  ,cte.num_denominator_rows
  , CAST('' as TEXT) as execution_time
  ,'' as query_text
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the DEVICE_EXPOSURE_ID of the DEVICE_EXPOSURE that is considered not nullable.' as check_description
  ,'DEVICE_EXPOSURE' as cdm_table_name
  ,'DEVICE_EXPOSURE_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_device_exposure_device_exposure_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = DEVICE_EXPOSURE
cdmFieldName = DEVICE_EXPOSURE_ID
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
            'DEVICE_EXPOSURE.DEVICE_EXPOSURE_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('device_exposure') }} cdmTable
        WHERE cdmTable.DEVICE_EXPOSURE_ID IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the DEVICE_EXPOSURE_START_DATE of the DEVICE_EXPOSURE that is considered not nullable.' as check_description
  ,'DEVICE_EXPOSURE' as cdm_table_name
  ,'DEVICE_EXPOSURE_START_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_device_exposure_device_exposure_start_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
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
FROM (
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM (
        /*violatedRowsBegin*/
        SELECT 
            'DEVICE_EXPOSURE.DEVICE_EXPOSURE_START_DATE' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('device_exposure') }} cdmTable
        WHERE cdmTable.DEVICE_EXPOSURE_START_DATE IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the DEVICE_TYPE_CONCEPT_ID of the DEVICE_EXPOSURE that is considered not nullable.' as check_description
  ,'DEVICE_EXPOSURE' as cdm_table_name
  ,'DEVICE_TYPE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_device_exposure_device_type_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = DEVICE_EXPOSURE
cdmFieldName = DEVICE_TYPE_CONCEPT_ID
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
        WHERE cdmTable.DEVICE_TYPE_CONCEPT_ID IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the PERSON_ID of the DEVICE_EXPOSURE that is considered not nullable.' as check_description
  ,'DEVICE_EXPOSURE' as cdm_table_name
  ,'PERSON_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_device_exposure_person_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = DEVICE_EXPOSURE
cdmFieldName = PERSON_ID
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
            'DEVICE_EXPOSURE.PERSON_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('device_exposure') }} cdmTable
        WHERE cdmTable.PERSON_ID IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the DOSE_ERA_END_DATE of the DOSE_ERA that is considered not nullable.' as check_description
  ,'DOSE_ERA' as cdm_table_name
  ,'DOSE_ERA_END_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_dose_era_dose_era_end_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
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
FROM (
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM (
        /*violatedRowsBegin*/
        SELECT 
            'DOSE_ERA.DOSE_ERA_END_DATE' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('dose_era') }} cdmTable
        WHERE cdmTable.DOSE_ERA_END_DATE IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the DOSE_ERA_ID of the DOSE_ERA that is considered not nullable.' as check_description
  ,'DOSE_ERA' as cdm_table_name
  ,'DOSE_ERA_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_dose_era_dose_era_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = DOSE_ERA
cdmFieldName = DOSE_ERA_ID
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
            'DOSE_ERA.DOSE_ERA_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('dose_era') }} cdmTable
        WHERE cdmTable.DOSE_ERA_ID IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the DOSE_ERA_START_DATE of the DOSE_ERA that is considered not nullable.' as check_description
  ,'DOSE_ERA' as cdm_table_name
  ,'DOSE_ERA_START_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_dose_era_dose_era_start_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
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
FROM (
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM (
        /*violatedRowsBegin*/
        SELECT 
            'DOSE_ERA.DOSE_ERA_START_DATE' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('dose_era') }} cdmTable
        WHERE cdmTable.DOSE_ERA_START_DATE IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the DOSE_VALUE of the DOSE_ERA that is considered not nullable.' as check_description
  ,'DOSE_ERA' as cdm_table_name
  ,'DOSE_VALUE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_dose_era_dose_value' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = DOSE_ERA
cdmFieldName = DOSE_VALUE
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
            'DOSE_ERA.DOSE_VALUE' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('dose_era') }} cdmTable
        WHERE cdmTable.DOSE_VALUE IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the DRUG_CONCEPT_ID of the DOSE_ERA that is considered not nullable.' as check_description
  ,'DOSE_ERA' as cdm_table_name
  ,'DRUG_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_dose_era_drug_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = DOSE_ERA
cdmFieldName = DRUG_CONCEPT_ID
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
        WHERE cdmTable.DRUG_CONCEPT_ID IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the PERSON_ID of the DOSE_ERA that is considered not nullable.' as check_description
  ,'DOSE_ERA' as cdm_table_name
  ,'PERSON_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_dose_era_person_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = DOSE_ERA
cdmFieldName = PERSON_ID
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
            'DOSE_ERA.PERSON_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('dose_era') }} cdmTable
        WHERE cdmTable.PERSON_ID IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the UNIT_CONCEPT_ID of the DOSE_ERA that is considered not nullable.' as check_description
  ,'DOSE_ERA' as cdm_table_name
  ,'UNIT_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_dose_era_unit_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = DOSE_ERA
cdmFieldName = UNIT_CONCEPT_ID
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
        WHERE cdmTable.UNIT_CONCEPT_ID IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the DRUG_CONCEPT_ID of the DRUG_ERA that is considered not nullable.' as check_description
  ,'DRUG_ERA' as cdm_table_name
  ,'DRUG_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_drug_era_drug_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = DRUG_ERA
cdmFieldName = DRUG_CONCEPT_ID
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
        WHERE cdmTable.DRUG_CONCEPT_ID IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the DRUG_ERA_END_DATE of the DRUG_ERA that is considered not nullable.' as check_description
  ,'DRUG_ERA' as cdm_table_name
  ,'DRUG_ERA_END_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_drug_era_drug_era_end_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
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
FROM (
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM (
        /*violatedRowsBegin*/
        SELECT 
            'DRUG_ERA.DRUG_ERA_END_DATE' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('drug_era') }} cdmTable
        WHERE cdmTable.DRUG_ERA_END_DATE IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the DRUG_ERA_ID of the DRUG_ERA that is considered not nullable.' as check_description
  ,'DRUG_ERA' as cdm_table_name
  ,'DRUG_ERA_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_drug_era_drug_era_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = DRUG_ERA
cdmFieldName = DRUG_ERA_ID
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
            'DRUG_ERA.DRUG_ERA_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('drug_era') }} cdmTable
        WHERE cdmTable.DRUG_ERA_ID IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the DRUG_ERA_START_DATE of the DRUG_ERA that is considered not nullable.' as check_description
  ,'DRUG_ERA' as cdm_table_name
  ,'DRUG_ERA_START_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_drug_era_drug_era_start_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
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
FROM (
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM (
        /*violatedRowsBegin*/
        SELECT 
            'DRUG_ERA.DRUG_ERA_START_DATE' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('drug_era') }} cdmTable
        WHERE cdmTable.DRUG_ERA_START_DATE IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the PERSON_ID of the DRUG_ERA that is considered not nullable.' as check_description
  ,'DRUG_ERA' as cdm_table_name
  ,'PERSON_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_drug_era_person_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = DRUG_ERA
cdmFieldName = PERSON_ID
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
            'DRUG_ERA.PERSON_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('drug_era') }} cdmTable
        WHERE cdmTable.PERSON_ID IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the DRUG_CONCEPT_ID of the DRUG_EXPOSURE that is considered not nullable.' as check_description
  ,'DRUG_EXPOSURE' as cdm_table_name
  ,'DRUG_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_drug_exposure_drug_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = DRUG_EXPOSURE
cdmFieldName = DRUG_CONCEPT_ID
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
        WHERE cdmTable.DRUG_CONCEPT_ID IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the DRUG_EXPOSURE_END_DATE of the DRUG_EXPOSURE that is considered not nullable.' as check_description
  ,'DRUG_EXPOSURE' as cdm_table_name
  ,'DRUG_EXPOSURE_END_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_drug_exposure_drug_exposure_end_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
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
FROM (
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM (
        /*violatedRowsBegin*/
        SELECT 
            'DRUG_EXPOSURE.DRUG_EXPOSURE_END_DATE' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('drug_exposure') }} cdmTable
        WHERE cdmTable.DRUG_EXPOSURE_END_DATE IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the DRUG_EXPOSURE_ID of the DRUG_EXPOSURE that is considered not nullable.' as check_description
  ,'DRUG_EXPOSURE' as cdm_table_name
  ,'DRUG_EXPOSURE_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_drug_exposure_drug_exposure_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = DRUG_EXPOSURE
cdmFieldName = DRUG_EXPOSURE_ID
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
            'DRUG_EXPOSURE.DRUG_EXPOSURE_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('drug_exposure') }} cdmTable
        WHERE cdmTable.DRUG_EXPOSURE_ID IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the DRUG_EXPOSURE_START_DATE of the DRUG_EXPOSURE that is considered not nullable.' as check_description
  ,'DRUG_EXPOSURE' as cdm_table_name
  ,'DRUG_EXPOSURE_START_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_drug_exposure_drug_exposure_start_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
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
FROM (
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM (
        /*violatedRowsBegin*/
        SELECT 
            'DRUG_EXPOSURE.DRUG_EXPOSURE_START_DATE' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('drug_exposure') }} cdmTable
        WHERE cdmTable.DRUG_EXPOSURE_START_DATE IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the DRUG_TYPE_CONCEPT_ID of the DRUG_EXPOSURE that is considered not nullable.' as check_description
  ,'DRUG_EXPOSURE' as cdm_table_name
  ,'DRUG_TYPE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_drug_exposure_drug_type_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = DRUG_EXPOSURE
cdmFieldName = DRUG_TYPE_CONCEPT_ID
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
        WHERE cdmTable.DRUG_TYPE_CONCEPT_ID IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the PERSON_ID of the DRUG_EXPOSURE that is considered not nullable.' as check_description
  ,'DRUG_EXPOSURE' as cdm_table_name
  ,'PERSON_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_drug_exposure_person_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = DRUG_EXPOSURE
cdmFieldName = PERSON_ID
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
            'DRUG_EXPOSURE.PERSON_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('drug_exposure') }} cdmTable
        WHERE cdmTable.PERSON_ID IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the EPISODE_CONCEPT_ID of the EPISODE that is considered not nullable.' as check_description
  ,'EPISODE' as cdm_table_name
  ,'EPISODE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_episode_episode_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = EPISODE
cdmFieldName = EPISODE_CONCEPT_ID
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
        WHERE cdmTable.EPISODE_CONCEPT_ID IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the EPISODE_ID of the EPISODE that is considered not nullable.' as check_description
  ,'EPISODE' as cdm_table_name
  ,'EPISODE_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_episode_episode_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = EPISODE
cdmFieldName = EPISODE_ID
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
            'EPISODE.EPISODE_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('episode') }} cdmTable
        WHERE cdmTable.EPISODE_ID IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the EPISODE_OBJECT_CONCEPT_ID of the EPISODE that is considered not nullable.' as check_description
  ,'EPISODE' as cdm_table_name
  ,'EPISODE_OBJECT_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_episode_episode_object_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = EPISODE
cdmFieldName = EPISODE_OBJECT_CONCEPT_ID
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
            'EPISODE.EPISODE_OBJECT_CONCEPT_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('episode') }} cdmTable
        WHERE cdmTable.EPISODE_OBJECT_CONCEPT_ID IS NULL
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
( 
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('episode') }} cdmTable
) denominator
) cte

UNION ALL
SELECT cte.num_violated_rows
  ,cte.pct_violated_rows
  ,cte.num_denominator_rows
  , CAST('' as TEXT) as execution_time
  ,'' as query_text
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the EPISODE_START_DATE of the EPISODE that is considered not nullable.' as check_description
  ,'EPISODE' as cdm_table_name
  ,'EPISODE_START_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_episode_episode_start_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
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
FROM (
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM (
        /*violatedRowsBegin*/
        SELECT 
            'EPISODE.EPISODE_START_DATE' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('episode') }} cdmTable
        WHERE cdmTable.EPISODE_START_DATE IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the EPISODE_TYPE_CONCEPT_ID of the EPISODE that is considered not nullable.' as check_description
  ,'EPISODE' as cdm_table_name
  ,'EPISODE_TYPE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_episode_episode_type_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = EPISODE
cdmFieldName = EPISODE_TYPE_CONCEPT_ID
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
        WHERE cdmTable.EPISODE_TYPE_CONCEPT_ID IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the PERSON_ID of the EPISODE that is considered not nullable.' as check_description
  ,'EPISODE' as cdm_table_name
  ,'PERSON_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_episode_person_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = EPISODE
cdmFieldName = PERSON_ID
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
            'EPISODE.PERSON_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('episode') }} cdmTable
        WHERE cdmTable.PERSON_ID IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the EPISODE_EVENT_FIELD_CONCEPT_ID of the EPISODE_EVENT that is considered not nullable.' as check_description
  ,'EPISODE_EVENT' as cdm_table_name
  ,'EPISODE_EVENT_FIELD_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_episode_event_episode_event_field_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = EPISODE_EVENT
cdmFieldName = EPISODE_EVENT_FIELD_CONCEPT_ID
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
        WHERE cdmTable.EPISODE_EVENT_FIELD_CONCEPT_ID IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the EPISODE_ID of the EPISODE_EVENT that is considered not nullable.' as check_description
  ,'EPISODE_EVENT' as cdm_table_name
  ,'EPISODE_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_episode_event_episode_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = EPISODE_EVENT
cdmFieldName = EPISODE_ID
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
            'EPISODE_EVENT.EPISODE_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('episode_event') }} cdmTable
        WHERE cdmTable.EPISODE_ID IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the EVENT_ID of the EPISODE_EVENT that is considered not nullable.' as check_description
  ,'EPISODE_EVENT' as cdm_table_name
  ,'EVENT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_episode_event_event_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = EPISODE_EVENT
cdmFieldName = EVENT_ID
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
            'EPISODE_EVENT.EVENT_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('episode_event') }} cdmTable
        WHERE cdmTable.EVENT_ID IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the DOMAIN_CONCEPT_ID_1 of the FACT_RELATIONSHIP that is considered not nullable.' as check_description
  ,'FACT_RELATIONSHIP' as cdm_table_name
  ,'DOMAIN_CONCEPT_ID_1' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_fact_relationship_domain_concept_id_1' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = FACT_RELATIONSHIP
cdmFieldName = DOMAIN_CONCEPT_ID_1
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
            'FACT_RELATIONSHIP.DOMAIN_CONCEPT_ID_1' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('fact_relationship') }} cdmTable
        WHERE cdmTable.DOMAIN_CONCEPT_ID_1 IS NULL
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
( 
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('fact_relationship') }} cdmTable
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the DOMAIN_CONCEPT_ID_2 of the FACT_RELATIONSHIP that is considered not nullable.' as check_description
  ,'FACT_RELATIONSHIP' as cdm_table_name
  ,'DOMAIN_CONCEPT_ID_2' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_fact_relationship_domain_concept_id_2' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = FACT_RELATIONSHIP
cdmFieldName = DOMAIN_CONCEPT_ID_2
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
            'FACT_RELATIONSHIP.DOMAIN_CONCEPT_ID_2' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('fact_relationship') }} cdmTable
        WHERE cdmTable.DOMAIN_CONCEPT_ID_2 IS NULL
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
( 
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('fact_relationship') }} cdmTable
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the FACT_ID_1 of the FACT_RELATIONSHIP that is considered not nullable.' as check_description
  ,'FACT_RELATIONSHIP' as cdm_table_name
  ,'FACT_ID_1' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_fact_relationship_fact_id_1' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = FACT_RELATIONSHIP
cdmFieldName = FACT_ID_1
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
            'FACT_RELATIONSHIP.FACT_ID_1' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('fact_relationship') }} cdmTable
        WHERE cdmTable.FACT_ID_1 IS NULL
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
( 
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('fact_relationship') }} cdmTable
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the FACT_ID_2 of the FACT_RELATIONSHIP that is considered not nullable.' as check_description
  ,'FACT_RELATIONSHIP' as cdm_table_name
  ,'FACT_ID_2' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_fact_relationship_fact_id_2' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = FACT_RELATIONSHIP
cdmFieldName = FACT_ID_2
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
            'FACT_RELATIONSHIP.FACT_ID_2' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('fact_relationship') }} cdmTable
        WHERE cdmTable.FACT_ID_2 IS NULL
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
( 
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('fact_relationship') }} cdmTable
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the RELATIONSHIP_CONCEPT_ID of the FACT_RELATIONSHIP that is considered not nullable.' as check_description
  ,'FACT_RELATIONSHIP' as cdm_table_name
  ,'RELATIONSHIP_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_fact_relationship_relationship_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = FACT_RELATIONSHIP
cdmFieldName = RELATIONSHIP_CONCEPT_ID
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
            'FACT_RELATIONSHIP.RELATIONSHIP_CONCEPT_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('fact_relationship') }} cdmTable
        WHERE cdmTable.RELATIONSHIP_CONCEPT_ID IS NULL
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
( 
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('fact_relationship') }} cdmTable
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the LOCATION_ID of the LOCATION that is considered not nullable.' as check_description
  ,'LOCATION' as cdm_table_name
  ,'LOCATION_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_location_location_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = LOCATION
cdmFieldName = LOCATION_ID
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
            'LOCATION.LOCATION_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('location') }} cdmTable
        WHERE cdmTable.LOCATION_ID IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the MEASUREMENT_CONCEPT_ID of the MEASUREMENT that is considered not nullable.' as check_description
  ,'MEASUREMENT' as cdm_table_name
  ,'MEASUREMENT_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_measurement_measurement_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = MEASUREMENT
cdmFieldName = MEASUREMENT_CONCEPT_ID
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
        WHERE cdmTable.MEASUREMENT_CONCEPT_ID IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the MEASUREMENT_DATE of the MEASUREMENT that is considered not nullable.' as check_description
  ,'MEASUREMENT' as cdm_table_name
  ,'MEASUREMENT_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_measurement_measurement_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
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
FROM (
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM (
        /*violatedRowsBegin*/
        SELECT 
            'MEASUREMENT.MEASUREMENT_DATE' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('measurement') }} cdmTable
        WHERE cdmTable.MEASUREMENT_DATE IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the MEASUREMENT_ID of the MEASUREMENT that is considered not nullable.' as check_description
  ,'MEASUREMENT' as cdm_table_name
  ,'MEASUREMENT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_measurement_measurement_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = MEASUREMENT
cdmFieldName = MEASUREMENT_ID
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
            'MEASUREMENT.MEASUREMENT_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('measurement') }} cdmTable
        WHERE cdmTable.MEASUREMENT_ID IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the MEASUREMENT_TYPE_CONCEPT_ID of the MEASUREMENT that is considered not nullable.' as check_description
  ,'MEASUREMENT' as cdm_table_name
  ,'MEASUREMENT_TYPE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_measurement_measurement_type_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = MEASUREMENT
cdmFieldName = MEASUREMENT_TYPE_CONCEPT_ID
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
        WHERE cdmTable.MEASUREMENT_TYPE_CONCEPT_ID IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the PERSON_ID of the MEASUREMENT that is considered not nullable.' as check_description
  ,'MEASUREMENT' as cdm_table_name
  ,'PERSON_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_measurement_person_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = MEASUREMENT
cdmFieldName = PERSON_ID
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
            'MEASUREMENT.PERSON_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('measurement') }} cdmTable
        WHERE cdmTable.PERSON_ID IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the METADATA_CONCEPT_ID of the METADATA that is considered not nullable.' as check_description
  ,'METADATA' as cdm_table_name
  ,'METADATA_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_metadata_metadata_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = METADATA
cdmFieldName = METADATA_CONCEPT_ID
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
            'METADATA.METADATA_CONCEPT_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('metadata') }} cdmTable
        WHERE cdmTable.METADATA_CONCEPT_ID IS NULL
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
( 
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('metadata') }} cdmTable
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the METADATA_ID of the METADATA that is considered not nullable.' as check_description
  ,'METADATA' as cdm_table_name
  ,'METADATA_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_metadata_metadata_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = METADATA
cdmFieldName = METADATA_ID
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
            'METADATA.METADATA_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('metadata') }} cdmTable
        WHERE cdmTable.METADATA_ID IS NULL
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
( 
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('metadata') }} cdmTable
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the METADATA_TYPE_CONCEPT_ID of the METADATA that is considered not nullable.' as check_description
  ,'METADATA' as cdm_table_name
  ,'METADATA_TYPE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_metadata_metadata_type_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = METADATA
cdmFieldName = METADATA_TYPE_CONCEPT_ID
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
            'METADATA.METADATA_TYPE_CONCEPT_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('metadata') }} cdmTable
        WHERE cdmTable.METADATA_TYPE_CONCEPT_ID IS NULL
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
( 
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('metadata') }} cdmTable
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the NAME of the METADATA that is considered not nullable.' as check_description
  ,'METADATA' as cdm_table_name
  ,'NAME' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_metadata_name' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = METADATA
cdmFieldName = NAME
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
            'METADATA.NAME' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('metadata') }} cdmTable
        WHERE cdmTable.NAME IS NULL
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
( 
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('metadata') }} cdmTable
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the ENCODING_CONCEPT_ID of the NOTE that is considered not nullable.' as check_description
  ,'NOTE' as cdm_table_name
  ,'ENCODING_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_note_encoding_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = NOTE
cdmFieldName = ENCODING_CONCEPT_ID
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
            'NOTE.ENCODING_CONCEPT_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('note') }} cdmTable
        WHERE cdmTable.ENCODING_CONCEPT_ID IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the LANGUAGE_CONCEPT_ID of the NOTE that is considered not nullable.' as check_description
  ,'NOTE' as cdm_table_name
  ,'LANGUAGE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_note_language_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = NOTE
cdmFieldName = LANGUAGE_CONCEPT_ID
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
            'NOTE.LANGUAGE_CONCEPT_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('note') }} cdmTable
        WHERE cdmTable.LANGUAGE_CONCEPT_ID IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the NOTE_CLASS_CONCEPT_ID of the NOTE that is considered not nullable.' as check_description
  ,'NOTE' as cdm_table_name
  ,'NOTE_CLASS_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_note_note_class_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = NOTE
cdmFieldName = NOTE_CLASS_CONCEPT_ID
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
            'NOTE.NOTE_CLASS_CONCEPT_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('note') }} cdmTable
        WHERE cdmTable.NOTE_CLASS_CONCEPT_ID IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the NOTE_DATE of the NOTE that is considered not nullable.' as check_description
  ,'NOTE' as cdm_table_name
  ,'NOTE_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_note_note_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
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
FROM (
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM (
        /*violatedRowsBegin*/
        SELECT 
            'NOTE.NOTE_DATE' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('note') }} cdmTable
        WHERE cdmTable.NOTE_DATE IS NULL
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
( 
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('note') }} cdmTable
) denominator
) cte

UNION ALL
SELECT cte.num_violated_rows
  ,cte.pct_violated_rows
  ,cte.num_denominator_rows
  , CAST('' as TEXT) as execution_time
  ,'' as query_text
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the NOTE_ID of the NOTE that is considered not nullable.' as check_description
  ,'NOTE' as cdm_table_name
  ,'NOTE_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_note_note_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = NOTE
cdmFieldName = NOTE_ID
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
            'NOTE.NOTE_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('note') }} cdmTable
        WHERE cdmTable.NOTE_ID IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the NOTE_TEXT of the NOTE that is considered not nullable.' as check_description
  ,'NOTE' as cdm_table_name
  ,'NOTE_TEXT' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_note_note_text' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = NOTE
cdmFieldName = NOTE_TEXT
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
            'NOTE.NOTE_TEXT' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('note') }} cdmTable
        WHERE cdmTable.NOTE_TEXT IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the NOTE_TYPE_CONCEPT_ID of the NOTE that is considered not nullable.' as check_description
  ,'NOTE' as cdm_table_name
  ,'NOTE_TYPE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_note_note_type_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = NOTE
cdmFieldName = NOTE_TYPE_CONCEPT_ID
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
        WHERE cdmTable.NOTE_TYPE_CONCEPT_ID IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the PERSON_ID of the NOTE that is considered not nullable.' as check_description
  ,'NOTE' as cdm_table_name
  ,'PERSON_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_note_person_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = NOTE
cdmFieldName = PERSON_ID
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
            'NOTE.PERSON_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('note') }} cdmTable
        WHERE cdmTable.PERSON_ID IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the LEXICAL_VARIANT of the NOTE_NLP that is considered not nullable.' as check_description
  ,'NOTE_NLP' as cdm_table_name
  ,'LEXICAL_VARIANT' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_note_nlp_lexical_variant' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = NOTE_NLP
cdmFieldName = LEXICAL_VARIANT
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
            'NOTE_NLP.LEXICAL_VARIANT' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('note_nlp') }} cdmTable
        WHERE cdmTable.LEXICAL_VARIANT IS NULL
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
( 
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('note_nlp') }} cdmTable
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the NLP_DATE of the NOTE_NLP that is considered not nullable.' as check_description
  ,'NOTE_NLP' as cdm_table_name
  ,'NLP_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_note_nlp_nlp_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = NOTE_NLP
cdmFieldName = NLP_DATE
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
            'NOTE_NLP.NLP_DATE' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('note_nlp') }} cdmTable
        WHERE cdmTable.NLP_DATE IS NULL
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
( 
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('note_nlp') }} cdmTable
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the NOTE_ID of the NOTE_NLP that is considered not nullable.' as check_description
  ,'NOTE_NLP' as cdm_table_name
  ,'NOTE_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_note_nlp_note_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = NOTE_NLP
cdmFieldName = NOTE_ID
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
            'NOTE_NLP.NOTE_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('note_nlp') }} cdmTable
        WHERE cdmTable.NOTE_ID IS NULL
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
( 
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('note_nlp') }} cdmTable
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the NOTE_NLP_ID of the NOTE_NLP that is considered not nullable.' as check_description
  ,'NOTE_NLP' as cdm_table_name
  ,'NOTE_NLP_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_note_nlp_note_nlp_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = NOTE_NLP
cdmFieldName = NOTE_NLP_ID
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
            'NOTE_NLP.NOTE_NLP_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('note_nlp') }} cdmTable
        WHERE cdmTable.NOTE_NLP_ID IS NULL
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
( 
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('note_nlp') }} cdmTable
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the OBSERVATION_CONCEPT_ID of the OBSERVATION that is considered not nullable.' as check_description
  ,'OBSERVATION' as cdm_table_name
  ,'OBSERVATION_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_observation_observation_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = OBSERVATION
cdmFieldName = OBSERVATION_CONCEPT_ID
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
            'OBSERVATION.OBSERVATION_CONCEPT_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('observation') }} cdmTable
        WHERE cdmTable.OBSERVATION_CONCEPT_ID IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the OBSERVATION_DATE of the OBSERVATION that is considered not nullable.' as check_description
  ,'OBSERVATION' as cdm_table_name
  ,'OBSERVATION_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_observation_observation_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
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
FROM (
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM (
        /*violatedRowsBegin*/
        SELECT 
            'OBSERVATION.OBSERVATION_DATE' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('observation') }} cdmTable
        WHERE cdmTable.OBSERVATION_DATE IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the OBSERVATION_ID of the OBSERVATION that is considered not nullable.' as check_description
  ,'OBSERVATION' as cdm_table_name
  ,'OBSERVATION_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_observation_observation_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = OBSERVATION
cdmFieldName = OBSERVATION_ID
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
            'OBSERVATION.OBSERVATION_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('observation') }} cdmTable
        WHERE cdmTable.OBSERVATION_ID IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the OBSERVATION_TYPE_CONCEPT_ID of the OBSERVATION that is considered not nullable.' as check_description
  ,'OBSERVATION' as cdm_table_name
  ,'OBSERVATION_TYPE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_observation_observation_type_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = OBSERVATION
cdmFieldName = OBSERVATION_TYPE_CONCEPT_ID
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
        WHERE cdmTable.OBSERVATION_TYPE_CONCEPT_ID IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the PERSON_ID of the OBSERVATION that is considered not nullable.' as check_description
  ,'OBSERVATION' as cdm_table_name
  ,'PERSON_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_observation_person_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = OBSERVATION
cdmFieldName = PERSON_ID
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
            'OBSERVATION.PERSON_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('observation') }} cdmTable
        WHERE cdmTable.PERSON_ID IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the OBSERVATION_PERIOD_END_DATE of the OBSERVATION_PERIOD that is considered not nullable.' as check_description
  ,'OBSERVATION_PERIOD' as cdm_table_name
  ,'OBSERVATION_PERIOD_END_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_observation_period_observation_period_end_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
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
FROM (
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM (
        /*violatedRowsBegin*/
        SELECT 
            'OBSERVATION_PERIOD.OBSERVATION_PERIOD_END_DATE' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('observation_period') }} cdmTable
        WHERE cdmTable.OBSERVATION_PERIOD_END_DATE IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the OBSERVATION_PERIOD_ID of the OBSERVATION_PERIOD that is considered not nullable.' as check_description
  ,'OBSERVATION_PERIOD' as cdm_table_name
  ,'OBSERVATION_PERIOD_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_observation_period_observation_period_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = OBSERVATION_PERIOD
cdmFieldName = OBSERVATION_PERIOD_ID
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
            'OBSERVATION_PERIOD.OBSERVATION_PERIOD_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('observation_period') }} cdmTable
        WHERE cdmTable.OBSERVATION_PERIOD_ID IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the OBSERVATION_PERIOD_START_DATE of the OBSERVATION_PERIOD that is considered not nullable.' as check_description
  ,'OBSERVATION_PERIOD' as cdm_table_name
  ,'OBSERVATION_PERIOD_START_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_observation_period_observation_period_start_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
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
FROM (
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM (
        /*violatedRowsBegin*/
        SELECT 
            'OBSERVATION_PERIOD.OBSERVATION_PERIOD_START_DATE' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('observation_period') }} cdmTable
        WHERE cdmTable.OBSERVATION_PERIOD_START_DATE IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the PERIOD_TYPE_CONCEPT_ID of the OBSERVATION_PERIOD that is considered not nullable.' as check_description
  ,'OBSERVATION_PERIOD' as cdm_table_name
  ,'PERIOD_TYPE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_observation_period_period_type_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = OBSERVATION_PERIOD
cdmFieldName = PERIOD_TYPE_CONCEPT_ID
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
        WHERE cdmTable.PERIOD_TYPE_CONCEPT_ID IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the PERSON_ID of the OBSERVATION_PERIOD that is considered not nullable.' as check_description
  ,'OBSERVATION_PERIOD' as cdm_table_name
  ,'PERSON_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_observation_period_person_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = OBSERVATION_PERIOD
cdmFieldName = PERSON_ID
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
            'OBSERVATION_PERIOD.PERSON_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('observation_period') }} cdmTable
        WHERE cdmTable.PERSON_ID IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the PAYER_PLAN_PERIOD_END_DATE of the PAYER_PLAN_PERIOD that is considered not nullable.' as check_description
  ,'PAYER_PLAN_PERIOD' as cdm_table_name
  ,'PAYER_PLAN_PERIOD_END_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_payer_plan_period_payer_plan_period_end_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
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
FROM (
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM (
        /*violatedRowsBegin*/
        SELECT 
            'PAYER_PLAN_PERIOD.PAYER_PLAN_PERIOD_END_DATE' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('payer_plan_period') }} cdmTable
        WHERE cdmTable.PAYER_PLAN_PERIOD_END_DATE IS NULL
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
( 
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('payer_plan_period') }} cdmTable
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the PAYER_PLAN_PERIOD_ID of the PAYER_PLAN_PERIOD that is considered not nullable.' as check_description
  ,'PAYER_PLAN_PERIOD' as cdm_table_name
  ,'PAYER_PLAN_PERIOD_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_payer_plan_period_payer_plan_period_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = PAYER_PLAN_PERIOD
cdmFieldName = PAYER_PLAN_PERIOD_ID
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
            'PAYER_PLAN_PERIOD.PAYER_PLAN_PERIOD_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('payer_plan_period') }} cdmTable
        WHERE cdmTable.PAYER_PLAN_PERIOD_ID IS NULL
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
( 
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('payer_plan_period') }} cdmTable
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the PAYER_PLAN_PERIOD_START_DATE of the PAYER_PLAN_PERIOD that is considered not nullable.' as check_description
  ,'PAYER_PLAN_PERIOD' as cdm_table_name
  ,'PAYER_PLAN_PERIOD_START_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_payer_plan_period_payer_plan_period_start_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
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
FROM (
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM (
        /*violatedRowsBegin*/
        SELECT 
            'PAYER_PLAN_PERIOD.PAYER_PLAN_PERIOD_START_DATE' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('payer_plan_period') }} cdmTable
        WHERE cdmTable.PAYER_PLAN_PERIOD_START_DATE IS NULL
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
( 
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('payer_plan_period') }} cdmTable
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the PERSON_ID of the PAYER_PLAN_PERIOD that is considered not nullable.' as check_description
  ,'PAYER_PLAN_PERIOD' as cdm_table_name
  ,'PERSON_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_payer_plan_period_person_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = PAYER_PLAN_PERIOD
cdmFieldName = PERSON_ID
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
            'PAYER_PLAN_PERIOD.PERSON_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('payer_plan_period') }} cdmTable
        WHERE cdmTable.PERSON_ID IS NULL
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
( 
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('payer_plan_period') }} cdmTable
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the ETHNICITY_CONCEPT_ID of the PERSON that is considered not nullable.' as check_description
  ,'PERSON' as cdm_table_name
  ,'ETHNICITY_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_person_ethnicity_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = PERSON
cdmFieldName = ETHNICITY_CONCEPT_ID
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
        WHERE cdmTable.ETHNICITY_CONCEPT_ID IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the GENDER_CONCEPT_ID of the PERSON that is considered not nullable.' as check_description
  ,'PERSON' as cdm_table_name
  ,'GENDER_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_person_gender_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = PERSON
cdmFieldName = GENDER_CONCEPT_ID
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
        WHERE cdmTable.GENDER_CONCEPT_ID IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the PERSON_ID of the PERSON that is considered not nullable.' as check_description
  ,'PERSON' as cdm_table_name
  ,'PERSON_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_person_person_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = PERSON
cdmFieldName = PERSON_ID
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
            'PERSON.PERSON_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('person') }} cdmTable
        WHERE cdmTable.PERSON_ID IS NULL
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
( 
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('person') }} cdmTable
) denominator
) cte

UNION ALL
SELECT cte.num_violated_rows
  ,cte.pct_violated_rows
  ,cte.num_denominator_rows
  , CAST('' as TEXT) as execution_time
  ,'' as query_text
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the RACE_CONCEPT_ID of the PERSON that is considered not nullable.' as check_description
  ,'PERSON' as cdm_table_name
  ,'RACE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_person_race_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = PERSON
cdmFieldName = RACE_CONCEPT_ID
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
        WHERE cdmTable.RACE_CONCEPT_ID IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the YEAR_OF_BIRTH of the PERSON that is considered not nullable.' as check_description
  ,'PERSON' as cdm_table_name
  ,'YEAR_OF_BIRTH' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_person_year_of_birth' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = PERSON
cdmFieldName = YEAR_OF_BIRTH
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
            'PERSON.YEAR_OF_BIRTH' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('person') }} cdmTable
        WHERE cdmTable.YEAR_OF_BIRTH IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the PERSON_ID of the PROCEDURE_OCCURRENCE that is considered not nullable.' as check_description
  ,'PROCEDURE_OCCURRENCE' as cdm_table_name
  ,'PERSON_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_procedure_occurrence_person_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = PROCEDURE_OCCURRENCE
cdmFieldName = PERSON_ID
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
            'PROCEDURE_OCCURRENCE.PERSON_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('procedure_occurrence') }} cdmTable
        WHERE cdmTable.PERSON_ID IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the PROCEDURE_CONCEPT_ID of the PROCEDURE_OCCURRENCE that is considered not nullable.' as check_description
  ,'PROCEDURE_OCCURRENCE' as cdm_table_name
  ,'PROCEDURE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_procedure_occurrence_procedure_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = PROCEDURE_OCCURRENCE
cdmFieldName = PROCEDURE_CONCEPT_ID
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
        WHERE cdmTable.PROCEDURE_CONCEPT_ID IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the PROCEDURE_DATE of the PROCEDURE_OCCURRENCE that is considered not nullable.' as check_description
  ,'PROCEDURE_OCCURRENCE' as cdm_table_name
  ,'PROCEDURE_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_procedure_occurrence_procedure_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
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
FROM (
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM (
        /*violatedRowsBegin*/
        SELECT 
            'PROCEDURE_OCCURRENCE.PROCEDURE_DATE' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('procedure_occurrence') }} cdmTable
        WHERE cdmTable.PROCEDURE_DATE IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the PROCEDURE_OCCURRENCE_ID of the PROCEDURE_OCCURRENCE that is considered not nullable.' as check_description
  ,'PROCEDURE_OCCURRENCE' as cdm_table_name
  ,'PROCEDURE_OCCURRENCE_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_procedure_occurrence_procedure_occurrence_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = PROCEDURE_OCCURRENCE
cdmFieldName = PROCEDURE_OCCURRENCE_ID
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
            'PROCEDURE_OCCURRENCE.PROCEDURE_OCCURRENCE_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('procedure_occurrence') }} cdmTable
        WHERE cdmTable.PROCEDURE_OCCURRENCE_ID IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the PROCEDURE_TYPE_CONCEPT_ID of the PROCEDURE_OCCURRENCE that is considered not nullable.' as check_description
  ,'PROCEDURE_OCCURRENCE' as cdm_table_name
  ,'PROCEDURE_TYPE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_procedure_occurrence_procedure_type_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = PROCEDURE_OCCURRENCE
cdmFieldName = PROCEDURE_TYPE_CONCEPT_ID
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
        WHERE cdmTable.PROCEDURE_TYPE_CONCEPT_ID IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the PROVIDER_ID of the PROVIDER that is considered not nullable.' as check_description
  ,'PROVIDER' as cdm_table_name
  ,'PROVIDER_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_provider_provider_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = PROVIDER
cdmFieldName = PROVIDER_ID
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
            'PROVIDER.PROVIDER_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('provider') }} cdmTable
        WHERE cdmTable.PROVIDER_ID IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the PERSON_ID of the SPECIMEN that is considered not nullable.' as check_description
  ,'SPECIMEN' as cdm_table_name
  ,'PERSON_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_specimen_person_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = SPECIMEN
cdmFieldName = PERSON_ID
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
            'SPECIMEN.PERSON_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('specimen') }} cdmTable
        WHERE cdmTable.PERSON_ID IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the SPECIMEN_CONCEPT_ID of the SPECIMEN that is considered not nullable.' as check_description
  ,'SPECIMEN' as cdm_table_name
  ,'SPECIMEN_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_specimen_specimen_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = SPECIMEN
cdmFieldName = SPECIMEN_CONCEPT_ID
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
            'SPECIMEN.SPECIMEN_CONCEPT_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('specimen') }} cdmTable
        WHERE cdmTable.SPECIMEN_CONCEPT_ID IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the SPECIMEN_DATE of the SPECIMEN that is considered not nullable.' as check_description
  ,'SPECIMEN' as cdm_table_name
  ,'SPECIMEN_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_specimen_specimen_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
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
FROM (
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM (
        /*violatedRowsBegin*/
        SELECT 
            'SPECIMEN.SPECIMEN_DATE' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('specimen') }} cdmTable
        WHERE cdmTable.SPECIMEN_DATE IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the SPECIMEN_ID of the SPECIMEN that is considered not nullable.' as check_description
  ,'SPECIMEN' as cdm_table_name
  ,'SPECIMEN_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_specimen_specimen_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = SPECIMEN
cdmFieldName = SPECIMEN_ID
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
            'SPECIMEN.SPECIMEN_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('specimen') }} cdmTable
        WHERE cdmTable.SPECIMEN_ID IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the SPECIMEN_TYPE_CONCEPT_ID of the SPECIMEN that is considered not nullable.' as check_description
  ,'SPECIMEN' as cdm_table_name
  ,'SPECIMEN_TYPE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_specimen_specimen_type_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = SPECIMEN
cdmFieldName = SPECIMEN_TYPE_CONCEPT_ID
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
        WHERE cdmTable.SPECIMEN_TYPE_CONCEPT_ID IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the PERSON_ID of the VISIT_DETAIL that is considered not nullable.' as check_description
  ,'VISIT_DETAIL' as cdm_table_name
  ,'PERSON_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_visit_detail_person_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = VISIT_DETAIL
cdmFieldName = PERSON_ID
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
            'VISIT_DETAIL.PERSON_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('visit_detail') }} cdmTable
        WHERE cdmTable.PERSON_ID IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the VISIT_DETAIL_CONCEPT_ID of the VISIT_DETAIL that is considered not nullable.' as check_description
  ,'VISIT_DETAIL' as cdm_table_name
  ,'VISIT_DETAIL_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_visit_detail_visit_detail_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = VISIT_DETAIL
cdmFieldName = VISIT_DETAIL_CONCEPT_ID
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
        WHERE cdmTable.VISIT_DETAIL_CONCEPT_ID IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the VISIT_DETAIL_END_DATE of the VISIT_DETAIL that is considered not nullable.' as check_description
  ,'VISIT_DETAIL' as cdm_table_name
  ,'VISIT_DETAIL_END_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_visit_detail_visit_detail_end_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
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
FROM (
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM (
        /*violatedRowsBegin*/
        SELECT 
            'VISIT_DETAIL.VISIT_DETAIL_END_DATE' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('visit_detail') }} cdmTable
        WHERE cdmTable.VISIT_DETAIL_END_DATE IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the VISIT_DETAIL_ID of the VISIT_DETAIL that is considered not nullable.' as check_description
  ,'VISIT_DETAIL' as cdm_table_name
  ,'VISIT_DETAIL_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_visit_detail_visit_detail_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = VISIT_DETAIL
cdmFieldName = VISIT_DETAIL_ID
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
            'VISIT_DETAIL.VISIT_DETAIL_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('visit_detail') }} cdmTable
        WHERE cdmTable.VISIT_DETAIL_ID IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the VISIT_DETAIL_START_DATE of the VISIT_DETAIL that is considered not nullable.' as check_description
  ,'VISIT_DETAIL' as cdm_table_name
  ,'VISIT_DETAIL_START_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_visit_detail_visit_detail_start_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
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
FROM (
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM (
        /*violatedRowsBegin*/
        SELECT 
            'VISIT_DETAIL.VISIT_DETAIL_START_DATE' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('visit_detail') }} cdmTable
        WHERE cdmTable.VISIT_DETAIL_START_DATE IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the VISIT_DETAIL_TYPE_CONCEPT_ID of the VISIT_DETAIL that is considered not nullable.' as check_description
  ,'VISIT_DETAIL' as cdm_table_name
  ,'VISIT_DETAIL_TYPE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_visit_detail_visit_detail_type_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = VISIT_DETAIL
cdmFieldName = VISIT_DETAIL_TYPE_CONCEPT_ID
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
        WHERE cdmTable.VISIT_DETAIL_TYPE_CONCEPT_ID IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the VISIT_OCCURRENCE_ID of the VISIT_DETAIL that is considered not nullable.' as check_description
  ,'VISIT_DETAIL' as cdm_table_name
  ,'VISIT_OCCURRENCE_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_visit_detail_visit_occurrence_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = VISIT_DETAIL
cdmFieldName = VISIT_OCCURRENCE_ID
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
            'VISIT_DETAIL.VISIT_OCCURRENCE_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('visit_detail') }} cdmTable
        WHERE cdmTable.VISIT_OCCURRENCE_ID IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the PERSON_ID of the VISIT_OCCURRENCE that is considered not nullable.' as check_description
  ,'VISIT_OCCURRENCE' as cdm_table_name
  ,'PERSON_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_visit_occurrence_person_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = VISIT_OCCURRENCE
cdmFieldName = PERSON_ID
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
            'VISIT_OCCURRENCE.PERSON_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('visit_occurrence') }} cdmTable
        WHERE cdmTable.PERSON_ID IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the VISIT_CONCEPT_ID of the VISIT_OCCURRENCE that is considered not nullable.' as check_description
  ,'VISIT_OCCURRENCE' as cdm_table_name
  ,'VISIT_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_visit_occurrence_visit_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = VISIT_OCCURRENCE
cdmFieldName = VISIT_CONCEPT_ID
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
        WHERE cdmTable.VISIT_CONCEPT_ID IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the VISIT_END_DATE of the VISIT_OCCURRENCE that is considered not nullable.' as check_description
  ,'VISIT_OCCURRENCE' as cdm_table_name
  ,'VISIT_END_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_visit_occurrence_visit_end_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
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
FROM (
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM (
        /*violatedRowsBegin*/
        SELECT 
            'VISIT_OCCURRENCE.VISIT_END_DATE' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('visit_occurrence') }} cdmTable
        WHERE cdmTable.VISIT_END_DATE IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the VISIT_OCCURRENCE_ID of the VISIT_OCCURRENCE that is considered not nullable.' as check_description
  ,'VISIT_OCCURRENCE' as cdm_table_name
  ,'VISIT_OCCURRENCE_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_visit_occurrence_visit_occurrence_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = VISIT_OCCURRENCE
cdmFieldName = VISIT_OCCURRENCE_ID
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
            'VISIT_OCCURRENCE.VISIT_OCCURRENCE_ID' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('visit_occurrence') }} cdmTable
        WHERE cdmTable.VISIT_OCCURRENCE_ID IS NULL
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
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the VISIT_START_DATE of the VISIT_OCCURRENCE that is considered not nullable.' as check_description
  ,'VISIT_OCCURRENCE' as cdm_table_name
  ,'VISIT_START_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_visit_occurrence_visit_start_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
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
FROM (
    SELECT 
        COUNT(violated_rows.violating_field) AS num_violated_rows
    FROM (
        /*violatedRowsBegin*/
        SELECT 
            'VISIT_OCCURRENCE.VISIT_START_DATE' AS violating_field, 
            cdmTable.* 
        FROM {{ ref('visit_occurrence') }} cdmTable
        WHERE cdmTable.VISIT_START_DATE IS NULL
        /*violatedRowsEnd*/
    ) violated_rows
) violated_row_count,
( 
    SELECT 
        COUNT(*) AS num_rows
    FROM {{ ref('visit_occurrence') }} cdmTable
) denominator
) cte

UNION ALL
SELECT cte.num_violated_rows
  ,cte.pct_violated_rows
  ,cte.num_denominator_rows
  , CAST('' as TEXT) as execution_time
  ,'' as query_text
  ,'isRequired' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a NULL value in the VISIT_TYPE_CONCEPT_ID of the VISIT_OCCURRENCE that is considered not nullable.' as check_description
  ,'VISIT_OCCURRENCE' as cdm_table_name
  ,'VISIT_TYPE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_is_not_nullable.sql' as sql_file
  ,'Conformance' as category
  ,'Relational' as subcategory
  ,'Validation' as context
  ,'' as warning
  ,'' as error
  ,'field_isrequired_visit_occurrence_visit_type_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_IS_REQUIRED
Check that values in fields where isRequired == TRUE are non-null
Parameters used in this template:
schema = cdm
cdmTableName = VISIT_OCCURRENCE
cdmFieldName = VISIT_TYPE_CONCEPT_ID
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
        WHERE cdmTable.VISIT_TYPE_CONCEPT_ID IS NULL
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
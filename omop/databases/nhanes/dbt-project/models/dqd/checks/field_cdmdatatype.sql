

/*********
SQL to insert individual DQD results directly into output table, rather than waiting until collecting all results.
Note that this  does not include information about SQL errors or performance
**********/
WITH cte_all  AS (SELECT cte.num_violated_rows
  ,cte.pct_violated_rows
  ,cte.num_denominator_rows
  , CAST('' as TEXT) as execution_time
  ,'' as query_text
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the CARE_SITE_ID in the CARE_SITE is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'CARE_SITE' as cdm_table_name
  ,'CARE_SITE_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_care_site_care_site_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'CARE_SITE.CARE_SITE_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('care_site') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.CARE_SITE_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.CARE_SITE_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.CARE_SITE_ID) AS varchar),'.') != 0))
			AND cdmTable.CARE_SITE_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('care_site') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the LOCATION_ID in the CARE_SITE is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'CARE_SITE' as cdm_table_name
  ,'LOCATION_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_care_site_location_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = CARE_SITE
cdmFieldName = LOCATION_ID
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
			'CARE_SITE.LOCATION_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('care_site') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.LOCATION_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.LOCATION_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.LOCATION_ID) AS varchar),'.') != 0))
			AND cdmTable.LOCATION_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('care_site') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the PLACE_OF_SERVICE_CONCEPT_ID in the CARE_SITE is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'CARE_SITE' as cdm_table_name
  ,'PLACE_OF_SERVICE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_care_site_place_of_service_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = CARE_SITE
cdmFieldName = PLACE_OF_SERVICE_CONCEPT_ID
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
			'CARE_SITE.PLACE_OF_SERVICE_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('care_site') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.PLACE_OF_SERVICE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.PLACE_OF_SERVICE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.PLACE_OF_SERVICE_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.PLACE_OF_SERVICE_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('care_site') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the CDM_VERSION_CONCEPT_ID in the CDM_SOURCE is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'CDM_SOURCE' as cdm_table_name
  ,'CDM_VERSION_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_cdm_source_cdm_version_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'CDM_SOURCE.CDM_VERSION_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('cdm_source') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.CDM_VERSION_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.CDM_VERSION_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.CDM_VERSION_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.CDM_VERSION_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('cdm_source') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the CONDITION_CONCEPT_ID in the CONDITION_ERA is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'CONDITION_ERA' as cdm_table_name
  ,'CONDITION_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_condition_era_condition_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'CONDITION_ERA.CONDITION_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('condition_era') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.CONDITION_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.CONDITION_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.CONDITION_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.CONDITION_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('condition_era') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the CONDITION_ERA_ID in the CONDITION_ERA is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'CONDITION_ERA' as cdm_table_name
  ,'CONDITION_ERA_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_condition_era_condition_era_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'CONDITION_ERA.CONDITION_ERA_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('condition_era') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.CONDITION_ERA_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.CONDITION_ERA_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.CONDITION_ERA_ID) AS varchar),'.') != 0))
			AND cdmTable.CONDITION_ERA_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('condition_era') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the CONDITION_OCCURRENCE_COUNT in the CONDITION_ERA is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'CONDITION_ERA' as cdm_table_name
  ,'CONDITION_OCCURRENCE_COUNT' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_condition_era_condition_occurrence_count' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = CONDITION_ERA
cdmFieldName = CONDITION_OCCURRENCE_COUNT
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
			'CONDITION_ERA.CONDITION_OCCURRENCE_COUNT' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('condition_era') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.CONDITION_OCCURRENCE_COUNT AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.CONDITION_OCCURRENCE_COUNT AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.CONDITION_OCCURRENCE_COUNT) AS varchar),'.') != 0))
			AND cdmTable.CONDITION_OCCURRENCE_COUNT IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('condition_era') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the PERSON_ID in the CONDITION_ERA is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'CONDITION_ERA' as cdm_table_name
  ,'PERSON_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_condition_era_person_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'CONDITION_ERA.PERSON_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('condition_era') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.PERSON_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.PERSON_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.PERSON_ID) AS varchar),'.') != 0))
			AND cdmTable.PERSON_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('condition_era') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the CONDITION_CONCEPT_ID in the CONDITION_OCCURRENCE is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'CONDITION_OCCURRENCE' as cdm_table_name
  ,'CONDITION_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_condition_occurrence_condition_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'CONDITION_OCCURRENCE.CONDITION_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('condition_occurrence') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.CONDITION_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.CONDITION_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.CONDITION_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.CONDITION_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('condition_occurrence') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the CONDITION_OCCURRENCE_ID in the CONDITION_OCCURRENCE is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'CONDITION_OCCURRENCE' as cdm_table_name
  ,'CONDITION_OCCURRENCE_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_condition_occurrence_condition_occurrence_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'CONDITION_OCCURRENCE.CONDITION_OCCURRENCE_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('condition_occurrence') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.CONDITION_OCCURRENCE_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.CONDITION_OCCURRENCE_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.CONDITION_OCCURRENCE_ID) AS varchar),'.') != 0))
			AND cdmTable.CONDITION_OCCURRENCE_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('condition_occurrence') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the CONDITION_SOURCE_CONCEPT_ID in the CONDITION_OCCURRENCE is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'CONDITION_OCCURRENCE' as cdm_table_name
  ,'CONDITION_SOURCE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_condition_occurrence_condition_source_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = CONDITION_OCCURRENCE
cdmFieldName = CONDITION_SOURCE_CONCEPT_ID
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
			'CONDITION_OCCURRENCE.CONDITION_SOURCE_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('condition_occurrence') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.CONDITION_SOURCE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.CONDITION_SOURCE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.CONDITION_SOURCE_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.CONDITION_SOURCE_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('condition_occurrence') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the CONDITION_STATUS_CONCEPT_ID in the CONDITION_OCCURRENCE is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'CONDITION_OCCURRENCE' as cdm_table_name
  ,'CONDITION_STATUS_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_condition_occurrence_condition_status_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = CONDITION_OCCURRENCE
cdmFieldName = CONDITION_STATUS_CONCEPT_ID
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
			'CONDITION_OCCURRENCE.CONDITION_STATUS_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('condition_occurrence') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.CONDITION_STATUS_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.CONDITION_STATUS_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.CONDITION_STATUS_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.CONDITION_STATUS_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('condition_occurrence') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the CONDITION_TYPE_CONCEPT_ID in the CONDITION_OCCURRENCE is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'CONDITION_OCCURRENCE' as cdm_table_name
  ,'CONDITION_TYPE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_condition_occurrence_condition_type_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'CONDITION_OCCURRENCE.CONDITION_TYPE_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('condition_occurrence') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.CONDITION_TYPE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.CONDITION_TYPE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.CONDITION_TYPE_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.CONDITION_TYPE_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('condition_occurrence') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the PERSON_ID in the CONDITION_OCCURRENCE is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'CONDITION_OCCURRENCE' as cdm_table_name
  ,'PERSON_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_condition_occurrence_person_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'CONDITION_OCCURRENCE.PERSON_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('condition_occurrence') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.PERSON_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.PERSON_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.PERSON_ID) AS varchar),'.') != 0))
			AND cdmTable.PERSON_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('condition_occurrence') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the PROVIDER_ID in the CONDITION_OCCURRENCE is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'CONDITION_OCCURRENCE' as cdm_table_name
  ,'PROVIDER_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_condition_occurrence_provider_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = CONDITION_OCCURRENCE
cdmFieldName = PROVIDER_ID
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
			'CONDITION_OCCURRENCE.PROVIDER_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('condition_occurrence') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.PROVIDER_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.PROVIDER_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.PROVIDER_ID) AS varchar),'.') != 0))
			AND cdmTable.PROVIDER_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('condition_occurrence') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the VISIT_DETAIL_ID in the CONDITION_OCCURRENCE is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'CONDITION_OCCURRENCE' as cdm_table_name
  ,'VISIT_DETAIL_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_condition_occurrence_visit_detail_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = CONDITION_OCCURRENCE
cdmFieldName = VISIT_DETAIL_ID
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
			'CONDITION_OCCURRENCE.VISIT_DETAIL_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('condition_occurrence') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.VISIT_DETAIL_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.VISIT_DETAIL_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.VISIT_DETAIL_ID) AS varchar),'.') != 0))
			AND cdmTable.VISIT_DETAIL_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('condition_occurrence') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the VISIT_OCCURRENCE_ID in the CONDITION_OCCURRENCE is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'CONDITION_OCCURRENCE' as cdm_table_name
  ,'VISIT_OCCURRENCE_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_condition_occurrence_visit_occurrence_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = CONDITION_OCCURRENCE
cdmFieldName = VISIT_OCCURRENCE_ID
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
			'CONDITION_OCCURRENCE.VISIT_OCCURRENCE_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('condition_occurrence') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.VISIT_OCCURRENCE_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.VISIT_OCCURRENCE_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.VISIT_OCCURRENCE_ID) AS varchar),'.') != 0))
			AND cdmTable.VISIT_OCCURRENCE_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('condition_occurrence') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the COST_EVENT_ID in the COST is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'COST' as cdm_table_name
  ,'COST_EVENT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_cost_cost_event_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'COST.COST_EVENT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('cost') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.COST_EVENT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.COST_EVENT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.COST_EVENT_ID) AS varchar),'.') != 0))
			AND cdmTable.COST_EVENT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('cost') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the COST_ID in the COST is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'COST' as cdm_table_name
  ,'COST_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_cost_cost_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'COST.COST_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('cost') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.COST_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.COST_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.COST_ID) AS varchar),'.') != 0))
			AND cdmTable.COST_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('cost') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the COST_TYPE_CONCEPT_ID in the COST is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'COST' as cdm_table_name
  ,'COST_TYPE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_cost_cost_type_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'COST.COST_TYPE_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('cost') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.COST_TYPE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.COST_TYPE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.COST_TYPE_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.COST_TYPE_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('cost') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the CURRENCY_CONCEPT_ID in the COST is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'COST' as cdm_table_name
  ,'CURRENCY_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_cost_currency_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = COST
cdmFieldName = CURRENCY_CONCEPT_ID
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
			'COST.CURRENCY_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('cost') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.CURRENCY_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.CURRENCY_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.CURRENCY_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.CURRENCY_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('cost') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the DRG_CONCEPT_ID in the COST is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'COST' as cdm_table_name
  ,'DRG_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_cost_drg_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = COST
cdmFieldName = DRG_CONCEPT_ID
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
			'COST.DRG_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('cost') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.DRG_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.DRG_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.DRG_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.DRG_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('cost') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the PAYER_PLAN_PERIOD_ID in the COST is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'COST' as cdm_table_name
  ,'PAYER_PLAN_PERIOD_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_cost_payer_plan_period_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = COST
cdmFieldName = PAYER_PLAN_PERIOD_ID
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
			'COST.PAYER_PLAN_PERIOD_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('cost') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.PAYER_PLAN_PERIOD_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.PAYER_PLAN_PERIOD_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.PAYER_PLAN_PERIOD_ID) AS varchar),'.') != 0))
			AND cdmTable.PAYER_PLAN_PERIOD_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('cost') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the REVENUE_CODE_CONCEPT_ID in the COST is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'COST' as cdm_table_name
  ,'REVENUE_CODE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_cost_revenue_code_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = COST
cdmFieldName = REVENUE_CODE_CONCEPT_ID
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
			'COST.REVENUE_CODE_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('cost') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.REVENUE_CODE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.REVENUE_CODE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.REVENUE_CODE_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.REVENUE_CODE_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('cost') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the CAUSE_CONCEPT_ID in the DEATH is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'DEATH' as cdm_table_name
  ,'CAUSE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_death_cause_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = DEATH
cdmFieldName = CAUSE_CONCEPT_ID
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
			'DEATH.CAUSE_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('death') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.CAUSE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.CAUSE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.CAUSE_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.CAUSE_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('death') }}
) denominator
) cte

UNION ALL
SELECT cte.num_violated_rows
  ,cte.pct_violated_rows
  ,cte.num_denominator_rows
  , CAST('' as TEXT) as execution_time
  ,'' as query_text
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the CAUSE_SOURCE_CONCEPT_ID in the DEATH is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'DEATH' as cdm_table_name
  ,'CAUSE_SOURCE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_death_cause_source_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = DEATH
cdmFieldName = CAUSE_SOURCE_CONCEPT_ID
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
			'DEATH.CAUSE_SOURCE_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('death') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.CAUSE_SOURCE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.CAUSE_SOURCE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.CAUSE_SOURCE_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.CAUSE_SOURCE_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('death') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the DEATH_TYPE_CONCEPT_ID in the DEATH is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'DEATH' as cdm_table_name
  ,'DEATH_TYPE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_death_death_type_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = DEATH
cdmFieldName = DEATH_TYPE_CONCEPT_ID
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
			'DEATH.DEATH_TYPE_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('death') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.DEATH_TYPE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.DEATH_TYPE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.DEATH_TYPE_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.DEATH_TYPE_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('death') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the PERSON_ID in the DEATH is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'DEATH' as cdm_table_name
  ,'PERSON_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_death_person_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'DEATH.PERSON_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('death') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.PERSON_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.PERSON_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.PERSON_ID) AS varchar),'.') != 0))
			AND cdmTable.PERSON_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('death') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the DEVICE_CONCEPT_ID in the DEVICE_EXPOSURE is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'DEVICE_EXPOSURE' as cdm_table_name
  ,'DEVICE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_device_exposure_device_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'DEVICE_EXPOSURE.DEVICE_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('device_exposure') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.DEVICE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.DEVICE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.DEVICE_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.DEVICE_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('device_exposure') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the DEVICE_EXPOSURE_ID in the DEVICE_EXPOSURE is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'DEVICE_EXPOSURE' as cdm_table_name
  ,'DEVICE_EXPOSURE_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_device_exposure_device_exposure_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'DEVICE_EXPOSURE.DEVICE_EXPOSURE_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('device_exposure') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.DEVICE_EXPOSURE_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.DEVICE_EXPOSURE_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.DEVICE_EXPOSURE_ID) AS varchar),'.') != 0))
			AND cdmTable.DEVICE_EXPOSURE_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('device_exposure') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the DEVICE_SOURCE_CONCEPT_ID in the DEVICE_EXPOSURE is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'DEVICE_EXPOSURE' as cdm_table_name
  ,'DEVICE_SOURCE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_device_exposure_device_source_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = DEVICE_EXPOSURE
cdmFieldName = DEVICE_SOURCE_CONCEPT_ID
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
			'DEVICE_EXPOSURE.DEVICE_SOURCE_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('device_exposure') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.DEVICE_SOURCE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.DEVICE_SOURCE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.DEVICE_SOURCE_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.DEVICE_SOURCE_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('device_exposure') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the DEVICE_TYPE_CONCEPT_ID in the DEVICE_EXPOSURE is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'DEVICE_EXPOSURE' as cdm_table_name
  ,'DEVICE_TYPE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_device_exposure_device_type_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'DEVICE_EXPOSURE.DEVICE_TYPE_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('device_exposure') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.DEVICE_TYPE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.DEVICE_TYPE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.DEVICE_TYPE_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.DEVICE_TYPE_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('device_exposure') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the PERSON_ID in the DEVICE_EXPOSURE is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'DEVICE_EXPOSURE' as cdm_table_name
  ,'PERSON_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_device_exposure_person_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'DEVICE_EXPOSURE.PERSON_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('device_exposure') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.PERSON_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.PERSON_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.PERSON_ID) AS varchar),'.') != 0))
			AND cdmTable.PERSON_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('device_exposure') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the PROVIDER_ID in the DEVICE_EXPOSURE is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'DEVICE_EXPOSURE' as cdm_table_name
  ,'PROVIDER_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_device_exposure_provider_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = DEVICE_EXPOSURE
cdmFieldName = PROVIDER_ID
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
			'DEVICE_EXPOSURE.PROVIDER_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('device_exposure') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.PROVIDER_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.PROVIDER_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.PROVIDER_ID) AS varchar),'.') != 0))
			AND cdmTable.PROVIDER_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('device_exposure') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the QUANTITY in the DEVICE_EXPOSURE is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'DEVICE_EXPOSURE' as cdm_table_name
  ,'QUANTITY' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_device_exposure_quantity' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = DEVICE_EXPOSURE
cdmFieldName = QUANTITY
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
			'DEVICE_EXPOSURE.QUANTITY' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('device_exposure') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.QUANTITY AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.QUANTITY AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.QUANTITY) AS varchar),'.') != 0))
			AND cdmTable.QUANTITY IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('device_exposure') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the UNIT_CONCEPT_ID in the DEVICE_EXPOSURE is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'DEVICE_EXPOSURE' as cdm_table_name
  ,'UNIT_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_device_exposure_unit_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = DEVICE_EXPOSURE
cdmFieldName = UNIT_CONCEPT_ID
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
			'DEVICE_EXPOSURE.UNIT_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('device_exposure') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.UNIT_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.UNIT_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.UNIT_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.UNIT_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('device_exposure') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the UNIT_SOURCE_CONCEPT_ID in the DEVICE_EXPOSURE is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'DEVICE_EXPOSURE' as cdm_table_name
  ,'UNIT_SOURCE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_device_exposure_unit_source_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = DEVICE_EXPOSURE
cdmFieldName = UNIT_SOURCE_CONCEPT_ID
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
			'DEVICE_EXPOSURE.UNIT_SOURCE_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('device_exposure') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.UNIT_SOURCE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.UNIT_SOURCE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.UNIT_SOURCE_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.UNIT_SOURCE_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('device_exposure') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the VISIT_DETAIL_ID in the DEVICE_EXPOSURE is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'DEVICE_EXPOSURE' as cdm_table_name
  ,'VISIT_DETAIL_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_device_exposure_visit_detail_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = DEVICE_EXPOSURE
cdmFieldName = VISIT_DETAIL_ID
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
			'DEVICE_EXPOSURE.VISIT_DETAIL_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('device_exposure') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.VISIT_DETAIL_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.VISIT_DETAIL_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.VISIT_DETAIL_ID) AS varchar),'.') != 0))
			AND cdmTable.VISIT_DETAIL_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('device_exposure') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the VISIT_OCCURRENCE_ID in the DEVICE_EXPOSURE is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'DEVICE_EXPOSURE' as cdm_table_name
  ,'VISIT_OCCURRENCE_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_device_exposure_visit_occurrence_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = DEVICE_EXPOSURE
cdmFieldName = VISIT_OCCURRENCE_ID
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
			'DEVICE_EXPOSURE.VISIT_OCCURRENCE_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('device_exposure') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.VISIT_OCCURRENCE_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.VISIT_OCCURRENCE_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.VISIT_OCCURRENCE_ID) AS varchar),'.') != 0))
			AND cdmTable.VISIT_OCCURRENCE_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('device_exposure') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the DOSE_ERA_ID in the DOSE_ERA is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'DOSE_ERA' as cdm_table_name
  ,'DOSE_ERA_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_dose_era_dose_era_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'DOSE_ERA.DOSE_ERA_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('dose_era') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.DOSE_ERA_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.DOSE_ERA_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.DOSE_ERA_ID) AS varchar),'.') != 0))
			AND cdmTable.DOSE_ERA_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('dose_era') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the DRUG_CONCEPT_ID in the DOSE_ERA is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'DOSE_ERA' as cdm_table_name
  ,'DRUG_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_dose_era_drug_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'DOSE_ERA.DRUG_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('dose_era') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.DRUG_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.DRUG_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.DRUG_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.DRUG_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('dose_era') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the PERSON_ID in the DOSE_ERA is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'DOSE_ERA' as cdm_table_name
  ,'PERSON_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_dose_era_person_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'DOSE_ERA.PERSON_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('dose_era') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.PERSON_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.PERSON_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.PERSON_ID) AS varchar),'.') != 0))
			AND cdmTable.PERSON_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('dose_era') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the UNIT_CONCEPT_ID in the DOSE_ERA is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'DOSE_ERA' as cdm_table_name
  ,'UNIT_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_dose_era_unit_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'DOSE_ERA.UNIT_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('dose_era') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.UNIT_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.UNIT_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.UNIT_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.UNIT_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('dose_era') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the DRUG_CONCEPT_ID in the DRUG_ERA is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'DRUG_ERA' as cdm_table_name
  ,'DRUG_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_drug_era_drug_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'DRUG_ERA.DRUG_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('drug_era') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.DRUG_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.DRUG_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.DRUG_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.DRUG_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('drug_era') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the DRUG_ERA_ID in the DRUG_ERA is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'DRUG_ERA' as cdm_table_name
  ,'DRUG_ERA_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_drug_era_drug_era_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'DRUG_ERA.DRUG_ERA_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('drug_era') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.DRUG_ERA_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.DRUG_ERA_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.DRUG_ERA_ID) AS varchar),'.') != 0))
			AND cdmTable.DRUG_ERA_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('drug_era') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the DRUG_EXPOSURE_COUNT in the DRUG_ERA is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'DRUG_ERA' as cdm_table_name
  ,'DRUG_EXPOSURE_COUNT' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_drug_era_drug_exposure_count' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = DRUG_ERA
cdmFieldName = DRUG_EXPOSURE_COUNT
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
			'DRUG_ERA.DRUG_EXPOSURE_COUNT' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('drug_era') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.DRUG_EXPOSURE_COUNT AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.DRUG_EXPOSURE_COUNT AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.DRUG_EXPOSURE_COUNT) AS varchar),'.') != 0))
			AND cdmTable.DRUG_EXPOSURE_COUNT IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('drug_era') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the GAP_DAYS in the DRUG_ERA is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'DRUG_ERA' as cdm_table_name
  ,'GAP_DAYS' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_drug_era_gap_days' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = DRUG_ERA
cdmFieldName = GAP_DAYS
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
			'DRUG_ERA.GAP_DAYS' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('drug_era') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.GAP_DAYS AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.GAP_DAYS AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.GAP_DAYS) AS varchar),'.') != 0))
			AND cdmTable.GAP_DAYS IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('drug_era') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the PERSON_ID in the DRUG_ERA is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'DRUG_ERA' as cdm_table_name
  ,'PERSON_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_drug_era_person_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'DRUG_ERA.PERSON_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('drug_era') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.PERSON_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.PERSON_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.PERSON_ID) AS varchar),'.') != 0))
			AND cdmTable.PERSON_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('drug_era') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the DAYS_SUPPLY in the DRUG_EXPOSURE is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'DRUG_EXPOSURE' as cdm_table_name
  ,'DAYS_SUPPLY' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_drug_exposure_days_supply' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = DRUG_EXPOSURE
cdmFieldName = DAYS_SUPPLY
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
			'DRUG_EXPOSURE.DAYS_SUPPLY' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('drug_exposure') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.DAYS_SUPPLY AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.DAYS_SUPPLY AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.DAYS_SUPPLY) AS varchar),'.') != 0))
			AND cdmTable.DAYS_SUPPLY IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('drug_exposure') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the DRUG_CONCEPT_ID in the DRUG_EXPOSURE is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'DRUG_EXPOSURE' as cdm_table_name
  ,'DRUG_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_drug_exposure_drug_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'DRUG_EXPOSURE.DRUG_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('drug_exposure') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.DRUG_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.DRUG_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.DRUG_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.DRUG_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('drug_exposure') }}
) denominator
) cte

UNION ALL
SELECT cte.num_violated_rows
  ,cte.pct_violated_rows
  ,cte.num_denominator_rows
  , CAST('' as TEXT) as execution_time
  ,'' as query_text
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the DRUG_EXPOSURE_ID in the DRUG_EXPOSURE is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'DRUG_EXPOSURE' as cdm_table_name
  ,'DRUG_EXPOSURE_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_drug_exposure_drug_exposure_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'DRUG_EXPOSURE.DRUG_EXPOSURE_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('drug_exposure') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.DRUG_EXPOSURE_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.DRUG_EXPOSURE_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.DRUG_EXPOSURE_ID) AS varchar),'.') != 0))
			AND cdmTable.DRUG_EXPOSURE_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('drug_exposure') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the DRUG_SOURCE_CONCEPT_ID in the DRUG_EXPOSURE is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'DRUG_EXPOSURE' as cdm_table_name
  ,'DRUG_SOURCE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_drug_exposure_drug_source_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = DRUG_EXPOSURE
cdmFieldName = DRUG_SOURCE_CONCEPT_ID
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
			'DRUG_EXPOSURE.DRUG_SOURCE_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('drug_exposure') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.DRUG_SOURCE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.DRUG_SOURCE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.DRUG_SOURCE_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.DRUG_SOURCE_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('drug_exposure') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the DRUG_TYPE_CONCEPT_ID in the DRUG_EXPOSURE is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'DRUG_EXPOSURE' as cdm_table_name
  ,'DRUG_TYPE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_drug_exposure_drug_type_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'DRUG_EXPOSURE.DRUG_TYPE_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('drug_exposure') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.DRUG_TYPE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.DRUG_TYPE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.DRUG_TYPE_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.DRUG_TYPE_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('drug_exposure') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the PERSON_ID in the DRUG_EXPOSURE is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'DRUG_EXPOSURE' as cdm_table_name
  ,'PERSON_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_drug_exposure_person_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'DRUG_EXPOSURE.PERSON_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('drug_exposure') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.PERSON_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.PERSON_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.PERSON_ID) AS varchar),'.') != 0))
			AND cdmTable.PERSON_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('drug_exposure') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the PROVIDER_ID in the DRUG_EXPOSURE is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'DRUG_EXPOSURE' as cdm_table_name
  ,'PROVIDER_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_drug_exposure_provider_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = DRUG_EXPOSURE
cdmFieldName = PROVIDER_ID
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
			'DRUG_EXPOSURE.PROVIDER_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('drug_exposure') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.PROVIDER_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.PROVIDER_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.PROVIDER_ID) AS varchar),'.') != 0))
			AND cdmTable.PROVIDER_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('drug_exposure') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the REFILLS in the DRUG_EXPOSURE is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'DRUG_EXPOSURE' as cdm_table_name
  ,'REFILLS' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_drug_exposure_refills' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = DRUG_EXPOSURE
cdmFieldName = REFILLS
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
			'DRUG_EXPOSURE.REFILLS' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('drug_exposure') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.REFILLS AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.REFILLS AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.REFILLS) AS varchar),'.') != 0))
			AND cdmTable.REFILLS IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('drug_exposure') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the ROUTE_CONCEPT_ID in the DRUG_EXPOSURE is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'DRUG_EXPOSURE' as cdm_table_name
  ,'ROUTE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_drug_exposure_route_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = DRUG_EXPOSURE
cdmFieldName = ROUTE_CONCEPT_ID
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
			'DRUG_EXPOSURE.ROUTE_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('drug_exposure') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.ROUTE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.ROUTE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.ROUTE_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.ROUTE_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('drug_exposure') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the VISIT_DETAIL_ID in the DRUG_EXPOSURE is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'DRUG_EXPOSURE' as cdm_table_name
  ,'VISIT_DETAIL_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_drug_exposure_visit_detail_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = DRUG_EXPOSURE
cdmFieldName = VISIT_DETAIL_ID
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
			'DRUG_EXPOSURE.VISIT_DETAIL_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('drug_exposure') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.VISIT_DETAIL_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.VISIT_DETAIL_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.VISIT_DETAIL_ID) AS varchar),'.') != 0))
			AND cdmTable.VISIT_DETAIL_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('drug_exposure') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the VISIT_OCCURRENCE_ID in the DRUG_EXPOSURE is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'DRUG_EXPOSURE' as cdm_table_name
  ,'VISIT_OCCURRENCE_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_drug_exposure_visit_occurrence_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = DRUG_EXPOSURE
cdmFieldName = VISIT_OCCURRENCE_ID
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
			'DRUG_EXPOSURE.VISIT_OCCURRENCE_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('drug_exposure') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.VISIT_OCCURRENCE_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.VISIT_OCCURRENCE_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.VISIT_OCCURRENCE_ID) AS varchar),'.') != 0))
			AND cdmTable.VISIT_OCCURRENCE_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('drug_exposure') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the EPISODE_CONCEPT_ID in the EPISODE is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'EPISODE' as cdm_table_name
  ,'EPISODE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_episode_episode_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'EPISODE.EPISODE_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('episode') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.EPISODE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.EPISODE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.EPISODE_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.EPISODE_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('episode') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the EPISODE_NUMBER in the EPISODE is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'EPISODE' as cdm_table_name
  ,'EPISODE_NUMBER' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_episode_episode_number' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = EPISODE
cdmFieldName = EPISODE_NUMBER
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
			'EPISODE.EPISODE_NUMBER' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('episode') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.EPISODE_NUMBER AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.EPISODE_NUMBER AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.EPISODE_NUMBER) AS varchar),'.') != 0))
			AND cdmTable.EPISODE_NUMBER IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('episode') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the EPISODE_OBJECT_CONCEPT_ID in the EPISODE is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'EPISODE' as cdm_table_name
  ,'EPISODE_OBJECT_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_episode_episode_object_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'EPISODE.EPISODE_OBJECT_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('episode') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.EPISODE_OBJECT_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.EPISODE_OBJECT_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.EPISODE_OBJECT_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.EPISODE_OBJECT_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('episode') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the EPISODE_SOURCE_CONCEPT_ID in the EPISODE is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'EPISODE' as cdm_table_name
  ,'EPISODE_SOURCE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_episode_episode_source_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = EPISODE
cdmFieldName = EPISODE_SOURCE_CONCEPT_ID
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
			'EPISODE.EPISODE_SOURCE_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('episode') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.EPISODE_SOURCE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.EPISODE_SOURCE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.EPISODE_SOURCE_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.EPISODE_SOURCE_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('episode') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the EPISODE_TYPE_CONCEPT_ID in the EPISODE is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'EPISODE' as cdm_table_name
  ,'EPISODE_TYPE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_episode_episode_type_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'EPISODE.EPISODE_TYPE_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('episode') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.EPISODE_TYPE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.EPISODE_TYPE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.EPISODE_TYPE_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.EPISODE_TYPE_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('episode') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the EPISODE_EVENT_FIELD_CONCEPT_ID in the EPISODE_EVENT is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'EPISODE_EVENT' as cdm_table_name
  ,'EPISODE_EVENT_FIELD_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_episode_event_episode_event_field_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'EPISODE_EVENT.EPISODE_EVENT_FIELD_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('episode_event') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.EPISODE_EVENT_FIELD_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.EPISODE_EVENT_FIELD_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.EPISODE_EVENT_FIELD_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.EPISODE_EVENT_FIELD_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('episode_event') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the DOMAIN_CONCEPT_ID_1 in the FACT_RELATIONSHIP is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'FACT_RELATIONSHIP' as cdm_table_name
  ,'DOMAIN_CONCEPT_ID_1' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_fact_relationship_domain_concept_id_1' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'FACT_RELATIONSHIP.DOMAIN_CONCEPT_ID_1' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('fact_relationship') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.DOMAIN_CONCEPT_ID_1 AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.DOMAIN_CONCEPT_ID_1 AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.DOMAIN_CONCEPT_ID_1) AS varchar),'.') != 0))
			AND cdmTable.DOMAIN_CONCEPT_ID_1 IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('fact_relationship') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the DOMAIN_CONCEPT_ID_2 in the FACT_RELATIONSHIP is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'FACT_RELATIONSHIP' as cdm_table_name
  ,'DOMAIN_CONCEPT_ID_2' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_fact_relationship_domain_concept_id_2' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'FACT_RELATIONSHIP.DOMAIN_CONCEPT_ID_2' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('fact_relationship') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.DOMAIN_CONCEPT_ID_2 AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.DOMAIN_CONCEPT_ID_2 AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.DOMAIN_CONCEPT_ID_2) AS varchar),'.') != 0))
			AND cdmTable.DOMAIN_CONCEPT_ID_2 IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('fact_relationship') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the FACT_ID_1 in the FACT_RELATIONSHIP is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'FACT_RELATIONSHIP' as cdm_table_name
  ,'FACT_ID_1' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_fact_relationship_fact_id_1' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'FACT_RELATIONSHIP.FACT_ID_1' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('fact_relationship') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.FACT_ID_1 AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.FACT_ID_1 AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.FACT_ID_1) AS varchar),'.') != 0))
			AND cdmTable.FACT_ID_1 IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('fact_relationship') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the FACT_ID_2 in the FACT_RELATIONSHIP is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'FACT_RELATIONSHIP' as cdm_table_name
  ,'FACT_ID_2' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_fact_relationship_fact_id_2' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'FACT_RELATIONSHIP.FACT_ID_2' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('fact_relationship') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.FACT_ID_2 AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.FACT_ID_2 AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.FACT_ID_2) AS varchar),'.') != 0))
			AND cdmTable.FACT_ID_2 IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('fact_relationship') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the RELATIONSHIP_CONCEPT_ID in the FACT_RELATIONSHIP is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'FACT_RELATIONSHIP' as cdm_table_name
  ,'RELATIONSHIP_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_fact_relationship_relationship_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'FACT_RELATIONSHIP.RELATIONSHIP_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('fact_relationship') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.RELATIONSHIP_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.RELATIONSHIP_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.RELATIONSHIP_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.RELATIONSHIP_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('fact_relationship') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the COUNTRY_CONCEPT_ID in the LOCATION is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'LOCATION' as cdm_table_name
  ,'COUNTRY_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_location_country_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = LOCATION
cdmFieldName = COUNTRY_CONCEPT_ID
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
			'LOCATION.COUNTRY_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('location') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.COUNTRY_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.COUNTRY_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.COUNTRY_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.COUNTRY_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('location') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the LOCATION_ID in the LOCATION is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'LOCATION' as cdm_table_name
  ,'LOCATION_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_location_location_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'LOCATION.LOCATION_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('location') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.LOCATION_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.LOCATION_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.LOCATION_ID) AS varchar),'.') != 0))
			AND cdmTable.LOCATION_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('location') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the MEAS_EVENT_FIELD_CONCEPT_ID in the MEASUREMENT is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'MEASUREMENT' as cdm_table_name
  ,'MEAS_EVENT_FIELD_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_measurement_meas_event_field_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = MEASUREMENT
cdmFieldName = MEAS_EVENT_FIELD_CONCEPT_ID
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
			'MEASUREMENT.MEAS_EVENT_FIELD_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('measurement') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.MEAS_EVENT_FIELD_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.MEAS_EVENT_FIELD_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.MEAS_EVENT_FIELD_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.MEAS_EVENT_FIELD_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('measurement') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the MEASUREMENT_CONCEPT_ID in the MEASUREMENT is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'MEASUREMENT' as cdm_table_name
  ,'MEASUREMENT_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_measurement_measurement_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'MEASUREMENT.MEASUREMENT_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('measurement') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.MEASUREMENT_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.MEASUREMENT_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.MEASUREMENT_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.MEASUREMENT_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('measurement') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the MEASUREMENT_ID in the MEASUREMENT is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'MEASUREMENT' as cdm_table_name
  ,'MEASUREMENT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_measurement_measurement_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'MEASUREMENT.MEASUREMENT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('measurement') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.MEASUREMENT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.MEASUREMENT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.MEASUREMENT_ID) AS varchar),'.') != 0))
			AND cdmTable.MEASUREMENT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('measurement') }}
) denominator
) cte

UNION ALL
SELECT cte.num_violated_rows
  ,cte.pct_violated_rows
  ,cte.num_denominator_rows
  , CAST('' as TEXT) as execution_time
  ,'' as query_text
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the MEASUREMENT_SOURCE_CONCEPT_ID in the MEASUREMENT is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'MEASUREMENT' as cdm_table_name
  ,'MEASUREMENT_SOURCE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_measurement_measurement_source_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = MEASUREMENT
cdmFieldName = MEASUREMENT_SOURCE_CONCEPT_ID
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
			'MEASUREMENT.MEASUREMENT_SOURCE_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('measurement') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.MEASUREMENT_SOURCE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.MEASUREMENT_SOURCE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.MEASUREMENT_SOURCE_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.MEASUREMENT_SOURCE_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('measurement') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the MEASUREMENT_TYPE_CONCEPT_ID in the MEASUREMENT is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'MEASUREMENT' as cdm_table_name
  ,'MEASUREMENT_TYPE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_measurement_measurement_type_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'MEASUREMENT.MEASUREMENT_TYPE_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('measurement') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.MEASUREMENT_TYPE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.MEASUREMENT_TYPE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.MEASUREMENT_TYPE_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.MEASUREMENT_TYPE_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('measurement') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the OPERATOR_CONCEPT_ID in the MEASUREMENT is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'MEASUREMENT' as cdm_table_name
  ,'OPERATOR_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_measurement_operator_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = MEASUREMENT
cdmFieldName = OPERATOR_CONCEPT_ID
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
			'MEASUREMENT.OPERATOR_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('measurement') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.OPERATOR_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.OPERATOR_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.OPERATOR_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.OPERATOR_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('measurement') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the PERSON_ID in the MEASUREMENT is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'MEASUREMENT' as cdm_table_name
  ,'PERSON_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_measurement_person_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'MEASUREMENT.PERSON_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('measurement') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.PERSON_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.PERSON_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.PERSON_ID) AS varchar),'.') != 0))
			AND cdmTable.PERSON_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('measurement') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the PROVIDER_ID in the MEASUREMENT is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'MEASUREMENT' as cdm_table_name
  ,'PROVIDER_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_measurement_provider_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = MEASUREMENT
cdmFieldName = PROVIDER_ID
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
			'MEASUREMENT.PROVIDER_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('measurement') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.PROVIDER_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.PROVIDER_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.PROVIDER_ID) AS varchar),'.') != 0))
			AND cdmTable.PROVIDER_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('measurement') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the UNIT_CONCEPT_ID in the MEASUREMENT is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'MEASUREMENT' as cdm_table_name
  ,'UNIT_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_measurement_unit_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = MEASUREMENT
cdmFieldName = UNIT_CONCEPT_ID
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
			'MEASUREMENT.UNIT_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('measurement') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.UNIT_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.UNIT_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.UNIT_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.UNIT_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('measurement') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the UNIT_SOURCE_CONCEPT_ID in the MEASUREMENT is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'MEASUREMENT' as cdm_table_name
  ,'UNIT_SOURCE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_measurement_unit_source_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = MEASUREMENT
cdmFieldName = UNIT_SOURCE_CONCEPT_ID
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
			'MEASUREMENT.UNIT_SOURCE_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('measurement') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.UNIT_SOURCE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.UNIT_SOURCE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.UNIT_SOURCE_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.UNIT_SOURCE_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('measurement') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the VALUE_AS_CONCEPT_ID in the MEASUREMENT is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'MEASUREMENT' as cdm_table_name
  ,'VALUE_AS_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_measurement_value_as_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = MEASUREMENT
cdmFieldName = VALUE_AS_CONCEPT_ID
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
			'MEASUREMENT.VALUE_AS_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('measurement') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.VALUE_AS_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.VALUE_AS_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.VALUE_AS_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.VALUE_AS_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('measurement') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the VISIT_DETAIL_ID in the MEASUREMENT is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'MEASUREMENT' as cdm_table_name
  ,'VISIT_DETAIL_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_measurement_visit_detail_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = MEASUREMENT
cdmFieldName = VISIT_DETAIL_ID
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
			'MEASUREMENT.VISIT_DETAIL_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('measurement') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.VISIT_DETAIL_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.VISIT_DETAIL_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.VISIT_DETAIL_ID) AS varchar),'.') != 0))
			AND cdmTable.VISIT_DETAIL_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('measurement') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the VISIT_OCCURRENCE_ID in the MEASUREMENT is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'MEASUREMENT' as cdm_table_name
  ,'VISIT_OCCURRENCE_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_measurement_visit_occurrence_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = MEASUREMENT
cdmFieldName = VISIT_OCCURRENCE_ID
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
			'MEASUREMENT.VISIT_OCCURRENCE_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('measurement') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.VISIT_OCCURRENCE_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.VISIT_OCCURRENCE_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.VISIT_OCCURRENCE_ID) AS varchar),'.') != 0))
			AND cdmTable.VISIT_OCCURRENCE_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('measurement') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the METADATA_CONCEPT_ID in the METADATA is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'METADATA' as cdm_table_name
  ,'METADATA_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_metadata_metadata_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'METADATA.METADATA_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('metadata') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.METADATA_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.METADATA_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.METADATA_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.METADATA_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('metadata') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the METADATA_ID in the METADATA is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'METADATA' as cdm_table_name
  ,'METADATA_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_metadata_metadata_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'METADATA.METADATA_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('metadata') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.METADATA_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.METADATA_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.METADATA_ID) AS varchar),'.') != 0))
			AND cdmTable.METADATA_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('metadata') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the METADATA_TYPE_CONCEPT_ID in the METADATA is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'METADATA' as cdm_table_name
  ,'METADATA_TYPE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_metadata_metadata_type_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'METADATA.METADATA_TYPE_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('metadata') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.METADATA_TYPE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.METADATA_TYPE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.METADATA_TYPE_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.METADATA_TYPE_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('metadata') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the VALUE_AS_CONCEPT_ID in the METADATA is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'METADATA' as cdm_table_name
  ,'VALUE_AS_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_metadata_value_as_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = METADATA
cdmFieldName = VALUE_AS_CONCEPT_ID
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
			'METADATA.VALUE_AS_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('metadata') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.VALUE_AS_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.VALUE_AS_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.VALUE_AS_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.VALUE_AS_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('metadata') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the ENCODING_CONCEPT_ID in the NOTE is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'NOTE' as cdm_table_name
  ,'ENCODING_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_note_encoding_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'NOTE.ENCODING_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('note') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.ENCODING_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.ENCODING_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.ENCODING_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.ENCODING_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('note') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the LANGUAGE_CONCEPT_ID in the NOTE is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'NOTE' as cdm_table_name
  ,'LANGUAGE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_note_language_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'NOTE.LANGUAGE_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('note') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.LANGUAGE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.LANGUAGE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.LANGUAGE_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.LANGUAGE_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('note') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the NOTE_CLASS_CONCEPT_ID in the NOTE is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'NOTE' as cdm_table_name
  ,'NOTE_CLASS_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_note_note_class_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'NOTE.NOTE_CLASS_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('note') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.NOTE_CLASS_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.NOTE_CLASS_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.NOTE_CLASS_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.NOTE_CLASS_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('note') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the NOTE_EVENT_FIELD_CONCEPT_ID in the NOTE is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'NOTE' as cdm_table_name
  ,'NOTE_EVENT_FIELD_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_note_note_event_field_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = NOTE
cdmFieldName = NOTE_EVENT_FIELD_CONCEPT_ID
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
			'NOTE.NOTE_EVENT_FIELD_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('note') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.NOTE_EVENT_FIELD_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.NOTE_EVENT_FIELD_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.NOTE_EVENT_FIELD_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.NOTE_EVENT_FIELD_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('note') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the NOTE_ID in the NOTE is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'NOTE' as cdm_table_name
  ,'NOTE_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_note_note_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'NOTE.NOTE_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('note') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.NOTE_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.NOTE_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.NOTE_ID) AS varchar),'.') != 0))
			AND cdmTable.NOTE_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('note') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the NOTE_TYPE_CONCEPT_ID in the NOTE is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'NOTE' as cdm_table_name
  ,'NOTE_TYPE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_note_note_type_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'NOTE.NOTE_TYPE_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('note') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.NOTE_TYPE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.NOTE_TYPE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.NOTE_TYPE_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.NOTE_TYPE_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('note') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the PERSON_ID in the NOTE is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'NOTE' as cdm_table_name
  ,'PERSON_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_note_person_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'NOTE.PERSON_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('note') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.PERSON_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.PERSON_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.PERSON_ID) AS varchar),'.') != 0))
			AND cdmTable.PERSON_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('note') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the PROVIDER_ID in the NOTE is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'NOTE' as cdm_table_name
  ,'PROVIDER_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_note_provider_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = NOTE
cdmFieldName = PROVIDER_ID
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
			'NOTE.PROVIDER_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('note') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.PROVIDER_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.PROVIDER_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.PROVIDER_ID) AS varchar),'.') != 0))
			AND cdmTable.PROVIDER_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('note') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the VISIT_DETAIL_ID in the NOTE is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'NOTE' as cdm_table_name
  ,'VISIT_DETAIL_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_note_visit_detail_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = NOTE
cdmFieldName = VISIT_DETAIL_ID
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
			'NOTE.VISIT_DETAIL_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('note') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.VISIT_DETAIL_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.VISIT_DETAIL_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.VISIT_DETAIL_ID) AS varchar),'.') != 0))
			AND cdmTable.VISIT_DETAIL_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('note') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the VISIT_OCCURRENCE_ID in the NOTE is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'NOTE' as cdm_table_name
  ,'VISIT_OCCURRENCE_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_note_visit_occurrence_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = NOTE
cdmFieldName = VISIT_OCCURRENCE_ID
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
			'NOTE.VISIT_OCCURRENCE_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('note') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.VISIT_OCCURRENCE_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.VISIT_OCCURRENCE_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.VISIT_OCCURRENCE_ID) AS varchar),'.') != 0))
			AND cdmTable.VISIT_OCCURRENCE_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('note') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the NOTE_ID in the NOTE_NLP is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'NOTE_NLP' as cdm_table_name
  ,'NOTE_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_note_nlp_note_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'NOTE_NLP.NOTE_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('note_nlp') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.NOTE_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.NOTE_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.NOTE_ID) AS varchar),'.') != 0))
			AND cdmTable.NOTE_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('note_nlp') }}
) denominator
) cte

UNION ALL
SELECT cte.num_violated_rows
  ,cte.pct_violated_rows
  ,cte.num_denominator_rows
  , CAST('' as TEXT) as execution_time
  ,'' as query_text
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the NOTE_NLP_CONCEPT_ID in the NOTE_NLP is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'NOTE_NLP' as cdm_table_name
  ,'NOTE_NLP_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_note_nlp_note_nlp_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = NOTE_NLP
cdmFieldName = NOTE_NLP_CONCEPT_ID
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
			'NOTE_NLP.NOTE_NLP_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('note_nlp') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.NOTE_NLP_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.NOTE_NLP_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.NOTE_NLP_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.NOTE_NLP_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('note_nlp') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the NOTE_NLP_ID in the NOTE_NLP is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'NOTE_NLP' as cdm_table_name
  ,'NOTE_NLP_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_note_nlp_note_nlp_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'NOTE_NLP.NOTE_NLP_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('note_nlp') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.NOTE_NLP_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.NOTE_NLP_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.NOTE_NLP_ID) AS varchar),'.') != 0))
			AND cdmTable.NOTE_NLP_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('note_nlp') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the NOTE_NLP_SOURCE_CONCEPT_ID in the NOTE_NLP is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'NOTE_NLP' as cdm_table_name
  ,'NOTE_NLP_SOURCE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_note_nlp_note_nlp_source_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = NOTE_NLP
cdmFieldName = NOTE_NLP_SOURCE_CONCEPT_ID
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
			'NOTE_NLP.NOTE_NLP_SOURCE_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('note_nlp') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.NOTE_NLP_SOURCE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.NOTE_NLP_SOURCE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.NOTE_NLP_SOURCE_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.NOTE_NLP_SOURCE_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('note_nlp') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the SECTION_CONCEPT_ID in the NOTE_NLP is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'NOTE_NLP' as cdm_table_name
  ,'SECTION_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_note_nlp_section_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = NOTE_NLP
cdmFieldName = SECTION_CONCEPT_ID
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
			'NOTE_NLP.SECTION_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('note_nlp') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.SECTION_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.SECTION_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.SECTION_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.SECTION_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('note_nlp') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the OBS_EVENT_FIELD_CONCEPT_ID in the OBSERVATION is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'OBSERVATION' as cdm_table_name
  ,'OBS_EVENT_FIELD_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_observation_obs_event_field_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = OBSERVATION
cdmFieldName = OBS_EVENT_FIELD_CONCEPT_ID
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
			'OBSERVATION.OBS_EVENT_FIELD_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('observation') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.OBS_EVENT_FIELD_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.OBS_EVENT_FIELD_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.OBS_EVENT_FIELD_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.OBS_EVENT_FIELD_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('observation') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the OBSERVATION_CONCEPT_ID in the OBSERVATION is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'OBSERVATION' as cdm_table_name
  ,'OBSERVATION_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_observation_observation_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'OBSERVATION.OBSERVATION_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('observation') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.OBSERVATION_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.OBSERVATION_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.OBSERVATION_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.OBSERVATION_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('observation') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the OBSERVATION_ID in the OBSERVATION is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'OBSERVATION' as cdm_table_name
  ,'OBSERVATION_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_observation_observation_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'OBSERVATION.OBSERVATION_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('observation') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.OBSERVATION_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.OBSERVATION_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.OBSERVATION_ID) AS varchar),'.') != 0))
			AND cdmTable.OBSERVATION_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('observation') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the OBSERVATION_SOURCE_CONCEPT_ID in the OBSERVATION is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'OBSERVATION' as cdm_table_name
  ,'OBSERVATION_SOURCE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_observation_observation_source_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = OBSERVATION
cdmFieldName = OBSERVATION_SOURCE_CONCEPT_ID
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
			'OBSERVATION.OBSERVATION_SOURCE_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('observation') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.OBSERVATION_SOURCE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.OBSERVATION_SOURCE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.OBSERVATION_SOURCE_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.OBSERVATION_SOURCE_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('observation') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the OBSERVATION_TYPE_CONCEPT_ID in the OBSERVATION is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'OBSERVATION' as cdm_table_name
  ,'OBSERVATION_TYPE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_observation_observation_type_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'OBSERVATION.OBSERVATION_TYPE_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('observation') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.OBSERVATION_TYPE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.OBSERVATION_TYPE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.OBSERVATION_TYPE_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.OBSERVATION_TYPE_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('observation') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the PERSON_ID in the OBSERVATION is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'OBSERVATION' as cdm_table_name
  ,'PERSON_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_observation_person_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'OBSERVATION.PERSON_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('observation') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.PERSON_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.PERSON_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.PERSON_ID) AS varchar),'.') != 0))
			AND cdmTable.PERSON_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('observation') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the PROVIDER_ID in the OBSERVATION is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'OBSERVATION' as cdm_table_name
  ,'PROVIDER_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_observation_provider_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = OBSERVATION
cdmFieldName = PROVIDER_ID
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
			'OBSERVATION.PROVIDER_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('observation') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.PROVIDER_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.PROVIDER_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.PROVIDER_ID) AS varchar),'.') != 0))
			AND cdmTable.PROVIDER_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('observation') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the QUALIFIER_CONCEPT_ID in the OBSERVATION is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'OBSERVATION' as cdm_table_name
  ,'QUALIFIER_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_observation_qualifier_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = OBSERVATION
cdmFieldName = QUALIFIER_CONCEPT_ID
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
			'OBSERVATION.QUALIFIER_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('observation') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.QUALIFIER_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.QUALIFIER_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.QUALIFIER_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.QUALIFIER_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('observation') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the UNIT_CONCEPT_ID in the OBSERVATION is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'OBSERVATION' as cdm_table_name
  ,'UNIT_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_observation_unit_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = OBSERVATION
cdmFieldName = UNIT_CONCEPT_ID
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
			'OBSERVATION.UNIT_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('observation') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.UNIT_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.UNIT_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.UNIT_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.UNIT_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('observation') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the VISIT_DETAIL_ID in the OBSERVATION is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'OBSERVATION' as cdm_table_name
  ,'VISIT_DETAIL_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_observation_visit_detail_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = OBSERVATION
cdmFieldName = VISIT_DETAIL_ID
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
			'OBSERVATION.VISIT_DETAIL_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('observation') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.VISIT_DETAIL_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.VISIT_DETAIL_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.VISIT_DETAIL_ID) AS varchar),'.') != 0))
			AND cdmTable.VISIT_DETAIL_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('observation') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the VISIT_OCCURRENCE_ID in the OBSERVATION is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'OBSERVATION' as cdm_table_name
  ,'VISIT_OCCURRENCE_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_observation_visit_occurrence_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = OBSERVATION
cdmFieldName = VISIT_OCCURRENCE_ID
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
			'OBSERVATION.VISIT_OCCURRENCE_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('observation') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.VISIT_OCCURRENCE_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.VISIT_OCCURRENCE_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.VISIT_OCCURRENCE_ID) AS varchar),'.') != 0))
			AND cdmTable.VISIT_OCCURRENCE_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('observation') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the OBSERVATION_PERIOD_ID in the OBSERVATION_PERIOD is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'OBSERVATION_PERIOD' as cdm_table_name
  ,'OBSERVATION_PERIOD_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_observation_period_observation_period_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'OBSERVATION_PERIOD.OBSERVATION_PERIOD_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('observation_period') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.OBSERVATION_PERIOD_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.OBSERVATION_PERIOD_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.OBSERVATION_PERIOD_ID) AS varchar),'.') != 0))
			AND cdmTable.OBSERVATION_PERIOD_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('observation_period') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the PERIOD_TYPE_CONCEPT_ID in the OBSERVATION_PERIOD is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'OBSERVATION_PERIOD' as cdm_table_name
  ,'PERIOD_TYPE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_observation_period_period_type_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'OBSERVATION_PERIOD.PERIOD_TYPE_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('observation_period') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.PERIOD_TYPE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.PERIOD_TYPE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.PERIOD_TYPE_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.PERIOD_TYPE_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('observation_period') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the PERSON_ID in the OBSERVATION_PERIOD is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'OBSERVATION_PERIOD' as cdm_table_name
  ,'PERSON_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_observation_period_person_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'OBSERVATION_PERIOD.PERSON_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('observation_period') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.PERSON_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.PERSON_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.PERSON_ID) AS varchar),'.') != 0))
			AND cdmTable.PERSON_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('observation_period') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the PAYER_CONCEPT_ID in the PAYER_PLAN_PERIOD is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'PAYER_PLAN_PERIOD' as cdm_table_name
  ,'PAYER_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_payer_plan_period_payer_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = PAYER_PLAN_PERIOD
cdmFieldName = PAYER_CONCEPT_ID
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
			'PAYER_PLAN_PERIOD.PAYER_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('payer_plan_period') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.PAYER_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.PAYER_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.PAYER_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.PAYER_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('payer_plan_period') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the PAYER_PLAN_PERIOD_ID in the PAYER_PLAN_PERIOD is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'PAYER_PLAN_PERIOD' as cdm_table_name
  ,'PAYER_PLAN_PERIOD_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_payer_plan_period_payer_plan_period_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'PAYER_PLAN_PERIOD.PAYER_PLAN_PERIOD_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('payer_plan_period') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.PAYER_PLAN_PERIOD_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.PAYER_PLAN_PERIOD_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.PAYER_PLAN_PERIOD_ID) AS varchar),'.') != 0))
			AND cdmTable.PAYER_PLAN_PERIOD_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('payer_plan_period') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the PAYER_SOURCE_CONCEPT_ID in the PAYER_PLAN_PERIOD is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'PAYER_PLAN_PERIOD' as cdm_table_name
  ,'PAYER_SOURCE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_payer_plan_period_payer_source_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = PAYER_PLAN_PERIOD
cdmFieldName = PAYER_SOURCE_CONCEPT_ID
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
			'PAYER_PLAN_PERIOD.PAYER_SOURCE_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('payer_plan_period') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.PAYER_SOURCE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.PAYER_SOURCE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.PAYER_SOURCE_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.PAYER_SOURCE_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('payer_plan_period') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the PERSON_ID in the PAYER_PLAN_PERIOD is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'PAYER_PLAN_PERIOD' as cdm_table_name
  ,'PERSON_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_payer_plan_period_person_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'PAYER_PLAN_PERIOD.PERSON_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('payer_plan_period') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.PERSON_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.PERSON_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.PERSON_ID) AS varchar),'.') != 0))
			AND cdmTable.PERSON_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('payer_plan_period') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the PLAN_CONCEPT_ID in the PAYER_PLAN_PERIOD is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'PAYER_PLAN_PERIOD' as cdm_table_name
  ,'PLAN_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_payer_plan_period_plan_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = PAYER_PLAN_PERIOD
cdmFieldName = PLAN_CONCEPT_ID
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
			'PAYER_PLAN_PERIOD.PLAN_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('payer_plan_period') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.PLAN_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.PLAN_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.PLAN_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.PLAN_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('payer_plan_period') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the PLAN_SOURCE_CONCEPT_ID in the PAYER_PLAN_PERIOD is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'PAYER_PLAN_PERIOD' as cdm_table_name
  ,'PLAN_SOURCE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_payer_plan_period_plan_source_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = PAYER_PLAN_PERIOD
cdmFieldName = PLAN_SOURCE_CONCEPT_ID
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
			'PAYER_PLAN_PERIOD.PLAN_SOURCE_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('payer_plan_period') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.PLAN_SOURCE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.PLAN_SOURCE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.PLAN_SOURCE_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.PLAN_SOURCE_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('payer_plan_period') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the SPONSOR_CONCEPT_ID in the PAYER_PLAN_PERIOD is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'PAYER_PLAN_PERIOD' as cdm_table_name
  ,'SPONSOR_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_payer_plan_period_sponsor_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = PAYER_PLAN_PERIOD
cdmFieldName = SPONSOR_CONCEPT_ID
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
			'PAYER_PLAN_PERIOD.SPONSOR_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('payer_plan_period') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.SPONSOR_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.SPONSOR_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.SPONSOR_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.SPONSOR_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('payer_plan_period') }}
) denominator
) cte

UNION ALL
SELECT cte.num_violated_rows
  ,cte.pct_violated_rows
  ,cte.num_denominator_rows
  , CAST('' as TEXT) as execution_time
  ,'' as query_text
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the SPONSOR_SOURCE_CONCEPT_ID in the PAYER_PLAN_PERIOD is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'PAYER_PLAN_PERIOD' as cdm_table_name
  ,'SPONSOR_SOURCE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_payer_plan_period_sponsor_source_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = PAYER_PLAN_PERIOD
cdmFieldName = SPONSOR_SOURCE_CONCEPT_ID
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
			'PAYER_PLAN_PERIOD.SPONSOR_SOURCE_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('payer_plan_period') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.SPONSOR_SOURCE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.SPONSOR_SOURCE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.SPONSOR_SOURCE_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.SPONSOR_SOURCE_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('payer_plan_period') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the STOP_REASON_CONCEPT_ID in the PAYER_PLAN_PERIOD is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'PAYER_PLAN_PERIOD' as cdm_table_name
  ,'STOP_REASON_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_payer_plan_period_stop_reason_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = PAYER_PLAN_PERIOD
cdmFieldName = STOP_REASON_CONCEPT_ID
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
			'PAYER_PLAN_PERIOD.STOP_REASON_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('payer_plan_period') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.STOP_REASON_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.STOP_REASON_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.STOP_REASON_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.STOP_REASON_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('payer_plan_period') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the STOP_REASON_SOURCE_CONCEPT_ID in the PAYER_PLAN_PERIOD is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'PAYER_PLAN_PERIOD' as cdm_table_name
  ,'STOP_REASON_SOURCE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_payer_plan_period_stop_reason_source_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = PAYER_PLAN_PERIOD
cdmFieldName = STOP_REASON_SOURCE_CONCEPT_ID
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
			'PAYER_PLAN_PERIOD.STOP_REASON_SOURCE_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('payer_plan_period') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.STOP_REASON_SOURCE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.STOP_REASON_SOURCE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.STOP_REASON_SOURCE_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.STOP_REASON_SOURCE_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('payer_plan_period') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the CARE_SITE_ID in the PERSON is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'PERSON' as cdm_table_name
  ,'CARE_SITE_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_person_care_site_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = PERSON
cdmFieldName = CARE_SITE_ID
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
			'PERSON.CARE_SITE_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('person') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.CARE_SITE_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.CARE_SITE_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.CARE_SITE_ID) AS varchar),'.') != 0))
			AND cdmTable.CARE_SITE_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('person') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the DAY_OF_BIRTH in the PERSON is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'PERSON' as cdm_table_name
  ,'DAY_OF_BIRTH' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_person_day_of_birth' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = PERSON
cdmFieldName = DAY_OF_BIRTH
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
			'PERSON.DAY_OF_BIRTH' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('person') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.DAY_OF_BIRTH AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.DAY_OF_BIRTH AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.DAY_OF_BIRTH) AS varchar),'.') != 0))
			AND cdmTable.DAY_OF_BIRTH IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('person') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the ETHNICITY_CONCEPT_ID in the PERSON is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'PERSON' as cdm_table_name
  ,'ETHNICITY_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_person_ethnicity_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'PERSON.ETHNICITY_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('person') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.ETHNICITY_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.ETHNICITY_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.ETHNICITY_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.ETHNICITY_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('person') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the ETHNICITY_SOURCE_CONCEPT_ID in the PERSON is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'PERSON' as cdm_table_name
  ,'ETHNICITY_SOURCE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_person_ethnicity_source_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = PERSON
cdmFieldName = ETHNICITY_SOURCE_CONCEPT_ID
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
			'PERSON.ETHNICITY_SOURCE_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('person') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.ETHNICITY_SOURCE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.ETHNICITY_SOURCE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.ETHNICITY_SOURCE_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.ETHNICITY_SOURCE_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('person') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the GENDER_CONCEPT_ID in the PERSON is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'PERSON' as cdm_table_name
  ,'GENDER_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_person_gender_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'PERSON.GENDER_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('person') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.GENDER_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.GENDER_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.GENDER_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.GENDER_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('person') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the GENDER_SOURCE_CONCEPT_ID in the PERSON is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'PERSON' as cdm_table_name
  ,'GENDER_SOURCE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_person_gender_source_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = PERSON
cdmFieldName = GENDER_SOURCE_CONCEPT_ID
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
			'PERSON.GENDER_SOURCE_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('person') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.GENDER_SOURCE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.GENDER_SOURCE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.GENDER_SOURCE_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.GENDER_SOURCE_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('person') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the LOCATION_ID in the PERSON is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'PERSON' as cdm_table_name
  ,'LOCATION_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_person_location_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = PERSON
cdmFieldName = LOCATION_ID
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
			'PERSON.LOCATION_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('person') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.LOCATION_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.LOCATION_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.LOCATION_ID) AS varchar),'.') != 0))
			AND cdmTable.LOCATION_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('person') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the MONTH_OF_BIRTH in the PERSON is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'PERSON' as cdm_table_name
  ,'MONTH_OF_BIRTH' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_person_month_of_birth' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = PERSON
cdmFieldName = MONTH_OF_BIRTH
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
			'PERSON.MONTH_OF_BIRTH' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('person') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.MONTH_OF_BIRTH AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.MONTH_OF_BIRTH AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.MONTH_OF_BIRTH) AS varchar),'.') != 0))
			AND cdmTable.MONTH_OF_BIRTH IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('person') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the PERSON_ID in the PERSON is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'PERSON' as cdm_table_name
  ,'PERSON_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_person_person_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'PERSON.PERSON_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('person') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.PERSON_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.PERSON_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.PERSON_ID) AS varchar),'.') != 0))
			AND cdmTable.PERSON_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('person') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the PROVIDER_ID in the PERSON is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'PERSON' as cdm_table_name
  ,'PROVIDER_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_person_provider_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = PERSON
cdmFieldName = PROVIDER_ID
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
			'PERSON.PROVIDER_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('person') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.PROVIDER_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.PROVIDER_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.PROVIDER_ID) AS varchar),'.') != 0))
			AND cdmTable.PROVIDER_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('person') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the RACE_CONCEPT_ID in the PERSON is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'PERSON' as cdm_table_name
  ,'RACE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_person_race_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'PERSON.RACE_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('person') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.RACE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.RACE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.RACE_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.RACE_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('person') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the RACE_SOURCE_CONCEPT_ID in the PERSON is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'PERSON' as cdm_table_name
  ,'RACE_SOURCE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_person_race_source_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = PERSON
cdmFieldName = RACE_SOURCE_CONCEPT_ID
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
			'PERSON.RACE_SOURCE_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('person') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.RACE_SOURCE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.RACE_SOURCE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.RACE_SOURCE_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.RACE_SOURCE_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('person') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the YEAR_OF_BIRTH in the PERSON is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'PERSON' as cdm_table_name
  ,'YEAR_OF_BIRTH' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_person_year_of_birth' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'PERSON.YEAR_OF_BIRTH' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('person') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.YEAR_OF_BIRTH AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.YEAR_OF_BIRTH AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.YEAR_OF_BIRTH) AS varchar),'.') != 0))
			AND cdmTable.YEAR_OF_BIRTH IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('person') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the MODIFIER_CONCEPT_ID in the PROCEDURE_OCCURRENCE is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'PROCEDURE_OCCURRENCE' as cdm_table_name
  ,'MODIFIER_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_procedure_occurrence_modifier_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = PROCEDURE_OCCURRENCE
cdmFieldName = MODIFIER_CONCEPT_ID
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
			'PROCEDURE_OCCURRENCE.MODIFIER_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('procedure_occurrence') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.MODIFIER_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.MODIFIER_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.MODIFIER_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.MODIFIER_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('procedure_occurrence') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the PERSON_ID in the PROCEDURE_OCCURRENCE is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'PROCEDURE_OCCURRENCE' as cdm_table_name
  ,'PERSON_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_procedure_occurrence_person_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'PROCEDURE_OCCURRENCE.PERSON_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('procedure_occurrence') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.PERSON_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.PERSON_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.PERSON_ID) AS varchar),'.') != 0))
			AND cdmTable.PERSON_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('procedure_occurrence') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the PROCEDURE_CONCEPT_ID in the PROCEDURE_OCCURRENCE is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'PROCEDURE_OCCURRENCE' as cdm_table_name
  ,'PROCEDURE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_procedure_occurrence_procedure_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'PROCEDURE_OCCURRENCE.PROCEDURE_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('procedure_occurrence') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.PROCEDURE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.PROCEDURE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.PROCEDURE_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.PROCEDURE_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('procedure_occurrence') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the PROCEDURE_OCCURRENCE_ID in the PROCEDURE_OCCURRENCE is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'PROCEDURE_OCCURRENCE' as cdm_table_name
  ,'PROCEDURE_OCCURRENCE_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_procedure_occurrence_procedure_occurrence_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'PROCEDURE_OCCURRENCE.PROCEDURE_OCCURRENCE_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('procedure_occurrence') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.PROCEDURE_OCCURRENCE_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.PROCEDURE_OCCURRENCE_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.PROCEDURE_OCCURRENCE_ID) AS varchar),'.') != 0))
			AND cdmTable.PROCEDURE_OCCURRENCE_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('procedure_occurrence') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the PROCEDURE_SOURCE_CONCEPT_ID in the PROCEDURE_OCCURRENCE is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'PROCEDURE_OCCURRENCE' as cdm_table_name
  ,'PROCEDURE_SOURCE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_procedure_occurrence_procedure_source_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = PROCEDURE_OCCURRENCE
cdmFieldName = PROCEDURE_SOURCE_CONCEPT_ID
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
			'PROCEDURE_OCCURRENCE.PROCEDURE_SOURCE_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('procedure_occurrence') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.PROCEDURE_SOURCE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.PROCEDURE_SOURCE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.PROCEDURE_SOURCE_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.PROCEDURE_SOURCE_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('procedure_occurrence') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the PROCEDURE_TYPE_CONCEPT_ID in the PROCEDURE_OCCURRENCE is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'PROCEDURE_OCCURRENCE' as cdm_table_name
  ,'PROCEDURE_TYPE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_procedure_occurrence_procedure_type_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'PROCEDURE_OCCURRENCE.PROCEDURE_TYPE_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('procedure_occurrence') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.PROCEDURE_TYPE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.PROCEDURE_TYPE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.PROCEDURE_TYPE_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.PROCEDURE_TYPE_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('procedure_occurrence') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the PROVIDER_ID in the PROCEDURE_OCCURRENCE is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'PROCEDURE_OCCURRENCE' as cdm_table_name
  ,'PROVIDER_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_procedure_occurrence_provider_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = PROCEDURE_OCCURRENCE
cdmFieldName = PROVIDER_ID
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
			'PROCEDURE_OCCURRENCE.PROVIDER_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('procedure_occurrence') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.PROVIDER_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.PROVIDER_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.PROVIDER_ID) AS varchar),'.') != 0))
			AND cdmTable.PROVIDER_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('procedure_occurrence') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the QUANTITY in the PROCEDURE_OCCURRENCE is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'PROCEDURE_OCCURRENCE' as cdm_table_name
  ,'QUANTITY' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_procedure_occurrence_quantity' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = PROCEDURE_OCCURRENCE
cdmFieldName = QUANTITY
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
			'PROCEDURE_OCCURRENCE.QUANTITY' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('procedure_occurrence') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.QUANTITY AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.QUANTITY AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.QUANTITY) AS varchar),'.') != 0))
			AND cdmTable.QUANTITY IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('procedure_occurrence') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the VISIT_DETAIL_ID in the PROCEDURE_OCCURRENCE is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'PROCEDURE_OCCURRENCE' as cdm_table_name
  ,'VISIT_DETAIL_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_procedure_occurrence_visit_detail_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = PROCEDURE_OCCURRENCE
cdmFieldName = VISIT_DETAIL_ID
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
			'PROCEDURE_OCCURRENCE.VISIT_DETAIL_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('procedure_occurrence') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.VISIT_DETAIL_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.VISIT_DETAIL_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.VISIT_DETAIL_ID) AS varchar),'.') != 0))
			AND cdmTable.VISIT_DETAIL_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('procedure_occurrence') }}
) denominator
) cte

UNION ALL
SELECT cte.num_violated_rows
  ,cte.pct_violated_rows
  ,cte.num_denominator_rows
  , CAST('' as TEXT) as execution_time
  ,'' as query_text
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the VISIT_OCCURRENCE_ID in the PROCEDURE_OCCURRENCE is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'PROCEDURE_OCCURRENCE' as cdm_table_name
  ,'VISIT_OCCURRENCE_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_procedure_occurrence_visit_occurrence_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = PROCEDURE_OCCURRENCE
cdmFieldName = VISIT_OCCURRENCE_ID
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
			'PROCEDURE_OCCURRENCE.VISIT_OCCURRENCE_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('procedure_occurrence') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.VISIT_OCCURRENCE_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.VISIT_OCCURRENCE_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.VISIT_OCCURRENCE_ID) AS varchar),'.') != 0))
			AND cdmTable.VISIT_OCCURRENCE_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('procedure_occurrence') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the CARE_SITE_ID in the PROVIDER is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'PROVIDER' as cdm_table_name
  ,'CARE_SITE_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_provider_care_site_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = PROVIDER
cdmFieldName = CARE_SITE_ID
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
			'PROVIDER.CARE_SITE_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('provider') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.CARE_SITE_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.CARE_SITE_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.CARE_SITE_ID) AS varchar),'.') != 0))
			AND cdmTable.CARE_SITE_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('provider') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the GENDER_CONCEPT_ID in the PROVIDER is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'PROVIDER' as cdm_table_name
  ,'GENDER_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_provider_gender_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = PROVIDER
cdmFieldName = GENDER_CONCEPT_ID
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
			'PROVIDER.GENDER_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('provider') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.GENDER_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.GENDER_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.GENDER_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.GENDER_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('provider') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the GENDER_SOURCE_CONCEPT_ID in the PROVIDER is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'PROVIDER' as cdm_table_name
  ,'GENDER_SOURCE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_provider_gender_source_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = PROVIDER
cdmFieldName = GENDER_SOURCE_CONCEPT_ID
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
			'PROVIDER.GENDER_SOURCE_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('provider') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.GENDER_SOURCE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.GENDER_SOURCE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.GENDER_SOURCE_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.GENDER_SOURCE_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('provider') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the PROVIDER_ID in the PROVIDER is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'PROVIDER' as cdm_table_name
  ,'PROVIDER_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_provider_provider_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'PROVIDER.PROVIDER_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('provider') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.PROVIDER_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.PROVIDER_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.PROVIDER_ID) AS varchar),'.') != 0))
			AND cdmTable.PROVIDER_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('provider') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the SPECIALTY_CONCEPT_ID in the PROVIDER is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'PROVIDER' as cdm_table_name
  ,'SPECIALTY_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_provider_specialty_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = PROVIDER
cdmFieldName = SPECIALTY_CONCEPT_ID
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
			'PROVIDER.SPECIALTY_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('provider') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.SPECIALTY_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.SPECIALTY_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.SPECIALTY_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.SPECIALTY_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('provider') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the SPECIALTY_SOURCE_CONCEPT_ID in the PROVIDER is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'PROVIDER' as cdm_table_name
  ,'SPECIALTY_SOURCE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_provider_specialty_source_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = PROVIDER
cdmFieldName = SPECIALTY_SOURCE_CONCEPT_ID
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
			'PROVIDER.SPECIALTY_SOURCE_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('provider') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.SPECIALTY_SOURCE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.SPECIALTY_SOURCE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.SPECIALTY_SOURCE_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.SPECIALTY_SOURCE_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('provider') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the YEAR_OF_BIRTH in the PROVIDER is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'PROVIDER' as cdm_table_name
  ,'YEAR_OF_BIRTH' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_provider_year_of_birth' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = PROVIDER
cdmFieldName = YEAR_OF_BIRTH
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
			'PROVIDER.YEAR_OF_BIRTH' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('provider') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.YEAR_OF_BIRTH AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.YEAR_OF_BIRTH AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.YEAR_OF_BIRTH) AS varchar),'.') != 0))
			AND cdmTable.YEAR_OF_BIRTH IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('provider') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the ANATOMIC_SITE_CONCEPT_ID in the SPECIMEN is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'SPECIMEN' as cdm_table_name
  ,'ANATOMIC_SITE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_specimen_anatomic_site_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = SPECIMEN
cdmFieldName = ANATOMIC_SITE_CONCEPT_ID
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
			'SPECIMEN.ANATOMIC_SITE_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('specimen') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.ANATOMIC_SITE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.ANATOMIC_SITE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.ANATOMIC_SITE_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.ANATOMIC_SITE_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('specimen') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the DISEASE_STATUS_CONCEPT_ID in the SPECIMEN is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'SPECIMEN' as cdm_table_name
  ,'DISEASE_STATUS_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_specimen_disease_status_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = SPECIMEN
cdmFieldName = DISEASE_STATUS_CONCEPT_ID
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
			'SPECIMEN.DISEASE_STATUS_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('specimen') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.DISEASE_STATUS_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.DISEASE_STATUS_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.DISEASE_STATUS_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.DISEASE_STATUS_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('specimen') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the PERSON_ID in the SPECIMEN is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'SPECIMEN' as cdm_table_name
  ,'PERSON_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_specimen_person_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'SPECIMEN.PERSON_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('specimen') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.PERSON_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.PERSON_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.PERSON_ID) AS varchar),'.') != 0))
			AND cdmTable.PERSON_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('specimen') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the SPECIMEN_CONCEPT_ID in the SPECIMEN is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'SPECIMEN' as cdm_table_name
  ,'SPECIMEN_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_specimen_specimen_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'SPECIMEN.SPECIMEN_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('specimen') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.SPECIMEN_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.SPECIMEN_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.SPECIMEN_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.SPECIMEN_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('specimen') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the SPECIMEN_ID in the SPECIMEN is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'SPECIMEN' as cdm_table_name
  ,'SPECIMEN_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_specimen_specimen_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'SPECIMEN.SPECIMEN_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('specimen') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.SPECIMEN_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.SPECIMEN_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.SPECIMEN_ID) AS varchar),'.') != 0))
			AND cdmTable.SPECIMEN_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('specimen') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the SPECIMEN_TYPE_CONCEPT_ID in the SPECIMEN is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'SPECIMEN' as cdm_table_name
  ,'SPECIMEN_TYPE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_specimen_specimen_type_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'SPECIMEN.SPECIMEN_TYPE_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('specimen') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.SPECIMEN_TYPE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.SPECIMEN_TYPE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.SPECIMEN_TYPE_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.SPECIMEN_TYPE_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('specimen') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the UNIT_CONCEPT_ID in the SPECIMEN is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'SPECIMEN' as cdm_table_name
  ,'UNIT_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_specimen_unit_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = SPECIMEN
cdmFieldName = UNIT_CONCEPT_ID
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
			'SPECIMEN.UNIT_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('specimen') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.UNIT_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.UNIT_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.UNIT_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.UNIT_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('specimen') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the CARE_SITE_ID in the VISIT_DETAIL is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'VISIT_DETAIL' as cdm_table_name
  ,'CARE_SITE_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_visit_detail_care_site_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = VISIT_DETAIL
cdmFieldName = CARE_SITE_ID
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
			'VISIT_DETAIL.CARE_SITE_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('visit_detail') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.CARE_SITE_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.CARE_SITE_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.CARE_SITE_ID) AS varchar),'.') != 0))
			AND cdmTable.CARE_SITE_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('visit_detail') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the DISCHARGED_TO_CONCEPT_ID in the VISIT_DETAIL is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'VISIT_DETAIL' as cdm_table_name
  ,'DISCHARGED_TO_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_visit_detail_discharged_to_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = VISIT_DETAIL
cdmFieldName = DISCHARGED_TO_CONCEPT_ID
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
			'VISIT_DETAIL.DISCHARGED_TO_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('visit_detail') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.DISCHARGED_TO_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.DISCHARGED_TO_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.DISCHARGED_TO_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.DISCHARGED_TO_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('visit_detail') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the PARENT_VISIT_DETAIL_ID in the VISIT_DETAIL is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'VISIT_DETAIL' as cdm_table_name
  ,'PARENT_VISIT_DETAIL_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_visit_detail_parent_visit_detail_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = VISIT_DETAIL
cdmFieldName = PARENT_VISIT_DETAIL_ID
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
			'VISIT_DETAIL.PARENT_VISIT_DETAIL_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('visit_detail') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.PARENT_VISIT_DETAIL_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.PARENT_VISIT_DETAIL_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.PARENT_VISIT_DETAIL_ID) AS varchar),'.') != 0))
			AND cdmTable.PARENT_VISIT_DETAIL_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('visit_detail') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the PERSON_ID in the VISIT_DETAIL is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'VISIT_DETAIL' as cdm_table_name
  ,'PERSON_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_visit_detail_person_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'VISIT_DETAIL.PERSON_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('visit_detail') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.PERSON_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.PERSON_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.PERSON_ID) AS varchar),'.') != 0))
			AND cdmTable.PERSON_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('visit_detail') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the PRECEDING_VISIT_DETAIL_ID in the VISIT_DETAIL is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'VISIT_DETAIL' as cdm_table_name
  ,'PRECEDING_VISIT_DETAIL_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_visit_detail_preceding_visit_detail_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = VISIT_DETAIL
cdmFieldName = PRECEDING_VISIT_DETAIL_ID
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
			'VISIT_DETAIL.PRECEDING_VISIT_DETAIL_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('visit_detail') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.PRECEDING_VISIT_DETAIL_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.PRECEDING_VISIT_DETAIL_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.PRECEDING_VISIT_DETAIL_ID) AS varchar),'.') != 0))
			AND cdmTable.PRECEDING_VISIT_DETAIL_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('visit_detail') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the PROVIDER_ID in the VISIT_DETAIL is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'VISIT_DETAIL' as cdm_table_name
  ,'PROVIDER_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_visit_detail_provider_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = VISIT_DETAIL
cdmFieldName = PROVIDER_ID
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
			'VISIT_DETAIL.PROVIDER_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('visit_detail') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.PROVIDER_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.PROVIDER_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.PROVIDER_ID) AS varchar),'.') != 0))
			AND cdmTable.PROVIDER_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('visit_detail') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the VISIT_DETAIL_CONCEPT_ID in the VISIT_DETAIL is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'VISIT_DETAIL' as cdm_table_name
  ,'VISIT_DETAIL_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_visit_detail_visit_detail_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'VISIT_DETAIL.VISIT_DETAIL_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('visit_detail') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.VISIT_DETAIL_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.VISIT_DETAIL_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.VISIT_DETAIL_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.VISIT_DETAIL_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('visit_detail') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the VISIT_DETAIL_ID in the VISIT_DETAIL is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'VISIT_DETAIL' as cdm_table_name
  ,'VISIT_DETAIL_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_visit_detail_visit_detail_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'VISIT_DETAIL.VISIT_DETAIL_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('visit_detail') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.VISIT_DETAIL_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.VISIT_DETAIL_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.VISIT_DETAIL_ID) AS varchar),'.') != 0))
			AND cdmTable.VISIT_DETAIL_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('visit_detail') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the VISIT_DETAIL_TYPE_CONCEPT_ID in the VISIT_DETAIL is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'VISIT_DETAIL' as cdm_table_name
  ,'VISIT_DETAIL_TYPE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_visit_detail_visit_detail_type_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'VISIT_DETAIL.VISIT_DETAIL_TYPE_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('visit_detail') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.VISIT_DETAIL_TYPE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.VISIT_DETAIL_TYPE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.VISIT_DETAIL_TYPE_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.VISIT_DETAIL_TYPE_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('visit_detail') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the VISIT_OCCURRENCE_ID in the VISIT_DETAIL is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'VISIT_DETAIL' as cdm_table_name
  ,'VISIT_OCCURRENCE_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_visit_detail_visit_occurrence_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'VISIT_DETAIL.VISIT_OCCURRENCE_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('visit_detail') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.VISIT_OCCURRENCE_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.VISIT_OCCURRENCE_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.VISIT_OCCURRENCE_ID) AS varchar),'.') != 0))
			AND cdmTable.VISIT_OCCURRENCE_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('visit_detail') }}
) denominator
) cte

UNION ALL
SELECT cte.num_violated_rows
  ,cte.pct_violated_rows
  ,cte.num_denominator_rows
  , CAST('' as TEXT) as execution_time
  ,'' as query_text
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the ADMITTED_FROM_CONCEPT_ID in the VISIT_OCCURRENCE is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'VISIT_OCCURRENCE' as cdm_table_name
  ,'ADMITTED_FROM_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_visit_occurrence_admitted_from_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = VISIT_OCCURRENCE
cdmFieldName = ADMITTED_FROM_CONCEPT_ID
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
			'VISIT_OCCURRENCE.ADMITTED_FROM_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('visit_occurrence') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.ADMITTED_FROM_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.ADMITTED_FROM_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.ADMITTED_FROM_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.ADMITTED_FROM_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('visit_occurrence') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the CARE_SITE_ID in the VISIT_OCCURRENCE is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'VISIT_OCCURRENCE' as cdm_table_name
  ,'CARE_SITE_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_visit_occurrence_care_site_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = VISIT_OCCURRENCE
cdmFieldName = CARE_SITE_ID
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
			'VISIT_OCCURRENCE.CARE_SITE_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('visit_occurrence') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.CARE_SITE_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.CARE_SITE_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.CARE_SITE_ID) AS varchar),'.') != 0))
			AND cdmTable.CARE_SITE_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('visit_occurrence') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the DISCHARGED_TO_CONCEPT_ID in the VISIT_OCCURRENCE is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'VISIT_OCCURRENCE' as cdm_table_name
  ,'DISCHARGED_TO_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_visit_occurrence_discharged_to_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = VISIT_OCCURRENCE
cdmFieldName = DISCHARGED_TO_CONCEPT_ID
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
			'VISIT_OCCURRENCE.DISCHARGED_TO_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('visit_occurrence') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.DISCHARGED_TO_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.DISCHARGED_TO_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.DISCHARGED_TO_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.DISCHARGED_TO_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('visit_occurrence') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the PERSON_ID in the VISIT_OCCURRENCE is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'VISIT_OCCURRENCE' as cdm_table_name
  ,'PERSON_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_visit_occurrence_person_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'VISIT_OCCURRENCE.PERSON_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('visit_occurrence') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.PERSON_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.PERSON_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.PERSON_ID) AS varchar),'.') != 0))
			AND cdmTable.PERSON_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('visit_occurrence') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the PRECEDING_VISIT_OCCURRENCE_ID in the VISIT_OCCURRENCE is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'VISIT_OCCURRENCE' as cdm_table_name
  ,'PRECEDING_VISIT_OCCURRENCE_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_visit_occurrence_preceding_visit_occurrence_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = VISIT_OCCURRENCE
cdmFieldName = PRECEDING_VISIT_OCCURRENCE_ID
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
			'VISIT_OCCURRENCE.PRECEDING_VISIT_OCCURRENCE_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('visit_occurrence') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.PRECEDING_VISIT_OCCURRENCE_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.PRECEDING_VISIT_OCCURRENCE_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.PRECEDING_VISIT_OCCURRENCE_ID) AS varchar),'.') != 0))
			AND cdmTable.PRECEDING_VISIT_OCCURRENCE_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('visit_occurrence') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the PROVIDER_ID in the VISIT_OCCURRENCE is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'VISIT_OCCURRENCE' as cdm_table_name
  ,'PROVIDER_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_visit_occurrence_provider_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = VISIT_OCCURRENCE
cdmFieldName = PROVIDER_ID
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
			'VISIT_OCCURRENCE.PROVIDER_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('visit_occurrence') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.PROVIDER_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.PROVIDER_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.PROVIDER_ID) AS varchar),'.') != 0))
			AND cdmTable.PROVIDER_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('visit_occurrence') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the VISIT_CONCEPT_ID in the VISIT_OCCURRENCE is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'VISIT_OCCURRENCE' as cdm_table_name
  ,'VISIT_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_visit_occurrence_visit_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'VISIT_OCCURRENCE.VISIT_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('visit_occurrence') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.VISIT_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.VISIT_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.VISIT_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.VISIT_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('visit_occurrence') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the VISIT_OCCURRENCE_ID in the VISIT_OCCURRENCE is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'VISIT_OCCURRENCE' as cdm_table_name
  ,'VISIT_OCCURRENCE_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_visit_occurrence_visit_occurrence_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
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
FROM
(
	SELECT 
		COUNT(violated_rows.violating_field) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT 
			'VISIT_OCCURRENCE.VISIT_OCCURRENCE_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('visit_occurrence') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.VISIT_OCCURRENCE_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.VISIT_OCCURRENCE_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.VISIT_OCCURRENCE_ID) AS varchar),'.') != 0))
			AND cdmTable.VISIT_OCCURRENCE_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('visit_occurrence') }}
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
  ,'cdmDatatype' as check_name
  ,'FIELD' as check_level
  ,'A yes or no value indicating if the VISIT_SOURCE_CONCEPT_ID in the VISIT_OCCURRENCE is the expected data type based on the specification.  Only checks integer fields.' as check_description
  ,'VISIT_OCCURRENCE' as cdm_table_name
  ,'VISIT_SOURCE_CONCEPT_ID' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_cdm_datatype.sql' as sql_file
  ,'Conformance' as category
  ,'Value' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_cdmdatatype_visit_occurrence_visit_source_concept_id' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
FIELD_CDM_DATATYPE
In some SQL dialects, check that integer fields only contain digits.
In others, check that integer fields are numeric and contain no decimal points
Parameters used in this template:
schema = cdm
cdmTableName = VISIT_OCCURRENCE
cdmFieldName = VISIT_SOURCE_CONCEPT_ID
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
			'VISIT_OCCURRENCE.VISIT_SOURCE_CONCEPT_ID' AS violating_field, 
			cdmTable.* 
		FROM {{ ref('visit_occurrence') }} cdmTable
		WHERE 
			(CASE WHEN (CAST(cdmTable.VISIT_SOURCE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 0 
			OR (CASE WHEN (CAST(cdmTable.VISIT_SOURCE_CONCEPT_ID AS VARCHAR) ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$') THEN 1 ELSE 0 END = 1 
				AND STRPOS(CAST(ABS(cdmTable.VISIT_SOURCE_CONCEPT_ID) AS varchar),'.') != 0))
			AND cdmTable.VISIT_SOURCE_CONCEPT_ID IS NOT NULL
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(*) AS num_rows
	FROM {{ ref('visit_occurrence') }}
) denominator
) cte
)
SELECT * FROM cte_all
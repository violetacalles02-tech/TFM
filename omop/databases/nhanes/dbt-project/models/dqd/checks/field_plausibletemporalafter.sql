

/*********
SQL to insert individual DQD results directly into output table, rather than waiting until collecting all results.
Note that this  does not include information about SQL errors or performance
**********/
WITH cte_all  AS (SELECT cte.num_violated_rows
  ,cte.pct_violated_rows
  ,cte.num_denominator_rows
  , CAST('' as TEXT) as execution_time
  ,'' as query_text
  ,'plausibleTemporalAfter' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a value in the CDM_RELEASE_DATE field of the CDM_SOURCE that occurs prior to the date in the SOURCE_RELEASE_DATE field of the CDM_SOURCE table.' as check_description
  ,'CDM_SOURCE' as cdm_table_name
  ,'CDM_RELEASE_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_temporal_after.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausibletemporalafter_cdm_source_cdm_release_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_TEMPORAL_AFTER
get number of records and the proportion to total number of eligible records with datetimes that do not occur on or after their corresponding datetimes
Parameters used in this template:
schema = cdm
cdmTableName = CDM_SOURCE
cdmFieldName = CDM_RELEASE_DATE
plausibleTemporalAfterTableName = CDM_SOURCE
plausibleTemporalAfterFieldName = SOURCE_RELEASE_DATE
**********/
SELECT 
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
			'CDM_SOURCE.CDM_RELEASE_DATE' AS violating_field, 
			cdmTable.*
    	FROM {{ ref('cdm_source') }} cdmTable
    WHERE 
			CAST(cdmTable.SOURCE_RELEASE_DATE AS DATE)
		 > CAST(cdmTable.CDM_RELEASE_DATE AS DATE)
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
  ,'plausibleTemporalAfter' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a value in the CONDITION_ERA_END_DATE field of the CONDITION_ERA that occurs prior to the date in the CONDITION_ERA_START_DATE field of the CONDITION_ERA table.' as check_description
  ,'CONDITION_ERA' as cdm_table_name
  ,'CONDITION_ERA_END_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_temporal_after.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausibletemporalafter_condition_era_condition_era_end_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_TEMPORAL_AFTER
get number of records and the proportion to total number of eligible records with datetimes that do not occur on or after their corresponding datetimes
Parameters used in this template:
schema = cdm
cdmTableName = CONDITION_ERA
cdmFieldName = CONDITION_ERA_END_DATE
plausibleTemporalAfterTableName = CONDITION_ERA
plausibleTemporalAfterFieldName = CONDITION_ERA_START_DATE
**********/
SELECT 
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
    WHERE 
			CAST(cdmTable.CONDITION_ERA_START_DATE AS DATE)
		 > CAST(cdmTable.CONDITION_ERA_END_DATE AS DATE)
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
  ,'plausibleTemporalAfter' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a value in the CONDITION_ERA_START_DATE field of the CONDITION_ERA that occurs prior to the date in the BIRTH_DATETIME field of the PERSON table.' as check_description
  ,'CONDITION_ERA' as cdm_table_name
  ,'CONDITION_ERA_START_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_temporal_after.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausibletemporalafter_condition_era_condition_era_start_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_TEMPORAL_AFTER
get number of records and the proportion to total number of eligible records with datetimes that do not occur on or after their corresponding datetimes
Parameters used in this template:
schema = cdm
cdmTableName = CONDITION_ERA
cdmFieldName = CONDITION_ERA_START_DATE
plausibleTemporalAfterTableName = PERSON
plausibleTemporalAfterFieldName = BIRTH_DATETIME
**********/
SELECT 
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
				JOIN {{ ref('person') }} plausibleTable 
                    ON cdmTable.person_id = plausibleTable.person_id
    WHERE 
			COALESCE(
				CAST(plausibleTable.BIRTH_DATETIME AS DATE),
				{{ make_date('plausibleTable.year_of_birth', 6, 1) }}
			) 
		 > CAST(cdmTable.CONDITION_ERA_START_DATE AS DATE)
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
  ,'plausibleTemporalAfter' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a value in the CONDITION_END_DATE field of the CONDITION_OCCURRENCE that occurs prior to the date in the CONDITION_START_DATE field of the CONDITION_OCCURRENCE table.' as check_description
  ,'CONDITION_OCCURRENCE' as cdm_table_name
  ,'CONDITION_END_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_temporal_after.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausibletemporalafter_condition_occurrence_condition_end_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_TEMPORAL_AFTER
get number of records and the proportion to total number of eligible records with datetimes that do not occur on or after their corresponding datetimes
Parameters used in this template:
schema = cdm
cdmTableName = CONDITION_OCCURRENCE
cdmFieldName = CONDITION_END_DATE
plausibleTemporalAfterTableName = CONDITION_OCCURRENCE
plausibleTemporalAfterFieldName = CONDITION_START_DATE
**********/
SELECT 
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
    WHERE 
			CAST(cdmTable.CONDITION_START_DATE AS DATE)
		 > CAST(cdmTable.CONDITION_END_DATE AS DATE)
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
  ,'plausibleTemporalAfter' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a value in the CONDITION_END_DATETIME field of the CONDITION_OCCURRENCE that occurs prior to the date in the CONDITION_START_DATETIME field of the CONDITION_OCCURRENCE table.' as check_description
  ,'CONDITION_OCCURRENCE' as cdm_table_name
  ,'CONDITION_END_DATETIME' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_temporal_after.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausibletemporalafter_condition_occurrence_condition_end_datetime' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_TEMPORAL_AFTER
get number of records and the proportion to total number of eligible records with datetimes that do not occur on or after their corresponding datetimes
Parameters used in this template:
schema = cdm
cdmTableName = CONDITION_OCCURRENCE
cdmFieldName = CONDITION_END_DATETIME
plausibleTemporalAfterTableName = CONDITION_OCCURRENCE
plausibleTemporalAfterFieldName = CONDITION_START_DATETIME
**********/
SELECT 
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
    WHERE 
			CAST(cdmTable.CONDITION_START_DATETIME AS DATE)
		 > CAST(cdmTable.CONDITION_END_DATETIME AS DATE)
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
  ,'plausibleTemporalAfter' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a value in the CONDITION_START_DATE field of the CONDITION_OCCURRENCE that occurs prior to the date in the BIRTH_DATETIME field of the PERSON table.' as check_description
  ,'CONDITION_OCCURRENCE' as cdm_table_name
  ,'CONDITION_START_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_temporal_after.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausibletemporalafter_condition_occurrence_condition_start_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_TEMPORAL_AFTER
get number of records and the proportion to total number of eligible records with datetimes that do not occur on or after their corresponding datetimes
Parameters used in this template:
schema = cdm
cdmTableName = CONDITION_OCCURRENCE
cdmFieldName = CONDITION_START_DATE
plausibleTemporalAfterTableName = PERSON
plausibleTemporalAfterFieldName = BIRTH_DATETIME
**********/
SELECT 
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
				JOIN {{ ref('person') }} plausibleTable 
                    ON cdmTable.person_id = plausibleTable.person_id
    WHERE 
			COALESCE(
				CAST(plausibleTable.BIRTH_DATETIME AS DATE),
				{{ make_date('plausibleTable.year_of_birth', 6, 1) }}
			) 
		 > CAST(cdmTable.CONDITION_START_DATE AS DATE)
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
  ,'plausibleTemporalAfter' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a value in the CONDITION_START_DATETIME field of the CONDITION_OCCURRENCE that occurs prior to the date in the BIRTH_DATETIME field of the PERSON table.' as check_description
  ,'CONDITION_OCCURRENCE' as cdm_table_name
  ,'CONDITION_START_DATETIME' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_temporal_after.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausibletemporalafter_condition_occurrence_condition_start_datetime' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_TEMPORAL_AFTER
get number of records and the proportion to total number of eligible records with datetimes that do not occur on or after their corresponding datetimes
Parameters used in this template:
schema = cdm
cdmTableName = CONDITION_OCCURRENCE
cdmFieldName = CONDITION_START_DATETIME
plausibleTemporalAfterTableName = PERSON
plausibleTemporalAfterFieldName = BIRTH_DATETIME
**********/
SELECT 
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
				JOIN {{ ref('person') }} plausibleTable 
                    ON cdmTable.person_id = plausibleTable.person_id
    WHERE 
			COALESCE(
				CAST(plausibleTable.BIRTH_DATETIME AS DATE),
				{{ make_date('plausibleTable.year_of_birth', 6, 1) }}
			) 
		 > CAST(cdmTable.CONDITION_START_DATETIME AS DATE)
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
  ,'plausibleTemporalAfter' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a value in the DEATH_DATE field of the DEATH that occurs prior to the date in the BIRTH_DATETIME field of the PERSON table.' as check_description
  ,'DEATH' as cdm_table_name
  ,'DEATH_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_temporal_after.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausibletemporalafter_death_death_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_TEMPORAL_AFTER
get number of records and the proportion to total number of eligible records with datetimes that do not occur on or after their corresponding datetimes
Parameters used in this template:
schema = cdm
cdmTableName = DEATH
cdmFieldName = DEATH_DATE
plausibleTemporalAfterTableName = PERSON
plausibleTemporalAfterFieldName = BIRTH_DATETIME
**********/
SELECT 
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
			'DEATH.DEATH_DATE' AS violating_field, 
			cdmTable.*
    	FROM {{ ref('death') }} cdmTable
				JOIN {{ ref('person') }} plausibleTable 
                    ON cdmTable.person_id = plausibleTable.person_id
    WHERE 
			COALESCE(
				CAST(plausibleTable.BIRTH_DATETIME AS DATE),
				{{ make_date('plausibleTable.year_of_birth', 6, 1) }}
			) 
		 > CAST(cdmTable.DEATH_DATE AS DATE)
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
  ,'plausibleTemporalAfter' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a value in the DEATH_DATETIME field of the DEATH that occurs prior to the date in the BIRTH_DATETIME field of the PERSON table.' as check_description
  ,'DEATH' as cdm_table_name
  ,'DEATH_DATETIME' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_temporal_after.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausibletemporalafter_death_death_datetime' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_TEMPORAL_AFTER
get number of records and the proportion to total number of eligible records with datetimes that do not occur on or after their corresponding datetimes
Parameters used in this template:
schema = cdm
cdmTableName = DEATH
cdmFieldName = DEATH_DATETIME
plausibleTemporalAfterTableName = PERSON
plausibleTemporalAfterFieldName = BIRTH_DATETIME
**********/
SELECT 
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
			'DEATH.DEATH_DATETIME' AS violating_field, 
			cdmTable.*
    	FROM {{ ref('death') }} cdmTable
				JOIN {{ ref('person') }} plausibleTable 
                    ON cdmTable.person_id = plausibleTable.person_id
    WHERE 
			COALESCE(
				CAST(plausibleTable.BIRTH_DATETIME AS DATE),
				{{ make_date('plausibleTable.year_of_birth', 6, 1) }}
			) 
		 > CAST(cdmTable.DEATH_DATETIME AS DATE)
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
  ,'plausibleTemporalAfter' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a value in the DEVICE_EXPOSURE_END_DATE field of the DEVICE_EXPOSURE that occurs prior to the date in the DEVICE_EXPOSURE_START_DATE field of the DEVICE_EXPOSURE table.' as check_description
  ,'DEVICE_EXPOSURE' as cdm_table_name
  ,'DEVICE_EXPOSURE_END_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_temporal_after.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausibletemporalafter_device_exposure_device_exposure_end_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_TEMPORAL_AFTER
get number of records and the proportion to total number of eligible records with datetimes that do not occur on or after their corresponding datetimes
Parameters used in this template:
schema = cdm
cdmTableName = DEVICE_EXPOSURE
cdmFieldName = DEVICE_EXPOSURE_END_DATE
plausibleTemporalAfterTableName = DEVICE_EXPOSURE
plausibleTemporalAfterFieldName = DEVICE_EXPOSURE_START_DATE
**********/
SELECT 
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
    WHERE 
			CAST(cdmTable.DEVICE_EXPOSURE_START_DATE AS DATE)
		 > CAST(cdmTable.DEVICE_EXPOSURE_END_DATE AS DATE)
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
  ,'plausibleTemporalAfter' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a value in the DEVICE_EXPOSURE_END_DATETIME field of the DEVICE_EXPOSURE that occurs prior to the date in the DEVICE_EXPOSURE_START_DATETIME field of the DEVICE_EXPOSURE table.' as check_description
  ,'DEVICE_EXPOSURE' as cdm_table_name
  ,'DEVICE_EXPOSURE_END_DATETIME' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_temporal_after.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausibletemporalafter_device_exposure_device_exposure_end_datetime' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_TEMPORAL_AFTER
get number of records and the proportion to total number of eligible records with datetimes that do not occur on or after their corresponding datetimes
Parameters used in this template:
schema = cdm
cdmTableName = DEVICE_EXPOSURE
cdmFieldName = DEVICE_EXPOSURE_END_DATETIME
plausibleTemporalAfterTableName = DEVICE_EXPOSURE
plausibleTemporalAfterFieldName = DEVICE_EXPOSURE_START_DATETIME
**********/
SELECT 
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
    WHERE 
			CAST(cdmTable.DEVICE_EXPOSURE_START_DATETIME AS DATE)
		 > CAST(cdmTable.DEVICE_EXPOSURE_END_DATETIME AS DATE)
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
  ,'plausibleTemporalAfter' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a value in the DEVICE_EXPOSURE_START_DATE field of the DEVICE_EXPOSURE that occurs prior to the date in the BIRTH_DATETIME field of the PERSON table.' as check_description
  ,'DEVICE_EXPOSURE' as cdm_table_name
  ,'DEVICE_EXPOSURE_START_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_temporal_after.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausibletemporalafter_device_exposure_device_exposure_start_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_TEMPORAL_AFTER
get number of records and the proportion to total number of eligible records with datetimes that do not occur on or after their corresponding datetimes
Parameters used in this template:
schema = cdm
cdmTableName = DEVICE_EXPOSURE
cdmFieldName = DEVICE_EXPOSURE_START_DATE
plausibleTemporalAfterTableName = PERSON
plausibleTemporalAfterFieldName = BIRTH_DATETIME
**********/
SELECT 
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
				JOIN {{ ref('person') }} plausibleTable 
                    ON cdmTable.person_id = plausibleTable.person_id
    WHERE 
			COALESCE(
				CAST(plausibleTable.BIRTH_DATETIME AS DATE),
				{{ make_date('plausibleTable.year_of_birth', 6, 1) }}
			) 
		 > CAST(cdmTable.DEVICE_EXPOSURE_START_DATE AS DATE)
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
  ,'plausibleTemporalAfter' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a value in the DEVICE_EXPOSURE_START_DATETIME field of the DEVICE_EXPOSURE that occurs prior to the date in the BIRTH_DATETIME field of the PERSON table.' as check_description
  ,'DEVICE_EXPOSURE' as cdm_table_name
  ,'DEVICE_EXPOSURE_START_DATETIME' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_temporal_after.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausibletemporalafter_device_exposure_device_exposure_start_datetime' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_TEMPORAL_AFTER
get number of records and the proportion to total number of eligible records with datetimes that do not occur on or after their corresponding datetimes
Parameters used in this template:
schema = cdm
cdmTableName = DEVICE_EXPOSURE
cdmFieldName = DEVICE_EXPOSURE_START_DATETIME
plausibleTemporalAfterTableName = PERSON
plausibleTemporalAfterFieldName = BIRTH_DATETIME
**********/
SELECT 
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
				JOIN {{ ref('person') }} plausibleTable 
                    ON cdmTable.person_id = plausibleTable.person_id
    WHERE 
			COALESCE(
				CAST(plausibleTable.BIRTH_DATETIME AS DATE),
				{{ make_date('plausibleTable.year_of_birth', 6, 1) }}
			) 
		 > CAST(cdmTable.DEVICE_EXPOSURE_START_DATETIME AS DATE)
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
  ,'plausibleTemporalAfter' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a value in the DOSE_ERA_END_DATE field of the DOSE_ERA that occurs prior to the date in the BIRTH_DATETIME field of the PERSON table.' as check_description
  ,'DOSE_ERA' as cdm_table_name
  ,'DOSE_ERA_END_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_temporal_after.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausibletemporalafter_dose_era_dose_era_end_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_TEMPORAL_AFTER
get number of records and the proportion to total number of eligible records with datetimes that do not occur on or after their corresponding datetimes
Parameters used in this template:
schema = cdm
cdmTableName = DOSE_ERA
cdmFieldName = DOSE_ERA_END_DATE
plausibleTemporalAfterTableName = PERSON
plausibleTemporalAfterFieldName = BIRTH_DATETIME
**********/
SELECT 
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
				JOIN {{ ref('person') }} plausibleTable 
                    ON cdmTable.person_id = plausibleTable.person_id
    WHERE 
			COALESCE(
				CAST(plausibleTable.BIRTH_DATETIME AS DATE),
				{{ make_date('plausibleTable.year_of_birth', 6, 1) }}
			) 
		 > CAST(cdmTable.DOSE_ERA_END_DATE AS DATE)
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
  ,'plausibleTemporalAfter' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a value in the DOSE_ERA_START_DATE field of the DOSE_ERA that occurs prior to the date in the BIRTH_DATETIME field of the PERSON table.' as check_description
  ,'DOSE_ERA' as cdm_table_name
  ,'DOSE_ERA_START_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_temporal_after.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausibletemporalafter_dose_era_dose_era_start_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_TEMPORAL_AFTER
get number of records and the proportion to total number of eligible records with datetimes that do not occur on or after their corresponding datetimes
Parameters used in this template:
schema = cdm
cdmTableName = DOSE_ERA
cdmFieldName = DOSE_ERA_START_DATE
plausibleTemporalAfterTableName = PERSON
plausibleTemporalAfterFieldName = BIRTH_DATETIME
**********/
SELECT 
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
				JOIN {{ ref('person') }} plausibleTable 
                    ON cdmTable.person_id = plausibleTable.person_id
    WHERE 
			COALESCE(
				CAST(plausibleTable.BIRTH_DATETIME AS DATE),
				{{ make_date('plausibleTable.year_of_birth', 6, 1) }}
			) 
		 > CAST(cdmTable.DOSE_ERA_START_DATE AS DATE)
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
  ,'plausibleTemporalAfter' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a value in the DRUG_ERA_END_DATE field of the DRUG_ERA that occurs prior to the date in the DRUG_ERA_START_DATE field of the DRUG_ERA table.' as check_description
  ,'DRUG_ERA' as cdm_table_name
  ,'DRUG_ERA_END_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_temporal_after.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausibletemporalafter_drug_era_drug_era_end_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_TEMPORAL_AFTER
get number of records and the proportion to total number of eligible records with datetimes that do not occur on or after their corresponding datetimes
Parameters used in this template:
schema = cdm
cdmTableName = DRUG_ERA
cdmFieldName = DRUG_ERA_END_DATE
plausibleTemporalAfterTableName = DRUG_ERA
plausibleTemporalAfterFieldName = DRUG_ERA_START_DATE
**********/
SELECT 
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
    WHERE 
			CAST(cdmTable.DRUG_ERA_START_DATE AS DATE)
		 > CAST(cdmTable.DRUG_ERA_END_DATE AS DATE)
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
  ,'plausibleTemporalAfter' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a value in the DRUG_ERA_START_DATE field of the DRUG_ERA that occurs prior to the date in the BIRTH_DATETIME field of the PERSON table.' as check_description
  ,'DRUG_ERA' as cdm_table_name
  ,'DRUG_ERA_START_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_temporal_after.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausibletemporalafter_drug_era_drug_era_start_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_TEMPORAL_AFTER
get number of records and the proportion to total number of eligible records with datetimes that do not occur on or after their corresponding datetimes
Parameters used in this template:
schema = cdm
cdmTableName = DRUG_ERA
cdmFieldName = DRUG_ERA_START_DATE
plausibleTemporalAfterTableName = PERSON
plausibleTemporalAfterFieldName = BIRTH_DATETIME
**********/
SELECT 
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
				JOIN {{ ref('person') }} plausibleTable 
                    ON cdmTable.person_id = plausibleTable.person_id
    WHERE 
			COALESCE(
				CAST(plausibleTable.BIRTH_DATETIME AS DATE),
				{{ make_date('plausibleTable.year_of_birth', 6, 1) }}
			) 
		 > CAST(cdmTable.DRUG_ERA_START_DATE AS DATE)
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
  ,'plausibleTemporalAfter' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a value in the DRUG_EXPOSURE_END_DATE field of the DRUG_EXPOSURE that occurs prior to the date in the DRUG_EXPOSURE_START_DATE field of the DRUG_EXPOSURE table.' as check_description
  ,'DRUG_EXPOSURE' as cdm_table_name
  ,'DRUG_EXPOSURE_END_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_temporal_after.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausibletemporalafter_drug_exposure_drug_exposure_end_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_TEMPORAL_AFTER
get number of records and the proportion to total number of eligible records with datetimes that do not occur on or after their corresponding datetimes
Parameters used in this template:
schema = cdm
cdmTableName = DRUG_EXPOSURE
cdmFieldName = DRUG_EXPOSURE_END_DATE
plausibleTemporalAfterTableName = DRUG_EXPOSURE
plausibleTemporalAfterFieldName = DRUG_EXPOSURE_START_DATE
**********/
SELECT 
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
    WHERE 
			CAST(cdmTable.DRUG_EXPOSURE_START_DATE AS DATE)
		 > CAST(cdmTable.DRUG_EXPOSURE_END_DATE AS DATE)
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
  ,'plausibleTemporalAfter' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a value in the DRUG_EXPOSURE_END_DATETIME field of the DRUG_EXPOSURE that occurs prior to the date in the DRUG_EXPOSURE_START_DATETIME field of the DRUG_EXPOSURE table.' as check_description
  ,'DRUG_EXPOSURE' as cdm_table_name
  ,'DRUG_EXPOSURE_END_DATETIME' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_temporal_after.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausibletemporalafter_drug_exposure_drug_exposure_end_datetime' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_TEMPORAL_AFTER
get number of records and the proportion to total number of eligible records with datetimes that do not occur on or after their corresponding datetimes
Parameters used in this template:
schema = cdm
cdmTableName = DRUG_EXPOSURE
cdmFieldName = DRUG_EXPOSURE_END_DATETIME
plausibleTemporalAfterTableName = DRUG_EXPOSURE
plausibleTemporalAfterFieldName = DRUG_EXPOSURE_START_DATETIME
**********/
SELECT 
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
    WHERE 
			CAST(cdmTable.DRUG_EXPOSURE_START_DATETIME AS DATE)
		 > CAST(cdmTable.DRUG_EXPOSURE_END_DATETIME AS DATE)
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
  ,'plausibleTemporalAfter' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a value in the DRUG_EXPOSURE_START_DATE field of the DRUG_EXPOSURE that occurs prior to the date in the BIRTH_DATETIME field of the PERSON table.' as check_description
  ,'DRUG_EXPOSURE' as cdm_table_name
  ,'DRUG_EXPOSURE_START_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_temporal_after.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausibletemporalafter_drug_exposure_drug_exposure_start_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_TEMPORAL_AFTER
get number of records and the proportion to total number of eligible records with datetimes that do not occur on or after their corresponding datetimes
Parameters used in this template:
schema = cdm
cdmTableName = DRUG_EXPOSURE
cdmFieldName = DRUG_EXPOSURE_START_DATE
plausibleTemporalAfterTableName = PERSON
plausibleTemporalAfterFieldName = BIRTH_DATETIME
**********/
SELECT 
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
				JOIN {{ ref('person') }} plausibleTable 
                    ON cdmTable.person_id = plausibleTable.person_id
    WHERE 
			COALESCE(
				CAST(plausibleTable.BIRTH_DATETIME AS DATE),
				{{ make_date('plausibleTable.year_of_birth', 6, 1) }}
			) 
		 > CAST(cdmTable.DRUG_EXPOSURE_START_DATE AS DATE)
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
  ,'plausibleTemporalAfter' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a value in the DRUG_EXPOSURE_START_DATETIME field of the DRUG_EXPOSURE that occurs prior to the date in the BIRTH_DATETIME field of the PERSON table.' as check_description
  ,'DRUG_EXPOSURE' as cdm_table_name
  ,'DRUG_EXPOSURE_START_DATETIME' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_temporal_after.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausibletemporalafter_drug_exposure_drug_exposure_start_datetime' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_TEMPORAL_AFTER
get number of records and the proportion to total number of eligible records with datetimes that do not occur on or after their corresponding datetimes
Parameters used in this template:
schema = cdm
cdmTableName = DRUG_EXPOSURE
cdmFieldName = DRUG_EXPOSURE_START_DATETIME
plausibleTemporalAfterTableName = PERSON
plausibleTemporalAfterFieldName = BIRTH_DATETIME
**********/
SELECT 
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
				JOIN {{ ref('person') }} plausibleTable 
                    ON cdmTable.person_id = plausibleTable.person_id
    WHERE 
			COALESCE(
				CAST(plausibleTable.BIRTH_DATETIME AS DATE),
				{{ make_date('plausibleTable.year_of_birth', 6, 1) }}
			) 
		 > CAST(cdmTable.DRUG_EXPOSURE_START_DATETIME AS DATE)
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
  ,'plausibleTemporalAfter' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a value in the VERBATIM_END_DATE field of the DRUG_EXPOSURE that occurs prior to the date in the DRUG_EXPOSURE_START_DATE field of the DRUG_EXPOSURE table.' as check_description
  ,'DRUG_EXPOSURE' as cdm_table_name
  ,'VERBATIM_END_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_temporal_after.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausibletemporalafter_drug_exposure_verbatim_end_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_TEMPORAL_AFTER
get number of records and the proportion to total number of eligible records with datetimes that do not occur on or after their corresponding datetimes
Parameters used in this template:
schema = cdm
cdmTableName = DRUG_EXPOSURE
cdmFieldName = VERBATIM_END_DATE
plausibleTemporalAfterTableName = DRUG_EXPOSURE
plausibleTemporalAfterFieldName = DRUG_EXPOSURE_START_DATE
**********/
SELECT 
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
    WHERE 
			CAST(cdmTable.DRUG_EXPOSURE_START_DATE AS DATE)
		 > CAST(cdmTable.VERBATIM_END_DATE AS DATE)
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
  ,'plausibleTemporalAfter' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a value in the EPISODE_END_DATE field of the EPISODE that occurs prior to the date in the EPISODE_START_DATE field of the EPISODE table.' as check_description
  ,'EPISODE' as cdm_table_name
  ,'EPISODE_END_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_temporal_after.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausibletemporalafter_episode_episode_end_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_TEMPORAL_AFTER
get number of records and the proportion to total number of eligible records with datetimes that do not occur on or after their corresponding datetimes
Parameters used in this template:
schema = cdm
cdmTableName = EPISODE
cdmFieldName = EPISODE_END_DATE
plausibleTemporalAfterTableName = EPISODE
plausibleTemporalAfterFieldName = EPISODE_START_DATE
**********/
SELECT 
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
    WHERE 
			CAST(cdmTable.EPISODE_START_DATE AS DATE)
		 > CAST(cdmTable.EPISODE_END_DATE AS DATE)
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
  ,'plausibleTemporalAfter' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a value in the EPISODE_END_DATETIME field of the EPISODE that occurs prior to the date in the EPISODE_START_DATETIME field of the EPISODE table.' as check_description
  ,'EPISODE' as cdm_table_name
  ,'EPISODE_END_DATETIME' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_temporal_after.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausibletemporalafter_episode_episode_end_datetime' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_TEMPORAL_AFTER
get number of records and the proportion to total number of eligible records with datetimes that do not occur on or after their corresponding datetimes
Parameters used in this template:
schema = cdm
cdmTableName = EPISODE
cdmFieldName = EPISODE_END_DATETIME
plausibleTemporalAfterTableName = EPISODE
plausibleTemporalAfterFieldName = EPISODE_START_DATETIME
**********/
SELECT 
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
    WHERE 
			CAST(cdmTable.EPISODE_START_DATETIME AS DATE)
		 > CAST(cdmTable.EPISODE_END_DATETIME AS DATE)
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
  ,'plausibleTemporalAfter' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a value in the EPISODE_START_DATE field of the EPISODE that occurs prior to the date in the BIRTH_DATETIME field of the PERSON table.' as check_description
  ,'EPISODE' as cdm_table_name
  ,'EPISODE_START_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_temporal_after.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausibletemporalafter_episode_episode_start_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_TEMPORAL_AFTER
get number of records and the proportion to total number of eligible records with datetimes that do not occur on or after their corresponding datetimes
Parameters used in this template:
schema = cdm
cdmTableName = EPISODE
cdmFieldName = EPISODE_START_DATE
plausibleTemporalAfterTableName = PERSON
plausibleTemporalAfterFieldName = BIRTH_DATETIME
**********/
SELECT 
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
				JOIN {{ ref('person') }} plausibleTable 
                    ON cdmTable.person_id = plausibleTable.person_id
    WHERE 
			COALESCE(
				CAST(plausibleTable.BIRTH_DATETIME AS DATE),
				{{ make_date('plausibleTable.year_of_birth', 6, 1) }}
			) 
		 > CAST(cdmTable.EPISODE_START_DATE AS DATE)
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
  ,'plausibleTemporalAfter' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a value in the EPISODE_START_DATETIME field of the EPISODE that occurs prior to the date in the BIRTH_DATETIME field of the PERSON table.' as check_description
  ,'EPISODE' as cdm_table_name
  ,'EPISODE_START_DATETIME' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_temporal_after.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausibletemporalafter_episode_episode_start_datetime' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_TEMPORAL_AFTER
get number of records and the proportion to total number of eligible records with datetimes that do not occur on or after their corresponding datetimes
Parameters used in this template:
schema = cdm
cdmTableName = EPISODE
cdmFieldName = EPISODE_START_DATETIME
plausibleTemporalAfterTableName = PERSON
plausibleTemporalAfterFieldName = BIRTH_DATETIME
**********/
SELECT 
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
				JOIN {{ ref('person') }} plausibleTable 
                    ON cdmTable.person_id = plausibleTable.person_id
    WHERE 
			COALESCE(
				CAST(plausibleTable.BIRTH_DATETIME AS DATE),
				{{ make_date('plausibleTable.year_of_birth', 6, 1) }}
			) 
		 > CAST(cdmTable.EPISODE_START_DATETIME AS DATE)
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
  ,'plausibleTemporalAfter' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a value in the MEASUREMENT_DATE field of the MEASUREMENT that occurs prior to the date in the BIRTH_DATETIME field of the PERSON table.' as check_description
  ,'MEASUREMENT' as cdm_table_name
  ,'MEASUREMENT_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_temporal_after.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausibletemporalafter_measurement_measurement_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_TEMPORAL_AFTER
get number of records and the proportion to total number of eligible records with datetimes that do not occur on or after their corresponding datetimes
Parameters used in this template:
schema = cdm
cdmTableName = MEASUREMENT
cdmFieldName = MEASUREMENT_DATE
plausibleTemporalAfterTableName = PERSON
plausibleTemporalAfterFieldName = BIRTH_DATETIME
**********/
SELECT 
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
				JOIN {{ ref('person') }} plausibleTable 
                    ON cdmTable.person_id = plausibleTable.person_id
    WHERE 
			COALESCE(
				CAST(plausibleTable.BIRTH_DATETIME AS DATE),
				{{ make_date('plausibleTable.year_of_birth', 6, 1) }}
			) 
		 > CAST(cdmTable.MEASUREMENT_DATE AS DATE)
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
  ,'plausibleTemporalAfter' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a value in the NOTE_DATE field of the NOTE that occurs prior to the date in the BIRTH_DATETIME field of the PERSON table.' as check_description
  ,'NOTE' as cdm_table_name
  ,'NOTE_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_temporal_after.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausibletemporalafter_note_note_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_TEMPORAL_AFTER
get number of records and the proportion to total number of eligible records with datetimes that do not occur on or after their corresponding datetimes
Parameters used in this template:
schema = cdm
cdmTableName = NOTE
cdmFieldName = NOTE_DATE
plausibleTemporalAfterTableName = PERSON
plausibleTemporalAfterFieldName = BIRTH_DATETIME
**********/
SELECT 
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
				JOIN {{ ref('person') }} plausibleTable 
                    ON cdmTable.person_id = plausibleTable.person_id
    WHERE 
			COALESCE(
				CAST(plausibleTable.BIRTH_DATETIME AS DATE),
				{{ make_date('plausibleTable.year_of_birth', 6, 1) }}
			) 
		 > CAST(cdmTable.NOTE_DATE AS DATE)
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
  ,'plausibleTemporalAfter' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a value in the NOTE_DATETIME field of the NOTE that occurs prior to the date in the BIRTH_DATETIME field of the PERSON table.' as check_description
  ,'NOTE' as cdm_table_name
  ,'NOTE_DATETIME' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_temporal_after.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausibletemporalafter_note_note_datetime' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_TEMPORAL_AFTER
get number of records and the proportion to total number of eligible records with datetimes that do not occur on or after their corresponding datetimes
Parameters used in this template:
schema = cdm
cdmTableName = NOTE
cdmFieldName = NOTE_DATETIME
plausibleTemporalAfterTableName = PERSON
plausibleTemporalAfterFieldName = BIRTH_DATETIME
**********/
SELECT 
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
				JOIN {{ ref('person') }} plausibleTable 
                    ON cdmTable.person_id = plausibleTable.person_id
    WHERE 
			COALESCE(
				CAST(plausibleTable.BIRTH_DATETIME AS DATE),
				{{ make_date('plausibleTable.year_of_birth', 6, 1) }}
			) 
		 > CAST(cdmTable.NOTE_DATETIME AS DATE)
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
  ,'plausibleTemporalAfter' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a value in the OBSERVATION_DATE field of the OBSERVATION that occurs prior to the date in the BIRTH_DATETIME field of the PERSON table.' as check_description
  ,'OBSERVATION' as cdm_table_name
  ,'OBSERVATION_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_temporal_after.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausibletemporalafter_observation_observation_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_TEMPORAL_AFTER
get number of records and the proportion to total number of eligible records with datetimes that do not occur on or after their corresponding datetimes
Parameters used in this template:
schema = cdm
cdmTableName = OBSERVATION
cdmFieldName = OBSERVATION_DATE
plausibleTemporalAfterTableName = PERSON
plausibleTemporalAfterFieldName = BIRTH_DATETIME
**********/
SELECT 
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
				JOIN {{ ref('person') }} plausibleTable 
                    ON cdmTable.person_id = plausibleTable.person_id
    WHERE 
			COALESCE(
				CAST(plausibleTable.BIRTH_DATETIME AS DATE),
				{{ make_date('plausibleTable.year_of_birth', 6, 1) }}
			) 
		 > CAST(cdmTable.OBSERVATION_DATE AS DATE)
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
  ,'plausibleTemporalAfter' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a value in the OBSERVATION_DATETIME field of the OBSERVATION that occurs prior to the date in the BIRTH_DATETIME field of the PERSON table.' as check_description
  ,'OBSERVATION' as cdm_table_name
  ,'OBSERVATION_DATETIME' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_temporal_after.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausibletemporalafter_observation_observation_datetime' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_TEMPORAL_AFTER
get number of records and the proportion to total number of eligible records with datetimes that do not occur on or after their corresponding datetimes
Parameters used in this template:
schema = cdm
cdmTableName = OBSERVATION
cdmFieldName = OBSERVATION_DATETIME
plausibleTemporalAfterTableName = PERSON
plausibleTemporalAfterFieldName = BIRTH_DATETIME
**********/
SELECT 
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
				JOIN {{ ref('person') }} plausibleTable 
                    ON cdmTable.person_id = plausibleTable.person_id
    WHERE 
			COALESCE(
				CAST(plausibleTable.BIRTH_DATETIME AS DATE),
				{{ make_date('plausibleTable.year_of_birth', 6, 1) }}
			) 
		 > CAST(cdmTable.OBSERVATION_DATETIME AS DATE)
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
  ,'plausibleTemporalAfter' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a value in the OBSERVATION_PERIOD_END_DATE field of the OBSERVATION_PERIOD that occurs prior to the date in the OBSERVATION_PERIOD_START_DATE field of the OBSERVATION_PERIOD table.' as check_description
  ,'OBSERVATION_PERIOD' as cdm_table_name
  ,'OBSERVATION_PERIOD_END_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_temporal_after.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausibletemporalafter_observation_period_observation_period_end_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_TEMPORAL_AFTER
get number of records and the proportion to total number of eligible records with datetimes that do not occur on or after their corresponding datetimes
Parameters used in this template:
schema = cdm
cdmTableName = OBSERVATION_PERIOD
cdmFieldName = OBSERVATION_PERIOD_END_DATE
plausibleTemporalAfterTableName = OBSERVATION_PERIOD
plausibleTemporalAfterFieldName = OBSERVATION_PERIOD_START_DATE
**********/
SELECT 
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
    WHERE 
			CAST(cdmTable.OBSERVATION_PERIOD_START_DATE AS DATE)
		 > CAST(cdmTable.OBSERVATION_PERIOD_END_DATE AS DATE)
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
  ,'plausibleTemporalAfter' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a value in the OBSERVATION_PERIOD_START_DATE field of the OBSERVATION_PERIOD that occurs prior to the date in the BIRTH_DATETIME field of the PERSON table.' as check_description
  ,'OBSERVATION_PERIOD' as cdm_table_name
  ,'OBSERVATION_PERIOD_START_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_temporal_after.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausibletemporalafter_observation_period_observation_period_start_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_TEMPORAL_AFTER
get number of records and the proportion to total number of eligible records with datetimes that do not occur on or after their corresponding datetimes
Parameters used in this template:
schema = cdm
cdmTableName = OBSERVATION_PERIOD
cdmFieldName = OBSERVATION_PERIOD_START_DATE
plausibleTemporalAfterTableName = PERSON
plausibleTemporalAfterFieldName = BIRTH_DATETIME
**********/
SELECT 
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
				JOIN {{ ref('person') }} plausibleTable 
                    ON cdmTable.person_id = plausibleTable.person_id
    WHERE 
			COALESCE(
				CAST(plausibleTable.BIRTH_DATETIME AS DATE),
				{{ make_date('plausibleTable.year_of_birth', 6, 1) }}
			) 
		 > CAST(cdmTable.OBSERVATION_PERIOD_START_DATE AS DATE)
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
  ,'plausibleTemporalAfter' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a value in the PAYER_PLAN_PERIOD_END_DATE field of the PAYER_PLAN_PERIOD that occurs prior to the date in the PAYER_PLAN_PERIOD_START_DATE field of the PAYER_PLAN_PERIOD table.' as check_description
  ,'PAYER_PLAN_PERIOD' as cdm_table_name
  ,'PAYER_PLAN_PERIOD_END_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_temporal_after.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausibletemporalafter_payer_plan_period_payer_plan_period_end_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_TEMPORAL_AFTER
get number of records and the proportion to total number of eligible records with datetimes that do not occur on or after their corresponding datetimes
Parameters used in this template:
schema = cdm
cdmTableName = PAYER_PLAN_PERIOD
cdmFieldName = PAYER_PLAN_PERIOD_END_DATE
plausibleTemporalAfterTableName = PAYER_PLAN_PERIOD
plausibleTemporalAfterFieldName = PAYER_PLAN_PERIOD_START_DATE
**********/
SELECT 
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
    WHERE 
			CAST(cdmTable.PAYER_PLAN_PERIOD_START_DATE AS DATE)
		 > CAST(cdmTable.PAYER_PLAN_PERIOD_END_DATE AS DATE)
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
  ,'plausibleTemporalAfter' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a value in the PAYER_PLAN_PERIOD_START_DATE field of the PAYER_PLAN_PERIOD that occurs prior to the date in the BIRTH_DATETIME field of the PERSON table.' as check_description
  ,'PAYER_PLAN_PERIOD' as cdm_table_name
  ,'PAYER_PLAN_PERIOD_START_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_temporal_after.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausibletemporalafter_payer_plan_period_payer_plan_period_start_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_TEMPORAL_AFTER
get number of records and the proportion to total number of eligible records with datetimes that do not occur on or after their corresponding datetimes
Parameters used in this template:
schema = cdm
cdmTableName = PAYER_PLAN_PERIOD
cdmFieldName = PAYER_PLAN_PERIOD_START_DATE
plausibleTemporalAfterTableName = PERSON
plausibleTemporalAfterFieldName = BIRTH_DATETIME
**********/
SELECT 
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
				JOIN {{ ref('person') }} plausibleTable 
                    ON cdmTable.person_id = plausibleTable.person_id
    WHERE 
			COALESCE(
				CAST(plausibleTable.BIRTH_DATETIME AS DATE),
				{{ make_date('plausibleTable.year_of_birth', 6, 1) }}
			) 
		 > CAST(cdmTable.PAYER_PLAN_PERIOD_START_DATE AS DATE)
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
  ,'plausibleTemporalAfter' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a value in the PROCEDURE_DATE field of the PROCEDURE_OCCURRENCE that occurs prior to the date in the BIRTH_DATETIME field of the PERSON table.' as check_description
  ,'PROCEDURE_OCCURRENCE' as cdm_table_name
  ,'PROCEDURE_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_temporal_after.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausibletemporalafter_procedure_occurrence_procedure_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_TEMPORAL_AFTER
get number of records and the proportion to total number of eligible records with datetimes that do not occur on or after their corresponding datetimes
Parameters used in this template:
schema = cdm
cdmTableName = PROCEDURE_OCCURRENCE
cdmFieldName = PROCEDURE_DATE
plausibleTemporalAfterTableName = PERSON
plausibleTemporalAfterFieldName = BIRTH_DATETIME
**********/
SELECT 
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
				JOIN {{ ref('person') }} plausibleTable 
                    ON cdmTable.person_id = plausibleTable.person_id
    WHERE 
			COALESCE(
				CAST(plausibleTable.BIRTH_DATETIME AS DATE),
				{{ make_date('plausibleTable.year_of_birth', 6, 1) }}
			) 
		 > CAST(cdmTable.PROCEDURE_DATE AS DATE)
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
  ,'plausibleTemporalAfter' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a value in the PROCEDURE_DATETIME field of the PROCEDURE_OCCURRENCE that occurs prior to the date in the BIRTH_DATETIME field of the PERSON table.' as check_description
  ,'PROCEDURE_OCCURRENCE' as cdm_table_name
  ,'PROCEDURE_DATETIME' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_temporal_after.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausibletemporalafter_procedure_occurrence_procedure_datetime' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_TEMPORAL_AFTER
get number of records and the proportion to total number of eligible records with datetimes that do not occur on or after their corresponding datetimes
Parameters used in this template:
schema = cdm
cdmTableName = PROCEDURE_OCCURRENCE
cdmFieldName = PROCEDURE_DATETIME
plausibleTemporalAfterTableName = PERSON
plausibleTemporalAfterFieldName = BIRTH_DATETIME
**********/
SELECT 
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
				JOIN {{ ref('person') }} plausibleTable 
                    ON cdmTable.person_id = plausibleTable.person_id
    WHERE 
			COALESCE(
				CAST(plausibleTable.BIRTH_DATETIME AS DATE),
				{{ make_date('plausibleTable.year_of_birth', 6, 1) }}
			) 
		 > CAST(cdmTable.PROCEDURE_DATETIME AS DATE)
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
  ,'plausibleTemporalAfter' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a value in the PROCEDURE_END_DATE field of the PROCEDURE_OCCURRENCE that occurs prior to the date in the PROCEDURE_DATE field of the PROCEDURE_OCCURRENCE table.' as check_description
  ,'PROCEDURE_OCCURRENCE' as cdm_table_name
  ,'PROCEDURE_END_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_temporal_after.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausibletemporalafter_procedure_occurrence_procedure_end_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_TEMPORAL_AFTER
get number of records and the proportion to total number of eligible records with datetimes that do not occur on or after their corresponding datetimes
Parameters used in this template:
schema = cdm
cdmTableName = PROCEDURE_OCCURRENCE
cdmFieldName = PROCEDURE_END_DATE
plausibleTemporalAfterTableName = PROCEDURE_OCCURRENCE
plausibleTemporalAfterFieldName = PROCEDURE_DATE
**********/
SELECT 
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
    WHERE 
			CAST(cdmTable.PROCEDURE_DATE AS DATE)
		 > CAST(cdmTable.PROCEDURE_END_DATE AS DATE)
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
  ,'plausibleTemporalAfter' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a value in the PROCEDURE_END_DATETIME field of the PROCEDURE_OCCURRENCE that occurs prior to the date in the PROCEDURE_DATETIME field of the PROCEDURE_OCCURRENCE table.' as check_description
  ,'PROCEDURE_OCCURRENCE' as cdm_table_name
  ,'PROCEDURE_END_DATETIME' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_temporal_after.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausibletemporalafter_procedure_occurrence_procedure_end_datetime' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_TEMPORAL_AFTER
get number of records and the proportion to total number of eligible records with datetimes that do not occur on or after their corresponding datetimes
Parameters used in this template:
schema = cdm
cdmTableName = PROCEDURE_OCCURRENCE
cdmFieldName = PROCEDURE_END_DATETIME
plausibleTemporalAfterTableName = PROCEDURE_OCCURRENCE
plausibleTemporalAfterFieldName = PROCEDURE_DATETIME
**********/
SELECT 
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
    WHERE 
			CAST(cdmTable.PROCEDURE_DATETIME AS DATE)
		 > CAST(cdmTable.PROCEDURE_END_DATETIME AS DATE)
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
  ,'plausibleTemporalAfter' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a value in the SPECIMEN_DATE field of the SPECIMEN that occurs prior to the date in the BIRTH_DATETIME field of the PERSON table.' as check_description
  ,'SPECIMEN' as cdm_table_name
  ,'SPECIMEN_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_temporal_after.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausibletemporalafter_specimen_specimen_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_TEMPORAL_AFTER
get number of records and the proportion to total number of eligible records with datetimes that do not occur on or after their corresponding datetimes
Parameters used in this template:
schema = cdm
cdmTableName = SPECIMEN
cdmFieldName = SPECIMEN_DATE
plausibleTemporalAfterTableName = PERSON
plausibleTemporalAfterFieldName = BIRTH_DATETIME
**********/
SELECT 
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
				JOIN {{ ref('person') }} plausibleTable 
                    ON cdmTable.person_id = plausibleTable.person_id
    WHERE 
			COALESCE(
				CAST(plausibleTable.BIRTH_DATETIME AS DATE),
				{{ make_date('plausibleTable.year_of_birth', 6, 1) }}
			) 
		 > CAST(cdmTable.SPECIMEN_DATE AS DATE)
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
  ,'plausibleTemporalAfter' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a value in the SPECIMEN_DATETIME field of the SPECIMEN that occurs prior to the date in the BIRTH_DATETIME field of the PERSON table.' as check_description
  ,'SPECIMEN' as cdm_table_name
  ,'SPECIMEN_DATETIME' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_temporal_after.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausibletemporalafter_specimen_specimen_datetime' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_TEMPORAL_AFTER
get number of records and the proportion to total number of eligible records with datetimes that do not occur on or after their corresponding datetimes
Parameters used in this template:
schema = cdm
cdmTableName = SPECIMEN
cdmFieldName = SPECIMEN_DATETIME
plausibleTemporalAfterTableName = PERSON
plausibleTemporalAfterFieldName = BIRTH_DATETIME
**********/
SELECT 
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
				JOIN {{ ref('person') }} plausibleTable 
                    ON cdmTable.person_id = plausibleTable.person_id
    WHERE 
			COALESCE(
				CAST(plausibleTable.BIRTH_DATETIME AS DATE),
				{{ make_date('plausibleTable.year_of_birth', 6, 1) }}
			) 
		 > CAST(cdmTable.SPECIMEN_DATETIME AS DATE)
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
  ,'plausibleTemporalAfter' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a value in the VISIT_DETAIL_END_DATE field of the VISIT_DETAIL that occurs prior to the date in the VISIT_DETAIL_START_DATE field of the VISIT_DETAIL table.' as check_description
  ,'VISIT_DETAIL' as cdm_table_name
  ,'VISIT_DETAIL_END_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_temporal_after.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausibletemporalafter_visit_detail_visit_detail_end_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_TEMPORAL_AFTER
get number of records and the proportion to total number of eligible records with datetimes that do not occur on or after their corresponding datetimes
Parameters used in this template:
schema = cdm
cdmTableName = VISIT_DETAIL
cdmFieldName = VISIT_DETAIL_END_DATE
plausibleTemporalAfterTableName = VISIT_DETAIL
plausibleTemporalAfterFieldName = VISIT_DETAIL_START_DATE
**********/
SELECT 
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
    WHERE 
			CAST(cdmTable.VISIT_DETAIL_START_DATE AS DATE)
		 > CAST(cdmTable.VISIT_DETAIL_END_DATE AS DATE)
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
  ,'plausibleTemporalAfter' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a value in the VISIT_DETAIL_END_DATETIME field of the VISIT_DETAIL that occurs prior to the date in the VISIT_DETAIL_START_DATETIME field of the VISIT_DETAIL table.' as check_description
  ,'VISIT_DETAIL' as cdm_table_name
  ,'VISIT_DETAIL_END_DATETIME' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_temporal_after.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausibletemporalafter_visit_detail_visit_detail_end_datetime' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_TEMPORAL_AFTER
get number of records and the proportion to total number of eligible records with datetimes that do not occur on or after their corresponding datetimes
Parameters used in this template:
schema = cdm
cdmTableName = VISIT_DETAIL
cdmFieldName = VISIT_DETAIL_END_DATETIME
plausibleTemporalAfterTableName = VISIT_DETAIL
plausibleTemporalAfterFieldName = VISIT_DETAIL_START_DATETIME
**********/
SELECT 
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
    WHERE 
			CAST(cdmTable.VISIT_DETAIL_START_DATETIME AS DATE)
		 > CAST(cdmTable.VISIT_DETAIL_END_DATETIME AS DATE)
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
  ,'plausibleTemporalAfter' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a value in the VISIT_DETAIL_START_DATE field of the VISIT_DETAIL that occurs prior to the date in the BIRTH_DATETIME field of the PERSON table.' as check_description
  ,'VISIT_DETAIL' as cdm_table_name
  ,'VISIT_DETAIL_START_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_temporal_after.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausibletemporalafter_visit_detail_visit_detail_start_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_TEMPORAL_AFTER
get number of records and the proportion to total number of eligible records with datetimes that do not occur on or after their corresponding datetimes
Parameters used in this template:
schema = cdm
cdmTableName = VISIT_DETAIL
cdmFieldName = VISIT_DETAIL_START_DATE
plausibleTemporalAfterTableName = PERSON
plausibleTemporalAfterFieldName = BIRTH_DATETIME
**********/
SELECT 
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
				JOIN {{ ref('person') }} plausibleTable 
                    ON cdmTable.person_id = plausibleTable.person_id
    WHERE 
			COALESCE(
				CAST(plausibleTable.BIRTH_DATETIME AS DATE),
				{{ make_date('plausibleTable.year_of_birth', 6, 1) }}
			) 
		 > CAST(cdmTable.VISIT_DETAIL_START_DATE AS DATE)
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
  ,'plausibleTemporalAfter' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a value in the VISIT_DETAIL_START_DATETIME field of the VISIT_DETAIL that occurs prior to the date in the BIRTH_DATETIME field of the PERSON table.' as check_description
  ,'VISIT_DETAIL' as cdm_table_name
  ,'VISIT_DETAIL_START_DATETIME' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_temporal_after.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausibletemporalafter_visit_detail_visit_detail_start_datetime' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_TEMPORAL_AFTER
get number of records and the proportion to total number of eligible records with datetimes that do not occur on or after their corresponding datetimes
Parameters used in this template:
schema = cdm
cdmTableName = VISIT_DETAIL
cdmFieldName = VISIT_DETAIL_START_DATETIME
plausibleTemporalAfterTableName = PERSON
plausibleTemporalAfterFieldName = BIRTH_DATETIME
**********/
SELECT 
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
				JOIN {{ ref('person') }} plausibleTable 
                    ON cdmTable.person_id = plausibleTable.person_id
    WHERE 
			COALESCE(
				CAST(plausibleTable.BIRTH_DATETIME AS DATE),
				{{ make_date('plausibleTable.year_of_birth', 6, 1) }}
			) 
		 > CAST(cdmTable.VISIT_DETAIL_START_DATETIME AS DATE)
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
  ,'plausibleTemporalAfter' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a value in the VISIT_END_DATE field of the VISIT_OCCURRENCE that occurs prior to the date in the VISIT_START_DATE field of the VISIT_OCCURRENCE table.' as check_description
  ,'VISIT_OCCURRENCE' as cdm_table_name
  ,'VISIT_END_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_temporal_after.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausibletemporalafter_visit_occurrence_visit_end_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_TEMPORAL_AFTER
get number of records and the proportion to total number of eligible records with datetimes that do not occur on or after their corresponding datetimes
Parameters used in this template:
schema = cdm
cdmTableName = VISIT_OCCURRENCE
cdmFieldName = VISIT_END_DATE
plausibleTemporalAfterTableName = VISIT_OCCURRENCE
plausibleTemporalAfterFieldName = VISIT_START_DATE
**********/
SELECT 
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
    WHERE 
			CAST(cdmTable.VISIT_START_DATE AS DATE)
		 > CAST(cdmTable.VISIT_END_DATE AS DATE)
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
  ,'plausibleTemporalAfter' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a value in the VISIT_END_DATETIME field of the VISIT_OCCURRENCE that occurs prior to the date in the VISIT_START_DATETIME field of the VISIT_OCCURRENCE table.' as check_description
  ,'VISIT_OCCURRENCE' as cdm_table_name
  ,'VISIT_END_DATETIME' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_temporal_after.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausibletemporalafter_visit_occurrence_visit_end_datetime' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_TEMPORAL_AFTER
get number of records and the proportion to total number of eligible records with datetimes that do not occur on or after their corresponding datetimes
Parameters used in this template:
schema = cdm
cdmTableName = VISIT_OCCURRENCE
cdmFieldName = VISIT_END_DATETIME
plausibleTemporalAfterTableName = VISIT_OCCURRENCE
plausibleTemporalAfterFieldName = VISIT_START_DATETIME
**********/
SELECT 
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
    WHERE 
			CAST(cdmTable.VISIT_START_DATETIME AS DATE)
		 > CAST(cdmTable.VISIT_END_DATETIME AS DATE)
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
  ,'plausibleTemporalAfter' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a value in the VISIT_START_DATE field of the VISIT_OCCURRENCE that occurs prior to the date in the BIRTH_DATETIME field of the PERSON table.' as check_description
  ,'VISIT_OCCURRENCE' as cdm_table_name
  ,'VISIT_START_DATE' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_temporal_after.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausibletemporalafter_visit_occurrence_visit_start_date' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_TEMPORAL_AFTER
get number of records and the proportion to total number of eligible records with datetimes that do not occur on or after their corresponding datetimes
Parameters used in this template:
schema = cdm
cdmTableName = VISIT_OCCURRENCE
cdmFieldName = VISIT_START_DATE
plausibleTemporalAfterTableName = PERSON
plausibleTemporalAfterFieldName = BIRTH_DATETIME
**********/
SELECT 
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
				JOIN {{ ref('person') }} plausibleTable 
                    ON cdmTable.person_id = plausibleTable.person_id
    WHERE 
			COALESCE(
				CAST(plausibleTable.BIRTH_DATETIME AS DATE),
				{{ make_date('plausibleTable.year_of_birth', 6, 1) }}
			) 
		 > CAST(cdmTable.VISIT_START_DATE AS DATE)
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
  ,'plausibleTemporalAfter' as check_name
  ,'FIELD' as check_level
  ,'The number and percent of records with a value in the VISIT_START_DATETIME field of the VISIT_OCCURRENCE that occurs prior to the date in the BIRTH_DATETIME field of the PERSON table.' as check_description
  ,'VISIT_OCCURRENCE' as cdm_table_name
  ,'VISIT_START_DATETIME' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'field_plausible_temporal_after.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'field_plausibletemporalafter_visit_occurrence_visit_start_datetime' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,1 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
PLAUSIBLE_TEMPORAL_AFTER
get number of records and the proportion to total number of eligible records with datetimes that do not occur on or after their corresponding datetimes
Parameters used in this template:
schema = cdm
cdmTableName = VISIT_OCCURRENCE
cdmFieldName = VISIT_START_DATETIME
plausibleTemporalAfterTableName = PERSON
plausibleTemporalAfterFieldName = BIRTH_DATETIME
**********/
SELECT 
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
				JOIN {{ ref('person') }} plausibleTable 
                    ON cdmTable.person_id = plausibleTable.person_id
    WHERE 
			COALESCE(
				CAST(plausibleTable.BIRTH_DATETIME AS DATE),
				{{ make_date('plausibleTable.year_of_birth', 6, 1) }}
			) 
		 > CAST(cdmTable.VISIT_START_DATETIME AS DATE)
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
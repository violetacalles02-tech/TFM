

/*********
SQL to insert individual DQD results directly into output table, rather than waiting until collecting all results.
Note that this  does not include information about SQL errors or performance
**********/
WITH cte_all  AS (SELECT cte.num_violated_rows
  ,cte.pct_violated_rows
  ,cte.num_denominator_rows
  , CAST('' as TEXT) as execution_time
  ,'' as query_text
  ,'measureObservationPeriodOverlap' as check_name
  ,'TABLE' as check_level
  ,'The number and percent of persons that have overlapping or back-to-back observation periods.' as check_description
  ,'OBSERVATION_PERIOD' as cdm_table_name
  ,'NA' as cdm_field_name
  ,'NA' as concept_id
  ,'NA' as unit_concept_id
  ,'table_observation_period_overlap.sql' as sql_file
  ,'Plausibility' as category
  ,'Temporal' as subcategory
  ,'Verification' as context
  ,'' as warning
  ,'' as error
  ,'table_measureobservationperiodoverlap_observation_period' as checkid
  ,0 as is_error
  ,0 as not_applicable
  ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
  ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
  ,NULL as not_applicable_reason
  ,0 as threshold_value
  ,NULL as notes_value
FROM (
  /*********
Table Level:  
MEASURE_OBSERVATION_PERIOD_OVERLAP
Determine what #/% of persons have overlapping or back-to-back observation periods
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
		COUNT(violated_rows.person_id) AS num_violated_rows
	FROM
	(
		/*violatedRowsBegin*/
		SELECT DISTINCT
			cdmTable.person_id 
		FROM {{ ref('observation_period') }} cdmTable
		JOIN {{ ref('observation_period') }} cdmTable2 
		    ON cdmTable.person_id = cdmTable2.person_id
		    AND cdmTable.observation_period_id != cdmTable2.observation_period_id
		WHERE (cdmTable.observation_period_start_date <= cdmTable2.observation_period_end_date 
		    AND cdmTable.observation_period_end_date >= cdmTable2.observation_period_start_date)
		    OR ((cdmTable.observation_period_end_date + 1*INTERVAL'1 day') = cdmTable2.observation_period_start_date)
		    OR ((cdmTable2.observation_period_end_date + 1*INTERVAL'1 day') = cdmTable.observation_period_start_date)
		/*violatedRowsEnd*/
	) violated_rows
) violated_row_count,
( 
	SELECT 
		COUNT(DISTINCT cdmTable.person_id) AS num_rows
	FROM {{ ref('observation_period') }} cdmTable
) denominator
) cte
)
SELECT * FROM cte_all
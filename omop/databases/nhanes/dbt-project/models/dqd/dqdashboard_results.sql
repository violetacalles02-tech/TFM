{{
  config(
    materialized = 'table',
    )
}}

SELECT * FROM {{ ref('concept_plausiblegender') }}
UNION ALL
SELECT * FROM {{ ref('concept_plausiblegenderusedescendants') }}
UNION ALL
SELECT * FROM {{ ref('concept_plausibleunitconceptids') }}
UNION ALL
SELECT * FROM {{ ref('field_cdmdatatype') }}
UNION ALL
SELECT * FROM {{ ref('field_cdmfield') }}
UNION ALL
SELECT * FROM {{ ref('field_fkclass') }}
UNION ALL
SELECT * FROM {{ ref('field_fkdomain') }}
UNION ALL
SELECT * FROM {{ ref('field_isforeignkey') }}
UNION ALL
SELECT * FROM {{ ref('field_isprimarykey') }}
UNION ALL
SELECT * FROM {{ ref('field_isrequired') }}
UNION ALL
SELECT * FROM {{ ref('field_isstandardvalidconcept') }}
UNION ALL
SELECT * FROM {{ ref('field_measurevaluecompleteness') }}
UNION ALL
SELECT * FROM {{ ref('field_plausibleafterbirth') }}
UNION ALL
SELECT * FROM {{ ref('field_plausiblebeforedeath') }}
UNION ALL
SELECT * FROM {{ ref('field_plausibleduringlife') }}
UNION ALL
SELECT * FROM {{ ref('field_plausiblestartbeforeend') }}
UNION ALL
SELECT * FROM {{ ref('field_plausibletemporalafter') }}
UNION ALL
SELECT * FROM {{ ref('field_plausiblevaluehigh') }}
UNION ALL
SELECT * FROM {{ ref('field_plausiblevaluelow') }}
UNION ALL
SELECT * FROM {{ ref('field_sourceconceptrecordcompleteness') }}
UNION ALL
SELECT * FROM {{ ref('field_sourcevaluecompleteness') }}
UNION ALL
SELECT * FROM {{ ref('field_standardconceptrecordcompleteness') }}
UNION ALL
SELECT * FROM {{ ref('field_withinvisitdates') }}
UNION ALL
SELECT * FROM {{ ref('table_cdmtable') }}
UNION ALL
SELECT * FROM {{ ref('table_measureconditioneracompleteness') }}
UNION ALL
SELECT * FROM {{ ref('table_measureobservationperiodoverlap') }}
UNION ALL
SELECT * FROM {{ ref('table_measurepersoncompleteness') }}
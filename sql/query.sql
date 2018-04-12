DROP FUNCTION get_cmc_metrics(date);

CREATE OR REPLACE FUNCTION get_cmc_metrics (
	IN start_date date)
RETURNS TABLE(
	RunDate date, Service text, Metric text, Count bigint) as $BODY$
BEGIN 
RETURN QUERY
SELECT start_date as RunDate,
	'CMC'::text as Service, 
	'Mediation Requested Count'::text as Metric,
	Count(*)
from case_data cd
where
	(cd.jurisdiction='CMC')  AND
	(cd.data->'responseData' ? 'freeMediationOption') AND
	(cd.data->'responseData'->>'freeMediationOption' = 'YES') AND
	((cd.data->>'submittedOn')::timestamp > start_date::timestamp) AND
	((cd.data->>'submittedOn')::timestamp < (start_date + interval '1 day')::timestamp);

RETURN QUERY
SELECT start_date as RunDate,'CMC'::text as Service, 'Claim Submitted Count'::text as Metric,COUNT(*)
from case_data cd
where 
	(cd.jurisdiction='CMC') AND 
	((cd.data->>'submittedOn')::timestamp > start_date::timestamp) AND
	((cd.data->>'submittedOn')::timestamp < (start_date + interval '1 day')::timestamp);

RETURN QUERY
SELECT start_date as RunDate,'CMC'::text as Service, 'Claim Responded Count'::text as Metric,COUNT(*)
from case_data cd
where 
	(cd.jurisdiction='CMC') AND 
	(cd.data ? 'respondedAt') AND 
	((cd.data->>'submittedOn')::timestamp > start_date::timestamp) AND
	((cd.data->>'submittedOn')::timestamp < (start_date + interval '1 day')::timestamp);
END;
$BODY$
LANGUAGE plpgsql VOLATILE
COST 100;

SELECT * from get_cmc_metrics('2018-03-03'::date);

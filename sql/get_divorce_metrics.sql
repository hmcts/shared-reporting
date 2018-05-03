CREATE OR REPLACE FUNCTION get_divorce_metrics (IN start_date date)
RETURNS TABLE(RunDate date, Service text, Metric text, Count bigint) AS $BODY$
BEGIN
RETURN QUERY
	SELECT 
		start_date as RunDate,
		'Divorce'::text as Service,
		('Case Status '::text) || (cd.state::text) as Metric,
		count(*) as Count
	from case_data as cd
	where 
		jurisdiction='DIVORCE' AND
		(created_date::timestamp >= start_date::timestamp) AND
		(created_date::timestamp < (start_date + interval '1 day')::timestamp)
	group by 
		cd.state;
RETURN QUERY
	SELECT 
		start_date as RunDate,
		'Divorce'::text as Service,
		('Contact Details Status '::text) || (data->>'D8PetitionerContactDetailsConfidential'::text) as Metric,
		count(*) as Count
	from case_data as cd
	where 
		jurisdiction='DIVORCE' AND
		(created_date::timestamp >= start_date::timestamp) AND
		(created_date::timestamp < (start_date + interval '1 day')::timestamp)
	group by 
		data->>'D8PetitionerContactDetailsConfidential';
END;
$BODY$
LANGUAGE plpgsql VOLATILE
COST 100;

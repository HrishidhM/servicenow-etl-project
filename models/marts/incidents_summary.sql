WITH f AS (
    SELECT *
    FROM {{ ref('fact_incidents') }}
)

SELECT
    COUNT(*) AS total_tickets,
    COUNT(*) FILTER (WHERE sla_breached = 1) AS total_sla_breaches,
    AVG(mttr_hours) AS avg_mttr_hours,
    COUNT(*) FILTER (WHERE inc_priority = '1 - Critical') AS critical_count,
    COUNT(*) FILTER (WHERE inc_priority = '2 - High') AS high_count,
    COUNT(*) FILTER (WHERE inc_priority = '3 - Moderate') AS moderate_count,
    COUNT(*) FILTER (WHERE inc_priority = '4 - Low') AS low_count
FROM f

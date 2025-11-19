WITH s AS (
    SELECT *
    FROM {{ ref('stg_incidents') }}
)

SELECT
    inc_number,
    inc_priority,
    inc_category,
    inc_business_service,
    inc_assigned_to,
    inc_assignment_group,
    inc_state,
    inc_caller_id,
    inc_cmdb_ci,
    inc_short_description,
    inc_close_code,
    inc_close_notes,

    sys_created_on,
    resolved_at,
    sla_due,

    -- MTTR in hours
    EXTRACT(EPOCH FROM (resolved_at - sys_created_on)) / 3600 AS mttr_hours,

    -- SLA Breach flag
    CASE 
        WHEN resolved_at > sla_due THEN 1
        ELSE 0
    END AS sla_breached,

    -- Aging bucket based on created date
    CASE 
        WHEN NOW() - sys_created_on < INTERVAL '1 day' THEN '0-1 day'
        WHEN NOW() - sys_created_on < INTERVAL '3 days' THEN '1-3 days'
        WHEN NOW() - sys_created_on < INTERVAL '7 days' THEN '3-7 days'
        ELSE '7+ days'
    END AS ticket_age_bucket

FROM s

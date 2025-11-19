WITH source AS (
    SELECT *
    FROM {{ source('servicenow', 'incidents_raw') }}
),

cleaned AS (
    SELECT DISTINCT     -- <-- REMOVE DUPLICATES
        inc_business_service,
        inc_category,
        inc_number,
        inc_priority,

        NULLIF(inc_sla_due, '')::timestamp       AS sla_due,
        NULLIF(inc_sys_created_on, '')::timestamp AS sys_created_on,
        NULLIF(inc_resolved_at, '')::timestamp    AS resolved_at,

        inc_assigned_to,
        inc_state,
        inc_cmdb_ci,
        inc_caller_id,
        inc_short_description,
        inc_assignment_group,
        inc_close_code,
        inc_close_notes
    FROM source
)

SELECT * FROM cleaned

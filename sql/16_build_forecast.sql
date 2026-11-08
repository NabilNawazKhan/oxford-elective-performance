USE RTT;
DROP TABLE IF EXISTS dbo.oxford_forecast;

WITH flows AS (            -- 1. monthly capacity and waiting list for the trust
    SELECT [month],
        SUM(CASE WHEN rtt_part IN ('Part_1A', 'Part_1B') THEN total_all END) AS capacity,
        SUM(CASE WHEN rtt_part = 'Part_2' THEN total_all END) AS waiting_list
    FROM dbo.oxford_specialty_month
    WHERE is_total = 1
    GROUP BY [month]
),
changes AS (               -- 2. month-on-month change in the list
    SELECT [month], capacity, waiting_list,
        waiting_list - LAG(waiting_list) OVER (ORDER BY [month]) AS actual_change
    FROM flows
),
params AS (                -- 3. the numbers the forecast is built from
    SELECT
        (SELECT waiting_list FROM changes WHERE [month] = '2026-08-01') AS last_list,
        (SELECT AVG(CAST(actual_change AS DECIMAL(12,1))) FROM changes WHERE [month] BETWEEN '2026-03-01' AND '2026-08-01') AS avg6,
        (SELECT AVG(CAST(actual_change AS DECIMAL(12,1))) FROM changes WHERE [month] BETWEEN '2026-06-01' AND '2026-08-01') AS avg3,
        (SELECT AVG(CAST(capacity AS DECIMAL(12,1)))      FROM changes WHERE [month] BETWEEN '2026-03-01' AND '2026-08-01') AS avgcap6
),
future AS (                -- 4. months 0 to 12 ahead (0 = Aug 2026, so the lines join up)
    SELECT n FROM (VALUES (0),(1),(2),(3),(4),(5),(6),(7),(8),(9),(10),(11),(12)) AS v(n)
)
-- 5. actual months, then forecast months, stacked into one table
SELECT [month],
       CAST(waiting_list AS DECIMAL(12,0)) AS actual,
       CAST(NULL AS DECIMAL(12,0)) AS forecast_6m,
       CAST(NULL AS DECIMAL(12,0)) AS forecast_3m,
       CAST(NULL AS DECIMAL(12,0)) AS forecast_cap10
INTO dbo.oxford_forecast
FROM changes
UNION ALL
SELECT DATEADD(month, f.n, CAST('2026-08-01' AS date)),
       NULL,
       ROUND(p.last_list + f.n * p.avg6, 0),
       ROUND(p.last_list + f.n * p.avg3, 0),
       ROUND(p.last_list + f.n * (p.avg6 - 0.10 * p.avgcap6), 0)
FROM future f CROSS JOIN params p;
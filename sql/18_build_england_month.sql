USE RTT;
DROP TABLE IF EXISTS dbo.england_month;
WITH oxford AS (
    SELECT
        CONVERT(date, '1 ' + REPLACE(REPLACE([Period], 'RTT-', ''), '-', ' ')) AS [month],
        ISNULL(TRY_CAST([Gt 00 To 01 Weeks SUM 1] AS BIGINT), 0) + ISNULL(TRY_CAST([Gt 01 To 02 Weeks SUM 1] AS BIGINT), 0) + ISNULL(TRY_CAST([Gt 02 To 03 Weeks SUM 1] AS BIGINT), 0) + ISNULL(TRY_CAST([Gt 03 To 04 Weeks SUM 1] AS BIGINT), 0) + ISNULL(TRY_CAST([Gt 04 To 05 Weeks SUM 1] AS BIGINT), 0) + ISNULL(TRY_CAST([Gt 05 To 06 Weeks SUM 1] AS BIGINT), 0) + ISNULL(TRY_CAST([Gt 06 To 07 Weeks SUM 1] AS BIGINT), 0) + ISNULL(TRY_CAST([Gt 07 To 08 Weeks SUM 1] AS BIGINT), 0) + ISNULL(TRY_CAST([Gt 08 To 09 Weeks SUM 1] AS BIGINT), 0) + ISNULL(TRY_CAST([Gt 09 To 10 Weeks SUM 1] AS BIGINT), 0) + ISNULL(TRY_CAST([Gt 10 To 11 Weeks SUM 1] AS BIGINT), 0) + ISNULL(TRY_CAST([Gt 11 To 12 Weeks SUM 1] AS BIGINT), 0) + ISNULL(TRY_CAST([Gt 12 To 13 Weeks SUM 1] AS BIGINT), 0) + ISNULL(TRY_CAST([Gt 13 To 14 Weeks SUM 1] AS BIGINT), 0) + ISNULL(TRY_CAST([Gt 14 To 15 Weeks SUM 1] AS BIGINT), 0) + ISNULL(TRY_CAST([Gt 15 To 16 Weeks SUM 1] AS BIGINT), 0) + ISNULL(TRY_CAST([Gt 16 To 17 Weeks SUM 1] AS BIGINT), 0) + ISNULL(TRY_CAST([Gt 17 To 18 Weeks SUM 1] AS BIGINT), 0) AS within_18,
        TRY_CAST([Total All] AS BIGINT) AS total_all
    FROM dbo.rtt_raw
        WHERE [Commissioner Org Code] <> 'NONC'
      AND [RTT Part Type] = 'Part_2'
      AND [Treatment Function Code] = 'C_999'
)
SELECT
    [month],
    SUM(total_all) AS waiting_list,
    SUM(within_18) AS within_18,
    CAST(100.0 * SUM(within_18) / SUM(total_all) AS DECIMAL(5,1)) AS pct_within_18
    INTO dbo.england_month
FROM oxford
GROUP BY [month]
ORDER BY [month];
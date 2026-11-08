use RTT;
select column_id, name
from sys.columns
where object_id = OBJECT_ID('dbo.rtt_raw')
order by column_id

USE RTT;
SELECT STRING_AGG(CAST('ISNULL(TRY_CAST(' + QUOTENAME(name) + ' AS BIGINT), 0)' AS NVARCHAR(MAX)), ' + ')
       WITHIN GROUP (ORDER BY column_id) AS within_18_expr
FROM sys.columns
WHERE object_id = OBJECT_ID('dbo.rtt_raw')
  AND column_id BETWEEN 14 AND 31;

SELECT
  STRING_AGG(CASE WHEN column_id BETWEEN 14 AND 31  THEN CAST('ISNULL(TRY_CAST(' + QUOTENAME(name) + ' AS BIGINT), 0)' AS NVARCHAR(MAX)) END, ' + ') WITHIN GROUP (ORDER BY column_id) AS within_18_expr,
  STRING_AGG(CASE WHEN column_id BETWEEN 66 AND 118 THEN CAST('ISNULL(TRY_CAST(' + QUOTENAME(name) + ' AS BIGINT), 0)' AS NVARCHAR(MAX)) END, ' + ') WITHIN GROUP (ORDER BY column_id) AS over_52_expr,
  STRING_AGG(CASE WHEN column_id BETWEEN 79 AND 118 THEN CAST('ISNULL(TRY_CAST(' + QUOTENAME(name) + ' AS BIGINT), 0)' AS NVARCHAR(MAX)) END, ' + ') WITHIN GROUP (ORDER BY column_id) AS over_65_expr,
  STRING_AGG(CASE WHEN column_id BETWEEN 14 AND 118 THEN CAST('ISNULL(TRY_CAST(' + QUOTENAME(name) + ' AS BIGINT), 0)' AS NVARCHAR(MAX)) END, ' + ') WITHIN GROUP (ORDER BY column_id) AS band_total_expr
FROM sys.columns
WHERE object_id = OBJECT_ID('dbo.rtt_raw');
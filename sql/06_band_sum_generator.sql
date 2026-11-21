-- 06_band_sum_generator.sql
-- Lists the column order in dbo.rtt_raw and generates the week-band sums
-- (within 18 weeks, over 52, over 65, all bands) from sys.columns instead of
-- typing 105 column names. Output used in scripts 07-09 and 18;
-- script 10 builds the same sums dynamically.

USE RTT;

SELECT column_id, name
FROM sys.columns
WHERE object_id = OBJECT_ID('dbo.rtt_raw')
ORDER BY column_id;

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

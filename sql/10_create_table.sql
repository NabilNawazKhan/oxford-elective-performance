USE RTT;

-- 1. Build the four band sums from the column list (no typing or pasting needed)
DECLARE @w18 NVARCHAR(MAX), @o52 NVARCHAR(MAX), @o65 NVARCHAR(MAX), @bt NVARCHAR(MAX), @sql NVARCHAR(MAX);

SELECT
  @w18 = STRING_AGG(CASE WHEN column_id BETWEEN 14 AND 31  THEN CAST('ISNULL(TRY_CAST(' + QUOTENAME(name) + ' AS BIGINT), 0)' AS NVARCHAR(MAX)) END, ' + ') WITHIN GROUP (ORDER BY column_id),
  @o52 = STRING_AGG(CASE WHEN column_id BETWEEN 66 AND 118 THEN CAST('ISNULL(TRY_CAST(' + QUOTENAME(name) + ' AS BIGINT), 0)' AS NVARCHAR(MAX)) END, ' + ') WITHIN GROUP (ORDER BY column_id),
  @o65 = STRING_AGG(CASE WHEN column_id BETWEEN 79 AND 118 THEN CAST('ISNULL(TRY_CAST(' + QUOTENAME(name) + ' AS BIGINT), 0)' AS NVARCHAR(MAX)) END, ' + ') WITHIN GROUP (ORDER BY column_id),
  @bt  = STRING_AGG(CASE WHEN column_id BETWEEN 14 AND 118 THEN CAST('ISNULL(TRY_CAST(' + QUOTENAME(name) + ' AS BIGINT), 0)' AS NVARCHAR(MAX)) END, ' + ') WITHIN GROUP (ORDER BY column_id)
FROM sys.columns
WHERE object_id = OBJECT_ID('dbo.rtt_raw');

-- 2. Write the CREATE TABLE query with those sums inside it
SET @sql = N'
DROP TABLE IF EXISTS dbo.oxford_specialty_month;
SELECT
    CONVERT(date, ''1 '' + REPLACE(REPLACE([Period], ''RTT-'', ''''), ''-'', '' '')) AS [month],
    [Treatment Function Code] AS specialty_code,
    [Treatment Function Name] AS specialty_name,
    [RTT Part Type]           AS rtt_part,
    CASE WHEN [Treatment Function Code] = ''C_999'' THEN 1 ELSE 0 END AS is_total,
    SUM(TRY_CAST([Total All] AS BIGINT)) AS total_all,
    SUM(TRY_CAST([Patients with unknown clock start date] AS BIGINT)) AS unknown_start,
    SUM(' + @w18 + N') AS within_18,
    SUM(' + @o52 + N') AS over_52,
    SUM(' + @o65 + N') AS over_65,
    SUM(' + @bt  + N') AS band_total
INTO dbo.oxford_specialty_month
FROM dbo.rtt_raw
WHERE [Provider Org Code] = ''RTH'' AND [Commissioner Org Code] <> ''NONC''
GROUP BY [Period], [Treatment Function Code], [Treatment Function Name], [RTT Part Type];';

-- 3. Run it
EXEC sp_executesql @sql;
-- 03_load_checks.sql
-- Checks after loading: total rows, rows by RTT part, Oxford's (RTH) rows and
-- commissioners, and rows per month (compare with the cleaning log).

USE RTT;

SELECT COUNT(*) AS n_rows
FROM dbo.rtt_raw;

SELECT [RTT Part Type], [RTT Part Description], COUNT(*) AS n_rows
FROM dbo.rtt_raw
GROUP BY [RTT Part Type], [RTT Part Description]
ORDER BY [RTT Part Type];

SELECT [Provider Org Name],
       COUNT(*) AS n_rows,
       COUNT(DISTINCT [Commissioner Org Code]) AS n_commissioners
FROM dbo.rtt_raw
WHERE [Provider Org Code] = 'RTH'
GROUP BY [Provider Org Name];

SELECT [Period], COUNT(*) AS n_rows
FROM dbo.rtt_raw
GROUP BY [Period]
ORDER BY [Period];

USE RTT;
SELECT [month], total_all, band_total, unknown_start,
       band_total + ISNULL(unknown_start, 0) AS rebuilt_total,
       total_all - (band_total + ISNULL(unknown_start, 0)) AS difference
FROM dbo.oxford_specialty_month
WHERE is_total = 1 AND rtt_part = 'Part_2'
ORDER BY [month];

USE RTT;
SELECT SUM(TRY_CAST([Total All] AS BIGINT)) AS nonc_waiting
FROM dbo.rtt_raw
WHERE [Provider Org Code] = 'RTH'
  AND [RTT Part Type] = 'Part_2'
  AND [Treatment Function Code] = 'C_999'
  AND [Period] = 'RTT-August-2026'
  AND [Commissioner Org Code] = 'NONC';
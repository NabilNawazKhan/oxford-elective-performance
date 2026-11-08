USE RTT;
SELECT specialty_code, specialty_name, total_all, over_52, over_65,
       CAST(100.0 * within_18 / NULLIF(total_all, 0) AS DECIMAL(5,1)) AS pct_within_18
FROM dbo.oxford_specialty_month
WHERE [month] = '2026-08-01'
  AND rtt_part = 'Part_2'
  AND is_total = 0
ORDER BY over_52 DESC;
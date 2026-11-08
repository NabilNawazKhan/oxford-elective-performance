USE RTT;
SELECT [month], total_all, within_18,
       CAST(100.0 * within_18 / total_all AS DECIMAL(5,1)) AS pct_within_18,
       over_52
FROM dbo.oxford_specialty_month
WHERE is_total = 1 AND rtt_part = 'Part_2'
ORDER BY [month];
USE RTT;
SELECT specialty_name,
    SUM(CASE WHEN [month] = '2025-09-01' THEN over_52 END) AS over52_sep25,
    SUM(CASE WHEN [month] = '2026-08-01' THEN over_52 END) AS over52_aug26,
    SUM(CASE WHEN [month] = '2026-08-01' THEN over_52 END)
  - SUM(CASE WHEN [month] = '2025-09-01' THEN over_52 END) AS change_over52,
    CAST(100.0 * SUM(CASE WHEN [month] = '2025-09-01' THEN within_18 END)
         / NULLIF(SUM(CASE WHEN [month] = '2025-09-01' THEN total_all END), 0) AS DECIMAL(5,1)) AS pct18_sep25,
    CAST(100.0 * SUM(CASE WHEN [month] = '2026-08-01' THEN within_18 END)
         / NULLIF(SUM(CASE WHEN [month] = '2026-08-01' THEN total_all END), 0) AS DECIMAL(5,1)) AS pct18_aug26
FROM dbo.oxford_specialty_month
WHERE rtt_part = 'Part_2' AND is_total = 0
GROUP BY specialty_name
ORDER BY over52_aug26 DESC;
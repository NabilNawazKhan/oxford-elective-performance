USE RTT;
SELECT rtt_part,
       SUM(total_all)     AS total_all,
       SUM(band_total)    AS band_total,
       SUM(unknown_start) AS unknown_start
FROM dbo.oxford_specialty_month
WHERE is_total = 1 AND [month] = '2026-08-01'
GROUP BY rtt_part
ORDER BY rtt_part;
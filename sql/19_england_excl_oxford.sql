USE RTT;
SELECT e.[month],
       CAST(100.0 * e.within_18 / e.waiting_list AS DECIMAL(5,1)) AS england_pct,
       CAST(100.0 * (e.within_18 - o.within_18)
            / (e.waiting_list - o.total_all) AS DECIMAL(5,1)) AS england_excl_oxford_pct
FROM dbo.england_month e
JOIN dbo.oxford_specialty_month o
  ON o.[month] = e.[month] AND o.is_total = 1 AND o.rtt_part = 'Part_2'
ORDER BY e.[month];
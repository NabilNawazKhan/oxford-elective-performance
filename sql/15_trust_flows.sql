USE RTT;
WITH flows AS (
    SELECT [month],
        SUM(CASE WHEN rtt_part = 'Part_3' THEN total_all END) AS demand,
        SUM(CASE WHEN rtt_part IN ('Part_1A', 'Part_1B') THEN total_all END) AS capacity,
        SUM(CASE WHEN rtt_part = 'Part_2' THEN total_all END) AS waiting_list
    FROM dbo.oxford_specialty_month
    WHERE is_total = 1
    GROUP BY [month]
)
SELECT [month], demand, capacity,
       demand - capacity AS net_flow,
       waiting_list,
       waiting_list - LAG(waiting_list) OVER (ORDER BY [month]) AS actual_change,
       LAG(waiting_list) OVER (ORDER BY [month]) + demand - capacity - waiting_list AS unreported_removals
FROM flows
ORDER BY [month];
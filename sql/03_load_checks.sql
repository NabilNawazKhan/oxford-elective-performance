USE RTT;
Select COUNT(*) as n_rows
from dbo.rtt_raw;

select [RTT Part Type],[RTT Part Description], count(*) as n_rows
from dbo.rtt_raw
group by [RTT Part Type],[RTT Part Description]
order by [RTT Part Type];

Select [Provider Org Name],
count(*) as n_rows,
count(distinct[Commissioner Org Code]) as n_commissioners
from dbo.rtt_raw
where [Provider Org Code] = 'RTH'
group by [Provider Org Name];

USE RTT;
SELECT [Period], COUNT(*) AS n_rows
FROM dbo.rtt_raw
GROUP BY [Period]
ORDER BY [Period];


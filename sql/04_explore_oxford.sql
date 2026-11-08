Use RTT;
select top 5 *
from dbo.rtt_raw
where [Provider Org Code]='RTH'
and [RTT Part Type]='part_2';
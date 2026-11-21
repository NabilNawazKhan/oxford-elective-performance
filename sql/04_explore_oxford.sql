-- 04_explore_oxford.sql
-- Exploratory: a first look at Oxford's waiting-list rows (RTH, Part_2).

USE RTT;
SELECT TOP 5 *
FROM dbo.rtt_raw
WHERE [Provider Org Code] = 'RTH'
  AND [RTT Part Type] = 'part_2';

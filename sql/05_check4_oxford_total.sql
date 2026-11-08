USE RTT;
SELECT
    COUNT(*)                              AS n_rows,
    SUM(TRY_CAST([Total] AS BIGINT))      AS sum_total,
    SUM(TRY_CAST([Total All] AS BIGINT))  AS sum_total_all
FROM dbo.rtt_raw
WHERE [Provider Org Code] = 'RTH'
  AND [RTT Part Type] = 'Part_2'
  AND [Treatment Function Code] = 'C_999';
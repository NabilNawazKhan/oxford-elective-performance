# Cleaning and validation log

| Date | Issue found | How it was found | Resolution | Rows affected |
|---|---|---|---|---|
| 29 Oct 2026 | `BULK INSERT` could not open the file (OS error 3, path not found) | "Copy as path" showed the CSV was still in a Downloads subfolder created by Extract All | Created `C:\RTTdata\raw`, moved the CSV there, and reloaded: 177,770 rows | 0 (no data changed) |
| 31 Oct 2026 | The `Total` column is blank on Oxford's waiting-list rows (`Part_2`, `C_999`) | `SUM` of `Total` returned NULL, while `SUM` of `Total All` returned 89,940 | Used `Total All` for waiting-list totals | 106 Oxford rows checked |
| 3 Nov 2026 | England July 2026: 65.3% within 18 weeks vs the official headline of 65.4% | Compared `09_england_trend.sql` with the July 2026 press notice | The press notice says Sheffield Teaching Hospitals (RHQ), Torbay and South Devon (RA9) and University Hospitals Plymouth (RK9) did not submit for July. The headline adds estimates for missing trusts; this analysis uses submitted data only. The press notice's Table 1 ("not including estimates") shows 65.3%, the same figure | 0 (no data changed; difference explained) |
| 3 Nov 2026 | England's waiting-list **size** is not like-for-like across months, because different trusts are missing in different months | Followed up the July check: a −1.9% list change compared a different set of trusts at each end | Used NHS England's official change (−0.5%, Aug 2025 → Aug 2026, including estimates) for England's list size. England % within 18 weeks is barely affected by missing trusts, so it is used as calculated | 0 (interpretation changed, not data) |
| 3 Nov 2026 | `Patients with unknown clock start date` is blank on Oxford's waiting-list rows, so `band_total + unknown_start` returned NULL | Check in `11_check_clean_table.sql` | Used `ISNULL(unknown_start, 0)`. Result: `Total All` = sum of all 105 bands, difference 0 in all 12 months | 12 months checked |
| 4 Nov 2026 | Oxford's August 2026 total (89,940) was 61 higher than NHS England's official *Incomplete Provider Aug26* file (89,879), with small differences across many specialties | Compared with the official file, then tested a hypothesis: Oxford's non-English-commissioner (`NONC`) waiting list in August 2026 = 61 | Rebuilt `oxford_specialty_month` with `AND [Commissioner Org Code] <> 'NONC'`, the same rule as the England figures. Now matches the official file exactly (89,879 / 55,907 / 62.2% / 1,516). Percentages unchanged; counts down by about 40–70 a month | 1,390 rows rebuilt |
| 6 Nov 2026 | Specialties with no pathways in one of the two months compared (Mental Health, Cardiothoracic) showed false changes of about ±100 points | Reviewing the Power BI specialty table | DAX measure returns blank when either month is missing (`ISBLANK` guard) | 2 specialties |
| 7 Nov 2026 | England figures include Oxford itself | Review of the comparison wording | Calculated England excluding Oxford (`19_england_excl_oxford.sql`): differs from England by at most 0.1 points in any month; gap vs the rest of England 2.1 → 3.0 points. Wording changed to "England average" | 0 (confirmed) |

## Files loaded

Revised versions were used where NHS England had published them.

| File | Month | Rows loaded |
|---|---|---|
| 20250930-RTT-September-2025-full-extract-revised.csv | Sep 2025 (revised) | 184,484 |
| 20251031-RTT-October-2025-full-extract.csv | Oct 2025 | 185,742 |
| 20251130-RTT-November-2025-full-extract.csv | Nov 2025 | 180,291 |
| 20251231-RTT-December-2025-full-extract-revised.csv | Dec 2025 (revised) | 179,823 |
| 20260131-RTT-January-2026-full-extract.csv | Jan 2026 | 183,417 |
| 20260228-RTT-February-2026-full-extract.csv | Feb 2026 | 181,233 |
| 20260331-RTT-March-2026-full-extract-revised.csv | Mar 2026 (revised) | 184,184 |
| 20260430-RTT-April-2026-full-extract.csv | Apr 2026 | 180,781 |
| 20260531-RTT-May-2026-full-extract.csv | May 2026 | 178,171 |
| 20260630-RTT-June-2026-full-extract.csv | Jun 2026 | 182,411 |
| 20260731-RTT-July-2026-full-extract.csv | Jul 2026 | 182,372 |
| 20260831-RTT-August-2026-full-extract.csv | Aug 2026 | 177,770 |
| **Total** | **12 months** | **2,180,679** |

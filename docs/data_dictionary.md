# Data dictionary

Source: NHS England *Consultant-led Referral to Treatment Waiting Times*, monthly "Full CSV data file" extracts, September 2025 to August 2026. Each file has 121 columns: 13 identifier columns, 105 weekly waiting-time bands and 3 total columns. Meanings follow NHS England's RTT statistics user guidance and recording and reporting guidance.

One row = one **provider** × one **commissioner** × one **specialty** × one **RTT part**, for one month.

## Source columns

| Column or group | Example | Meaning |
|---|---|---|
| Period | `RTT-August-2026` | The month the data covers. Pathways still waiting are counted at the end of the month; completed and new pathways are counted during the month. Converted to a date for trends. |
| Provider Org Code / Name | `RTH` / OXFORD UNIVERSITY HOSPITALS NHS FOUNDATION TRUST | The organisation that provides the treatment and submits the data. |
| Commissioner Org Code / Name | 108 commissioners for Oxford in Aug 2026 | The NHS body responsible for funding the patient's care. Each trust's figures are split by commissioner, so trust totals are summed across commissioners. `NONC` = non-English commissioner, excluded from official England and provider figures. |
| RTT Part Type / Description | `Part_2` / Incomplete Pathways | The kind of count. `Part_2` = still waiting (the waiting list). `Part_1A` / `Part_1B` = completed this month (admitted / non-admitted). `Part_3` = new RTT periods (clock starts). `Part_2A` = incomplete with a decision to admit: a subset of `Part_2`, never added to it. |
| Treatment Function Code / Name | `C_999` / Total | The specialty. High-volume specialties have their own code (`C_xxx`); the rest are grouped into "Other" categories (`X0x` codes). `C_999` "Total" is a pre-calculated total of all specialties: used alone for trust totals, never added to specialty rows. |
| Gt 00 To 01 Weeks SUM 1 … Gt 104 Weeks SUM 1 | 105 columns | Pathways in each one-week band of waiting ("0 to 1 weeks" = 0–7 days, "1 to 2 weeks" = 8–14 days, and so on). For pathways still waiting, this is how long they have waited so far. Within 18 weeks = the first 18 bands; 52+ weeks = the 53 bands from 52–53 up to over 104. |
| Total | blank (Oxford, `Part_2`, `C_999`) | Not populated on waiting-list rows in these files, so not used for them. |
| Patients with unknown clock start date | blank (Oxford, `Part_2`) | Pathways with no recorded start date. Treated as 0. |
| Total All | 89,940 (Oxford, `Part_2`, `C_999`, Aug 2026, all commissioners) | Total pathways in the row. Excluding `NONC`, Oxford's total is 89,879, the official figure. For Oxford's waiting list it equals the sum of the 105 bands in all 12 months. |

Counts are **pathways, not people**: some patients wait on more than one pathway.

## Clean table: `dbo.oxford_specialty_month`

Oxford (`RTH`) only, non-English commissioners excluded. 1,390 rows.

| Column | Meaning |
|---|---|
| month | First day of the month (date) |
| specialty_code, specialty_name | Treatment function |
| rtt_part | `Part_1A`, `Part_1B`, `Part_2`, `Part_2A` or `Part_3` |
| is_total | 1 for the `C_999` total row, 0 for specialties |
| total_all | Sum of `Total All` |
| unknown_start | Sum of `Patients with unknown clock start date` |
| within_18 | Sum of the first 18 week bands |
| over_52 | Sum of the bands from 52–53 weeks upwards |
| over_65 | Sum of the bands from 65–66 weeks upwards |
| band_total | Sum of all 105 bands (used for validation) |

## Other tables

| Table | Contents |
|---|---|
| `dbo.england_month` | England by month: waiting list, within 18 weeks, % within 18 weeks. All providers, `C_999` rows, `Part_2`, non-English commissioners excluded. |
| `dbo.oxford_forecast` | Actual waiting list (Sep 2025 – Aug 2026), then three straight-line projections to Aug 2027: last 6 months' average change, last 3 months' average change, and the 6-month trend with 10% more completed pathways. |

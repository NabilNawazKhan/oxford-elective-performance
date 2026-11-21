-- 02_load_months.sql
-- Loads the 12 monthly CSV extracts (September 2025 to August 2026) into dbo.rtt_raw.
-- FORMAT = 'CSV' handles organisation names that contain commas.
-- Change the file paths to match where you saved the CSV files.

USE RTT;

BULK INSERT dbo.rtt_raw
FROM 'C:\RTTdata\raw\20250930-RTT-September-2025-full-extract-revised.csv'
WITH (FORMAT = 'CSV', FIRSTROW = 2, FIELDQUOTE = '"', TABLOCK);

BULK INSERT dbo.rtt_raw
FROM 'C:\RTTdata\raw\20251031-RTT-October-2025-full-extract.csv'
WITH (FORMAT = 'CSV', FIRSTROW = 2, FIELDQUOTE = '"', TABLOCK);

BULK INSERT dbo.rtt_raw
FROM 'C:\RTTdata\raw\20251130-RTT-November-2025-full-extract.csv'
WITH (FORMAT = 'CSV', FIRSTROW = 2, FIELDQUOTE = '"', TABLOCK);

BULK INSERT dbo.rtt_raw
FROM 'C:\RTTdata\raw\20251231-RTT-December-2025-full-extract-revised.csv'
WITH (FORMAT = 'CSV', FIRSTROW = 2, FIELDQUOTE = '"', TABLOCK);

BULK INSERT dbo.rtt_raw
FROM 'C:\RTTdata\raw\20260131-RTT-January-2026-full-extract.csv'
WITH (FORMAT = 'CSV', FIRSTROW = 2, FIELDQUOTE = '"', TABLOCK);

BULK INSERT dbo.rtt_raw
FROM 'C:\RTTdata\raw\20260228-RTT-February-2026-full-extract.csv'
WITH (FORMAT = 'CSV', FIRSTROW = 2, FIELDQUOTE = '"', TABLOCK);

BULK INSERT dbo.rtt_raw
FROM 'C:\RTTdata\raw\20260331-RTT-March-2026-full-extract-revised.csv'
WITH (FORMAT = 'CSV', FIRSTROW = 2, FIELDQUOTE = '"', TABLOCK);

BULK INSERT dbo.rtt_raw
FROM 'C:\RTTdata\raw\20260430-RTT-April-2026-full-extract.csv'
WITH (FORMAT = 'CSV', FIRSTROW = 2, FIELDQUOTE = '"', TABLOCK);

BULK INSERT dbo.rtt_raw
FROM 'C:\RTTdata\raw\20260531-RTT-May-2026-full-extract.csv'
WITH (FORMAT = 'CSV', FIRSTROW = 2, FIELDQUOTE = '"', TABLOCK);

BULK INSERT dbo.rtt_raw
FROM 'C:\RTTdata\raw\20260630-RTT-June-2026-full-extract.csv'
WITH (FORMAT = 'CSV', FIRSTROW = 2, FIELDQUOTE = '"', TABLOCK);

BULK INSERT dbo.rtt_raw
FROM 'C:\RTTdata\raw\20260731-RTT-July-2026-full-extract.csv'
WITH (FORMAT = 'CSV', FIRSTROW = 2, FIELDQUOTE = '"', TABLOCK);

BULK INSERT dbo.rtt_raw
FROM 'C:\RTTdata\raw\20260831-RTT-August-2026-full-extract.csv'
WITH (FORMAT = 'CSV', FIRSTROW = 2, FIELDQUOTE = '"', TABLOCK);

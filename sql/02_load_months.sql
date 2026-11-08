use RTT;
BULK INSERT dbo.rtt_raw
FROM 'C:\RTTdata\raw\20250930-RTT-September-2025-full-extract-revised.csv'
WITH (FORMAT = 'CSV', FIRSTROW = 2, FIELDQUOTE = '"', TABLOCK);

use RTT;
BULK INSERT dbo.rtt_raw
FROM 'C:\RTTdata\raw\20251031-RTT-October-2025-full-extract.csv'
WITH (FORMAT = 'CSV', FIRSTROW = 2, FIELDQUOTE = '"', TABLOCK);

use RTT;
BULK INSERT dbo.rtt_raw
FROM 'C:\RTTdata\raw\20251130-RTT-November-2025-full-extract.csv'
WITH (FORMAT = 'CSV', FIRSTROW = 2, FIELDQUOTE = '"', TABLOCK);

use RTT;
BULK INSERT dbo.rtt_raw
FROM 'C:\RTTdata\raw\20251231-RTT-December-2025-full-extract-revised.csv'
WITH (FORMAT = 'CSV', FIRSTROW = 2, FIELDQUOTE = '"', TABLOCK);

use RTT;
BULK INSERT dbo.rtt_raw
FROM 'C:\RTTdata\raw\20260131-RTT-January-2026-full-extract.csv'
WITH (FORMAT = 'CSV', FIRSTROW = 2, FIELDQUOTE = '"', TABLOCK);

use RTT;
BULK INSERT dbo.rtt_raw
FROM 'C:\RTTdata\raw\20260228-RTT-February-2026-full-extract.csv'
WITH (FORMAT = 'CSV', FIRSTROW = 2, FIELDQUOTE = '"', TABLOCK);

use RTT;
BULK INSERT dbo.rtt_raw
FROM 'C:\RTTdata\raw\20260331-RTT-March-2026-full-extract-revised.csv'
WITH (FORMAT = 'CSV', FIRSTROW = 2, FIELDQUOTE = '"', TABLOCK);

use RTT;
BULK INSERT dbo.rtt_raw
FROM 'C:\RTTdata\raw\20260430-RTT-April-2026-full-extract.csv'
WITH (FORMAT = 'CSV', FIRSTROW = 2, FIELDQUOTE = '"', TABLOCK);

use RTT;
BULK INSERT dbo.rtt_raw
FROM 'C:\RTTdata\raw\20260531-RTT-May-2026-full-extract.csv'
WITH (FORMAT = 'CSV', FIRSTROW = 2, FIELDQUOTE = '"', TABLOCK);

use RTT;
BULK INSERT dbo.rtt_raw
FROM 'C:\RTTdata\raw\20260630-RTT-June-2026-full-extract.csv'
WITH (FORMAT = 'CSV', FIRSTROW = 2, FIELDQUOTE = '"', TABLOCK);

use RTT;
BULK INSERT dbo.rtt_raw
FROM 'C:\RTTdata\raw\20260731-RTT-July-2026-full-extract.csv'
WITH (FORMAT = 'CSV', FIRSTROW = 2, FIELDQUOTE = '"', TABLOCK);

use RTT;
BULK INSERT dbo.rtt_raw
FROM 'C:\RTTdata\raw\20260831-RTT-August-2026-full-extract.csv'
WITH (FORMAT = 'CSV', FIRSTROW = 2, FIELDQUOTE = '"', TABLOCK);




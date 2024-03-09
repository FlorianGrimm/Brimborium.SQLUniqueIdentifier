# The SQL script that creates the tables and prepares the insert statements 

<#

DROP TABLE [dbo].[uid1]
GO
DROP TABLE [dbo].[uid2]
GO

CREATE TABLE [dbo].[uid1](
	[id] [uniqueidentifier] NOT NULL,
	[v] varchar(255),
	[ts] [timestamp] NOT NULL,
 CONSTRAINT [PK_uid1] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[uid2](
	[id] [uniqueidentifier] NOT NULL,
	[v] varchar(255),
	[ts] [timestamp] NOT NULL,
 CONSTRAINT [PK_uid2] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT INTO [dbo].[uid1] ([id],[v]) VALUES ('21111111-1111-1111-1111-111111111111','');


SET STATISTICS IO,TIME OFF;
SET NOCOUNT ON;
#>

# the random data
$v='a'
$v=$v+$v+$v+$v
$v=$v+$v+$v+$v
$v=$v+$v+$v+$v
$v=$v+$v+$v+$v
$v=$v.Substring(0,255)

$g  = [System.Linq.Enumerable]::Range(0,100000) | %{ [Guid]::NewGuid() }
$h = [System.Collections.ArrayList]::new()
[long] $b1st=0x800000000000
[long] $idx=0
for($idx=0;$idx -lt $g.Count; $idx++) {
    $uuid = $g[$idx].ToString()
    $a = ($idx -bor $b1st).ToString('X')
    $b = $uuid.Substring(0, 24) + $a
    $h.Add($b) | Out-Null
}

# the unordered insert statements

'SET NOCOUNT ON;
' | Out-File 'unordered.sql'

$i=0
$g | % {
    "INSERT INTO [dbo].[uid1] ([id],[v]) VALUES ('"+$_+"','"+$v+"');"
	if (999 -eq ($i % 1000)){
		"GO"
	}
	$i++
} | Out-File 'unordered.sql' -Append

# the ordered insert statements

'SET NOCOUNT ON;
' | Out-File 'ordered.sql'

$i = 0
$h | % {
    "INSERT INTO [dbo].[uid2] ([id],[v]) VALUES ('"+$_+"','"+$v+"');"
	if (999 -eq ($i % 1000)){
		"GO"
	}
	$i++
} | Out-File 'ordered.sql' -Append

#
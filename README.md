# Brimborium.SQLUniqueIdentifier

Create Guid to be used as an primarykey, that is kind of sorted and random.

Tested with Microsoft SQL Server 2019 (Developer Edition) inserting 10000 rows with an id: uniqueidentifier and value:vachar(255) takes 33 seconds.
If use the same id an replace the last digits to a increasing number it takes 25 seconds. 

IMHO: The SQL Server does not need to handle the fracmentation.

The test is in testing\PerformanceTest.ps1, which generates 2 files which contains the inserts.
I'm not sure how to really validate the performance of an SQL script. There are so many moving parts.
But in my tests the performance improvement was more than 20%.

## Usage

```c#
yourModel.ID = Brimborium.SQLUniqueIdentifier.NewGuidWithTime();

repo.SaveChanges() // how ever your framework do this
```

For TypeScript I added a function in this repo.

## Packages

Currently not availible via packages. If have to do more testing.

## Reasoning for the format 

The sql-code below:
I insert '11111111-1111-1111-1111-111111111111' with each '1' replaced by a 2 into an sql table and 'select' it.
The last section has he highest priority.

So I replace the last part the the current time, the Guid are random and ordered.
The time part is the current UTC time in Unix Epoch millisconds and the highset bit set to 1.
So you notice this is almost the (new Date()).valueOf() of javascript.

So you can create a uuid on the server and the client and they will be inserted at the end of an sql table - or at least nearly at the end depended on your logic and concurrenty.

```SQL
INSERT INTO [dbo].[uid] ([id]) VALUES ('11111111-1111-1111-1111-111111111111');
INSERT INTO [dbo].[uid] ([id]) VALUES ('11111111-1111-1111-1111-111111111112');
INSERT INTO [dbo].[uid] ([id]) VALUES ('11111111-1111-1111-1111-111111111121');
INSERT INTO [dbo].[uid] ([id]) VALUES ('11111111-1111-1111-1111-111111111211');
INSERT INTO [dbo].[uid] ([id]) VALUES ('11111111-1111-1111-1111-111111112111');
INSERT INTO [dbo].[uid] ([id]) VALUES ('11111111-1111-1111-1111-111111121111');
INSERT INTO [dbo].[uid] ([id]) VALUES ('11111111-1111-1111-1111-111111211111');
INSERT INTO [dbo].[uid] ([id]) VALUES ('11111111-1111-1111-1111-111112111111');
INSERT INTO [dbo].[uid] ([id]) VALUES ('11111111-1111-1111-1111-111121111111');
INSERT INTO [dbo].[uid] ([id]) VALUES ('11111111-1111-1111-1111-111211111111');
INSERT INTO [dbo].[uid] ([id]) VALUES ('11111111-1111-1111-1111-112111111111');
INSERT INTO [dbo].[uid] ([id]) VALUES ('11111111-1111-1111-1111-121111111111');
INSERT INTO [dbo].[uid] ([id]) VALUES ('11111111-1111-1111-1111-211111111111');
INSERT INTO [dbo].[uid] ([id]) VALUES ('11111111-1111-1111-1112-111111111111');
INSERT INTO [dbo].[uid] ([id]) VALUES ('11111111-1111-1111-1121-111111111111');
INSERT INTO [dbo].[uid] ([id]) VALUES ('11111111-1111-1111-1211-111111111111');
INSERT INTO [dbo].[uid] ([id]) VALUES ('11111111-1111-1111-2111-111111111111');
INSERT INTO [dbo].[uid] ([id]) VALUES ('11111111-1111-1112-1111-111111111111');
INSERT INTO [dbo].[uid] ([id]) VALUES ('11111111-1111-1121-1111-111111111111');
INSERT INTO [dbo].[uid] ([id]) VALUES ('11111111-1111-1211-1111-111111111111');
INSERT INTO [dbo].[uid] ([id]) VALUES ('11111111-1111-2111-1111-111111111111');
INSERT INTO [dbo].[uid] ([id]) VALUES ('11111111-1112-1111-1111-111111111111');
INSERT INTO [dbo].[uid] ([id]) VALUES ('11111111-1121-1111-1111-111111111111');
INSERT INTO [dbo].[uid] ([id]) VALUES ('11111111-1211-1111-1111-111111111111');
INSERT INTO [dbo].[uid] ([id]) VALUES ('11111111-2111-1111-1111-111111111111');
INSERT INTO [dbo].[uid] ([id]) VALUES ('11111112-1111-1111-1111-111111111111');
INSERT INTO [dbo].[uid] ([id]) VALUES ('11111121-1111-1111-1111-111111111111');
INSERT INTO [dbo].[uid] ([id]) VALUES ('11111211-1111-1111-1111-111111111111');
INSERT INTO [dbo].[uid] ([id]) VALUES ('11112111-1111-1111-1111-111111111111');
INSERT INTO [dbo].[uid] ([id]) VALUES ('11121111-1111-1111-1111-111111111111');
INSERT INTO [dbo].[uid] ([id]) VALUES ('11211111-1111-1111-1111-111111111111');
INSERT INTO [dbo].[uid] ([id]) VALUES ('12111111-1111-1111-1111-111111111111');
INSERT INTO [dbo].[uid] ([id]) VALUES ('21111111-1111-1111-1111-111111111111');

SELECT * fROM uid

```

The result:

```Text
11111111-1111-1111-1111-111111111111
12111111-1111-1111-1111-111111111111
21111111-1111-1111-1111-111111111111
11121111-1111-1111-1111-111111111111
11211111-1111-1111-1111-111111111111
11111211-1111-1111-1111-111111111111
11112111-1111-1111-1111-111111111111
11111112-1111-1111-1111-111111111111
11111121-1111-1111-1111-111111111111
11111111-1211-1111-1111-111111111111
11111111-2111-1111-1111-111111111111
11111111-1112-1111-1111-111111111111
11111111-1121-1111-1111-111111111111
11111111-1111-1211-1111-111111111111
11111111-1111-2111-1111-111111111111
11111111-1111-1112-1111-111111111111
11111111-1111-1121-1111-111111111111
11111111-1111-1111-1112-111111111111
11111111-1111-1111-1121-111111111111
11111111-1111-1111-1211-111111111111
11111111-1111-1111-2111-111111111111
11111111-1111-1111-1111-111111111112
11111111-1111-1111-1111-111111111121
11111111-1111-1111-1111-111111111211
11111111-1111-1111-1111-111111112111
11111111-1111-1111-1111-111111121111
11111111-1111-1111-1111-111111211111
11111111-1111-1111-1111-111112111111
11111111-1111-1111-1111-111121111111
11111111-1111-1111-1111-111211111111
11111111-1111-1111-1111-112111111111
11111111-1111-1111-1111-121111111111
11111111-1111-1111-1111-211111111111
```

## MS SQL 2022

Tested this with MS SQL Server 2022 same performance benefits.

## Unknowns

I don't know how this performce on other MS SQL Server versions - or other SQL Servers: Postgress, Oracle, ...
How to really validate the performance so that you can deside if ou want this or not.
Degree of parallelism , read/insert/update ratio....


Happy coding
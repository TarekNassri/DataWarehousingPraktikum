IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='gs_Publication' and xtype='U')
CREATE TABLE gs_Publication (
    [Publication_ID] numeric(20, 0) PRIMARY KEY,
    [Venue_ID] numeric(20, 0),
    [Titel] nvarchar(1000),
    [URL] nvarchar(1000),
    [No_Citings] int,
);


IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='gs_Venue' and xtype='U')
CREATE TABLE gs_Venue (
    [Venue_ID] numeric(20, 0) PRIMARY KEY,
    [Name] nvarchar(1000),
    [Jahr] int,
);

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='gs_Author' and xtype='U')
CREATE TABLE gs_Author (
    [Author_ID] numeric(20, 0) PRIMARY KEY,
    [Vorname] nvarchar(100),
    [Familienname] nvarchar(100)
);

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='gs_Author_Publication' and xtype='U')
CREATE TABLE gs_Author_Publication (
    [ID] numeric(20, 0) IDENTITY(1,2) PRIMARY KEY,
    [Publication_ID] numeric(20, 0),
    [Author_ID] numeric(20, 0),
    [Position] int 
);

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='gs_Publication_temp' and xtype='U')
CREATE TABLE gs_Publication_temp (
    [Publication_ID] numeric(20, 0) NOT NULL IDENTITY(1,1) PRIMARY KEY,
    [Titel] nvarchar(1000),
    [No_Citings] int,
    [URL] nvarchar(1000),
    [Authoren] nvarchar(1000),
    [Venue_Jahr] int,
    [Venue_Name] nvarchar(1000),
    [Additional] nvarchar(1000),
    [Venue_ID] numeric(20,0)
);

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='gs_Venue_temp' and xtype='U')
CREATE TABLE gs_Venue_temp (
    [Venue_ID] numeric(20, 0) IDENTITY(1,1) PRIMARY KEY,
    [Name] nvarchar(1000),
    [Jahr] int,
);

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='gs_Author_temp' and xtype='U')
CREATE TABLE gs_Author_temp (
    [Author_ID] numeric(20, 0) IDENTITY(1,1) PRIMARY KEY,
    [Vorname] nvarchar(100),
    [Familienname] nvarchar(100),
    [Name] nvarchar(100)
);

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='gs_Author_Publication_temp' and xtype='U')
CREATE TABLE gs_Author_Publication_temp (
    [ID] numeric(20, 0) IDENTITY(1,1) PRIMARY KEY,
    [Publication_ID] numeric(20, 0),
    [Author_ID] numeric(20, 0),
    [Position] int,
    [Name] nvarchar(100)
);



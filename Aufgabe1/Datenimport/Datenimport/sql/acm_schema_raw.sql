IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='acm_Author_raw' and xtype='U')
CREATE TABLE acm_Author_raw (
    [pos] tinyint,
    [Name] nvarchar(255),
    [Institution] nvarchar(255),
    [Publication_Id] numeric(20,0)
);

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='acm_CitingPub_raw' and xtype='U')
CREATE TABLE acm_CitingPub_raw (
    [id]             bigint,
    [text]           nvarchar (4000),
    [Publication_Id] numeric (20)
);

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='acm_Publication_raw' and xtype='U')
CREATE TABLE acm_Publication_raw (
    [Publication_Id] numeric(20,0),
    [id] bigint,
    [Title] nvarchar(1000),
    [Fulltext] nvarchar(255),
    [StartPage] int,
    [EndPage] int
);

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='acm_Venue_raw' and xtype='U')
CREATE TABLE acm_Venue_raw (
    [id] bigint,
    [year] int,
    [text] nvarchar(255),
    [Publication_Id] numeric(20,0)
);

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='acm_VenueSeries_raw' and xtype='U')
CREATE TABLE acm_VenueSeries_raw (
    [id] nvarchar(255),
    [text] nvarchar(255),
    [Publication_Id] numeric(20,0)
);
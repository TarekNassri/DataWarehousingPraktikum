IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='acm_Author' and xtype='U')
CREATE TABLE acm_Author (
	[Author_ID] uniqueidentifier NOT NULL DEFAULT NEWID(),
	[Vorname] nvarchar(255),
	[Familienname] varchar(255),
	[Institution] nvarchar(255),
	CONSTRAINT acm_Author_pk PRIMARY KEY (Author_ID)
);


IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='acm_VenueSeries' and xtype='U')
CREATE TABLE acm_VenueSeries (
    [VenueSeries_ID] nvarchar(255) NOT NULL,
    [VenueSeries_Name] nvarchar(255),
	CONSTRAINT acm_VenueSeries_pk PRIMARY KEY (VenueSeries_ID)
);

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='acm_Venue' and xtype='U')
CREATE TABLE acm_Venue (
    [Venue_ID] bigint NOT NULL,
	[Venue_Name] nvarchar(255),
    [Jahr] int,
	[VenueSeries_ID] nvarchar(255) NULL FOREIGN KEY REFERENCES acm_VenueSeries(VenueSeries_ID)
	CONSTRAINT acm_Venue_pk PRIMARY KEY (Venue_ID)
);

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='acm_Publication' and xtype='U')
CREATE TABLE acm_Publication (
    [Publication_Id] numeric(20,0) NOT NULL,
    [Title] nvarchar(1000),
    [Fulltext] nvarchar(255),
    [StartPage] int,
    [EndPage] int,
	[Venue_ID] bigint NULL FOREIGN KEY REFERENCES acm_Venue(Venue_ID),
	CONSTRAINT acm_Publication_pk PRIMARY KEY (Publication_ID)
);


IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='acm_CitingPub' and xtype='U')
CREATE TABLE acm_CitingPub (
	[Mapping_ID] uniqueidentifier NOT NULL DEFAULT NEWID(),
	[CitingPub_ID] numeric(20,0),
	[ZitatPub_ID] numeric(20,0),
    [Beschreibung] nvarchar(4000) NULL,
	CONSTRAINT acm_CitingPub_pk PRIMARY KEY (Mapping_ID)
);

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='acm_Author_Publication' and xtype='U')
CREATE TABLE acm_Author_Publication (
	[Author_ID] uniqueidentifier NOT NULL,
    [Publication_ID] numeric(20,0) NOT NULL,
	[Author_Position] tinyint,
	CONSTRAINT acm_Puthor_Publication_pk PRIMARY KEY (Author_ID, Publication_ID)
);

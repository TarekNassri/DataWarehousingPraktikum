IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='dblp_Author' and xtype='U')
CREATE TABLE dblp_Author (
    [Author_ID] bigint NOT NULL,
    [Vorname] varchar(50),
	[Nachname]varchar(50),
    [Familienname] varchar(50),
    [Homepage] varchar(1000),
	CONSTRAINT dblp_Author_pk PRIMARY KEY (Author_ID)
);


IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='dblp_VenueSeries' and xtype='U')
CREATE TABLE dblp_VenueSeries (
    [VenueSeries_ID] bigint NOT NULL,
    [VenueSeries_Name] varchar(500),
    [VenueSeries_Typ] varchar(50),
	CONSTRAINT dblp_VenueSeries_pk PRIMARY KEY (VenueSeries_ID)
);

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='dblp_Venue' and xtype='U')
CREATE TABLE dblp_Venue (
	[Venue_ID] uniqueidentifier NOT NULL DEFAULT NEWID(),
    [VenueSeries_ID] bigint NOT NULL FOREIGN KEY REFERENCES dblp_VenueSeries(VenueSeries_ID),
    [Jahr] smallint,
	CONSTRAINT dblp_Venue_pk PRIMARY KEY (Venue_ID)
);


IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='dblp_Publication' and xtype='U')
CREATE TABLE dblp_Publication (
    [Publication_ID] bigint NOT NULL,
	[DBPL_Code] varchar(250),
    [Titel] varchar(500),
	[Veröffentlichungsjahr] smallint,
    [Startseite] smallint,
    [Endseite] smallint,
	[Venue_ID] uniqueidentifier FOREIGN KEY REFERENCES dblp_Venue(Venue_ID)
	CONSTRAINT dblp_Publication_pk PRIMARY KEY (Publication_ID)
);


IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='dblp_Author_Publication' and xtype='U')
CREATE TABLE dblp_Author_Publication (
    [Publication_ID] bigint NOT NULL FOREIGN KEY REFERENCES dblp_Publication(Publication_ID),
    [Author_ID] bigint NOT NULL FOREIGN KEY REFERENCES dblp_Author(Author_ID),
    [Author_Position] smallint,
	CONSTRAINT dblp_Author_Publication_pk PRIMARY KEY (Publication_ID, Author_ID, Author_Position)
);


IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='dblp_VenueSeries_Publication' and xtype='U')
CREATE TABLE dblp_VenueSeries_Publication (
    [VenueSeries_ID] bigint NOT NULL FOREIGN KEY REFERENCES dblp_VenueSeries(VenueSeries_ID),
    [Publication_ID] bigint NOT NULL FOREIGN KEY REFERENCES dblp_Publication(Publication_ID),
	CONSTRAINT dblp_VenueSeries_Publication_pk PRIMARY KEY (VenueSeries_ID, Publication_ID)
);
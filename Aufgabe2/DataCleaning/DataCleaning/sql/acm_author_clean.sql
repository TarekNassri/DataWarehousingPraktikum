IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='acm_Author_Clean' and xtype='U')
CREATE TABLE acm_Author_Clean (
	[Author_ID] integer NOT NULL,
	[Vorname] nvarchar(255),
	[Familienname] varchar(255),
	[Institution] nvarchar(255),
	CONSTRAINT acm_author_clean_pk PRIMARY KEY (Author_ID)
);


IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='acm_Author_Publication_Clean' and xtype='U')
CREATE TABLE acm_Author_Publication_Clean (
	[Author_ID] integer NOT NULL,
    [Publication_ID] numeric(20,0) NOT NULL,
	[Position] tinyint,
	CONSTRAINT acm_author_publication_clean_pk PRIMARY KEY (Author_ID, Publication_ID)
);
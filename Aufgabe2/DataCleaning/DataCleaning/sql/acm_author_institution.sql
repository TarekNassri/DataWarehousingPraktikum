IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='acm_Author_Institution' and xtype='U')
CREATE TABLE acm_Author_Institution (
	[Author_ID] uniqueidentifier,
	[Vorname] nvarchar(255),
	[Familienname] varchar(255),
	[Institution] nvarchar(255),
	[Key_In] integer,
	[Key_Out] integer,
	[Score] float,
	[sim_Institution] float,
	[sim_fn] float,
	[sim_ln] float,
	[Institution_Clean] nvarchar(255),
	[Vorname_Clean] nvarchar(255),
	[Familienname_Clean] varchar(255),
);
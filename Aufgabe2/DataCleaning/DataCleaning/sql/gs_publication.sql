IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='gs_Publication_cluster' and xtype='U')
CREATE TABLE gs_Publication_cluster(
    [gs_Publication_ID] numeric(20, 0) NOT NULL,
	[gs_Titel] varchar(500),
	[gs_Autoren] varchar(255),
	[gs_Jahr] integer,
	[sim_Titel] float,
	[sim_Autoren] float,
	[Score] float,
	[Key_Out] bigint,
	CONSTRAINT gs_Publication_pk PRIMARY KEY(gs_Publication_ID)
);
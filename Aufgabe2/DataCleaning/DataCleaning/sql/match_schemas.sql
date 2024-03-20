IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='match_dblp_acm_Publication' and xtype='U')
CREATE TABLE match_dblp_acm_Publication(
    [dblp_Publication_ID] bigint NOT NULL,
    [acm_Publication_ID] bigint NOT NULL,
	[sim_Titel] float,
	[sim_Autoren] float,
	[sim_VenueSeries_Name] float,
	CONSTRAINT match_dblp_acm_Publication_pk PRIMARY KEY(dblp_Publication_ID, acm_Publication_ID)
);

--DROP TABLE match_dblp_acm_publication;


IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='match_dblp_gs_Publication' and xtype='U')
CREATE TABLE match_dblp_gs_Publication(
    [dblp_Publication_ID] bigint NOT NULL,
    [gs_Publication_ID] bigint NOT NULL,
	[sim_Titel] float,
	[sim_Autoren] float,
	CONSTRAINT match_dblp_gs_publication_pk PRIMARY KEY(dblp_Publication_ID, gs_Publication_ID)
);

--DROP TABLE match_dblp_gs_publication;
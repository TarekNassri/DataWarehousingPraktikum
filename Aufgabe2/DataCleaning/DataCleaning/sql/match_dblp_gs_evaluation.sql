CREATE OR ALTER VIEW dbo.match_dblp_gs_evaluation
AS
SELECT 
m.*, 
d.dblp_Titel, 
pc.gs_Titel, 
d.dblp_Autoren, 
pc.gs_Autoren, 
d.dblp_Jahr, 
pc.gs_Jahr, 
CASE WHEN d.dblp_Jahr=pc.gs_Jahr THEN 1 ELSE 0 END AS Jahr_Match,
((m.sim_Titel * 2) + m.sim_Autoren + (CASE WHEN d.dblp_Jahr=pc.gs_Jahr THEN 1 ELSE 0 END)) / 4 AS Score,
pc.gs_No_Citings

FROM match_dblp_gs_Publication m 
LEFT JOIN dblp_view d 
ON m.dblp_Publication_ID = d.dblp_Publication_ID 
LEFT JOIN gs_publication_cleaned pc
ON m.gs_Publication_ID = pc.gs_Publication_ID
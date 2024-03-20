CREATE OR ALTER VIEW dbo.match_dblp_acm_evaluation
AS
SELECT 
m.*, 
d.dblp_Titel, 
a.acm_Title, 
d.dblp_Autoren, 
a.acm_Autoren, 
d.dblp_Jahr, 
a.acm_Jahr, 
CASE WHEN d.dblp_Jahr=a.acm_Jahr THEN 1 ELSE 0 END AS Jahr_Match, 
d.dblp_Startseite, 
a.acm_StartPage, 
CASE WHEN d.dblp_Startseite=a.acm_StartPage THEN 1 ELSE 0 END AS StartPage_Match, 
d.dblp_Endseite, 
a.acm_EndPage, 
CASE WHEN d.dblp_Endseite=a.acm_EndPage THEN 1 ELSE 0 END AS EndPage_Match, 
d.dblp_VenueSeries_Name, 
a.acm_VenueSeries_Name, 
a.acm_Venue_Name, 
CASE WHEN m.sim_Titel=1 AND d.dblp_Jahr=a.acm_Jahr THEN 1 ELSE 
((2 * m.sim_Titel) + m.sim_Autoren + m.sim_VenueSeries_Name + CASE WHEN d.dblp_Jahr=a.acm_Jahr THEN 1 ELSE 0 END + 
CASE WHEN d.dblp_Startseite=a.acm_StartPage THEN 1 ELSE 0 END + CASE WHEN d.dblp_Endseite=a.acm_EndPage THEN 1 ELSE 0 END) / 7 END AS total_score

FROM match_dblp_acm_Publication m LEFT JOIN dblp_view d ON m.dblp_Publication_ID = d.dblp_Publication_ID LEFT JOIN acm_view a ON m.acm_Publication_ID = a.acm_Publication_Id
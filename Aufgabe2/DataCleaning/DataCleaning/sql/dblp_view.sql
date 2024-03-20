CREATE OR ALTER VIEW dbo.dblp_view
AS
SELECT p.Publication_ID AS dblp_Publication_ID, CAST(p.Titel AS varchar(500)) AS dblp_Titel, p.Startseite AS dblp_Startseite, p.Endseite AS dblp_Endseite, p.DBPL_Code, p.Venue_ID AS dblp_Venue_ID, 
CAST(appv.Autoren AS varchar(255)) AS dblp_Autoren, v.Jahr AS dblp_Jahr, vs.VenueSeries_ID AS dblp_VenueSeries_ID, 
CAST(vs.VenueSeries_Name AS varchar(255)) AS dblp_VenueSeries_Name, vs.VenueSeries_Typ AS dblp_VenueSeries_Typ
FROM dblp_Publication p LEFT JOIN dblp_Venue v ON p.Venue_ID=v.Venue_ID 
LEFT JOIN dblp_VenueSeries vs ON v.VenueSeries_ID=vs.VenueSeries_ID LEFT JOIN dblp_authors_publication_view appv ON p.Publication_ID=appv.Publication_ID
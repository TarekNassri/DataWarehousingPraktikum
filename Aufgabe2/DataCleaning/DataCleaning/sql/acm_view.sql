CREATE OR ALTER VIEW dbo.acm_view
AS
SELECT p.Publication_Id AS acm_Publication_Id, CAST(p.Title AS varchar(500)) AS acm_Title, p.Fulltext AS acm_Fulltext, p.StartPage AS acm_StartPage, p.EndPage AS acm_EndPage, 
p.Venue_ID AS acm_Venue_ID, CAST(v.Venue_Name AS varchar(255)) AS acm_Venue_Name, v.Jahr AS acm_Jahr, 
CAST(vs.VenueSeries_Name AS varchar(255)) AS acm_VenueSeries_Name, CAST(appv.Autoren AS varchar(255)) AS acm_Autoren
FROM acm_Publication p LEFT JOIN acm_Venue v ON p.Venue_ID=v.Venue_ID 
LEFT JOIN acm_VenueSeries vs ON v.VenueSeries_ID=vs.VenueSeries_ID LEFT JOIN acm_authors_publication_view appv ON p.Publication_Id=appv.Publication_Id
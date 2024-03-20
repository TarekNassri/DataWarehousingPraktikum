CREATE OR ALTER VIEW dbo.gs_view
AS
SELECT p.Publication_ID AS gs_Publication_ID, CAST(p.Titel AS varchar(500)) AS gs_Titel, CAST(appv.Autoren AS varchar(255)) AS gs_Autoren, v.Jahr AS gs_Jahr
FROM gs_Publication p LEFT JOIN gs_Venue v ON p.Venue_ID=v.Venue_ID LEFT JOIN gs_authors_publication_view appv ON p.Publication_ID=appv.Publication_ID
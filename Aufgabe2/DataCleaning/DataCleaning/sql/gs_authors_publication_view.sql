CREATE OR ALTER VIEW dbo.gs_authors_publication_view
AS
SELECT p.Publication_ID, STRING_AGG(CONVERT(NVARCHAR(max), CONCAT(a.Vorname, ' ', a.Familienname)), ',') AS Autoren
FROM gs_Publication p JOIN gs_Author_Publication ap ON p.Publication_ID=ap.Publication_ID JOIN gs_Author a ON ap.Author_ID=a.Author_ID
GROUP BY p.Publication_ID
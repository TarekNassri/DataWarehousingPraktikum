CREATE OR ALTER VIEW dbo.dblp_authors_publication_view
AS
SELECT p.Publication_ID, STRING_AGG(CONVERT(NVARCHAR(max), CONCAT(a.Vorname, ' ', a.Familienname)), ',') WITHIN GROUP (ORDER BY ap.Author_Position) AS Autoren
FROM dblp_Publication p JOIN dblp_Author_Publication ap ON p.Publication_ID=ap.Publication_ID JOIN dblp_Author a ON ap.Author_ID=a.Author_ID
GROUP BY p.Publication_ID
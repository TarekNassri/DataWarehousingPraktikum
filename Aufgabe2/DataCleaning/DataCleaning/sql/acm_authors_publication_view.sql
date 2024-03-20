CREATE OR ALTER VIEW dbo.acm_authors_publication_view
AS
SELECT p.Publication_Id, STRING_AGG(CONVERT(NVARCHAR(max), CONCAT(a.Vorname, ' ', a.Familienname)), ',') WITHIN GROUP (ORDER BY ap.Author_Position) AS Autoren
FROM acm_Publication p JOIN acm_Author_Publication ap ON p.Publication_Id=ap.Publication_ID JOIN acm_Author a ON ap.Author_ID=a.Author_ID
GROUP BY p.Publication_Id
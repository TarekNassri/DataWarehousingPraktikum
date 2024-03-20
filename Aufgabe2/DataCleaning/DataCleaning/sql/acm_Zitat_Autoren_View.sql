CREATE OR ALTER VIEW dbo.acm_Zitat_Autoren_View
AS
SELECT 
	cp.Mapping_ID,
	cp.ZitatPub_ID,
	cp.CitingPub_ID,
	a.Author_ID AS CitingAuthor_ID,
	a.Vorname AS Citing_Author_Vorname,
	a.Familienname AS Citing_Author_Familienname,
	a.Institution AS Citing_Author_Institution
FROM 
	acm_CitingPub cp
	JOIN
	acm_Publication p
	ON
	cp.CitingPub_ID = p.Publication_Id
	JOIN
	acm_Author_Publication_Clean ap
	ON
	p.Publication_Id = ap.Publication_ID
	JOIN
	acm_Author_Clean a
	ON ap.Author_ID = a.Author_ID
WHERE
	CitingPub_ID IS NOT NULL;
CREATE OR ALTER VIEW dbo.acm_zitierte_Autoren_View
AS
SELECT 
	cp.Mapping_ID,
	cp.CitingPub_ID,
	cp.ZitatPub_ID,
	a.Author_ID AS Zitat_Author_ID,
	a.Vorname AS Zitat_Author_Vorname,
	a.Familienname AS Zitat_Author_Familienname,
	a.Institution AS Zitat_Author_Institution
FROM 
	acm_CitingPub cp
	JOIN
	acm_Publication p
	ON
	cp.ZitatPub_ID = p.Publication_Id
	JOIN
	acm_Author_Publication_Clean ap
	ON
	p.Publication_Id = ap.Publication_ID
	JOIN
	acm_Author_Clean a
	ON ap.Author_ID = a.Author_ID
WHERE
	CitingPub_ID IS NOT NULL
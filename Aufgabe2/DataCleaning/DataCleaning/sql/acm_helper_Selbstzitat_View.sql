CREATE OR ALTER VIEW dbo.acm_helper_Selbstzitat_View
AS
SELECT CONCAT(a.Vorname, ' ', a.Familienname) AS Name, cp.Mapping_ID, cp.Beschreibung, cp.ZitatPub_ID, cp.CitingPub_ID
FROM 
	acm_CitingPub cp
	LEFT JOIN
	acm_Publication p
	ON cp.ZitatPub_ID=p.Publication_ID
	JOIN 
	acm_Author_Publication_Clean ap
	ON p.Publication_ID=ap.Publication_ID
	JOIN 
	acm_Author_Clean a 
	ON ap.Author_ID = a.Author_ID
WHERE
	cp.CitingPub_ID IS NULL AND cp.Beschreibung IS NOT NULL
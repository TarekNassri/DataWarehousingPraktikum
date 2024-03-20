UPDATE cp
SET cp.Selbstzitat='TRUE'
FROM acm_CitingPub cp
JOIN
(
	SELECT DISTINCT za.mapping_id
	FROM 
		acm_Zitat_Autoren_View za
		JOIN
		acm_zitierte_Autoren_View zav
		ON
		za.Mapping_ID = zav.Mapping_ID AND za.CitingAuthor_ID=zav.Zitat_Author_ID
) selbstzitat
ON cp.Mapping_ID = selbstzitat.Mapping_ID
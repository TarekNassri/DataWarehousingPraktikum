UPDATE cp
SET Selbstzitat = 0
FROM acm_CitingPub cp;


UPDATE cp
SET cp.Selbstzitat = 'TRUE'
FROM acm_CitingPub cp
WHERE EXISTS (
	SELECT DISTINCT sc.Mapping_ID, sc.Selbstzitat
	FROM
		(
			SELECT (CASE WHEN Beschreibung LIKE '%' + Name + '%' THEN 1 ELSE 0 END) AS Selbstzitat, * 
			FROM acm_helper_Selbstzitat_View 
		) sc
	WHERE sc.Selbstzitat=1 AND sc.Mapping_ID=cp.Mapping_ID
)
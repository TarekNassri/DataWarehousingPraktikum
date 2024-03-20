CREATE OR ALTER VIEW acm_authors_institution_cleaned AS
SELECT *, (
	CASE
		WHEN Institution LIKE '%univ. of%'
		THEN dbo.clean_institution(Institution, '%univ. of%')
		WHEN Institution LIKE '%university of%'
		THEN dbo.clean_institution(Institution, '%university of%')
		ELSE Institution
	END
) as Institution_Clean
FROM acm_Author
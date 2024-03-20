CREATE OR ALTER VIEW dbo.match_dblp_acm_final_mapping
AS
SELECT m.* 
FROM match_dblp_acm_evaluation m
INNER JOIN (
	SELECT acm_Publication_ID, MAX(total_score) AS max_total_score
	FROM match_dblp_acm_evaluation
	GROUP BY acm_Publication_ID
) b ON m.acm_Publication_ID=b.acm_Publication_ID AND m.total_score=b.max_total_score
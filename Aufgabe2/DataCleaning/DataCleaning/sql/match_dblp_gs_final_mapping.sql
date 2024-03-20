CREATE OR ALTER VIEW dbo.match_dblp_gs_final_mapping
AS
SELECT a.* 
FROM match_dblp_gs_evaluation a
INNER JOIN (
	SELECT gs_Publication_ID, MAX(Score) AS max_Score
	FROM match_dblp_gs_evaluation
	GROUP BY gs_Publication_ID
) b ON a.gs_Publication_ID=b.gs_Publication_ID AND a.Score=b.max_Score
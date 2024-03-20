CREATE OR ALTER VIEW gs_publication_cleaned
AS
SELECT c.Key_Out AS gs_Publication_ID, MIN(c.gs_Autoren) AS gs_Autoren, MIN(c.gs_Titel) AS gs_Titel, MIN(c.gs_Jahr) AS gs_Jahr, SUM(p.No_Citings) AS gs_No_Citings
FROM 
	gs_Publication_cluster c
	JOIN
	gs_Publication p
	ON c.gs_Publication_ID=p.Publication_ID
GROUP BY c.Key_Out
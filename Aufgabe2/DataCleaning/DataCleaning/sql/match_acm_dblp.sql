INSERT INTO match_dblp_acm_Publication(acm_Publication_ID, dblp_Publication_ID, sim_Titel)

SELECT acm.Publication_Id, dblp.Publication_ID, 1
FROM
(SELECT p.Publication_Id, p.Title, v.Jahr
FROM acm_Publication AS p LEFT JOIN acm_Venue AS v ON p.Venue_ID = v.Venue_ID) AS acm

JOIN

(SELECT p.Publication_ID, p.Titel, v.Jahr
FROM dblp_Publication AS p JOIN dblp_Venue AS v ON p.Venue_ID = v.Venue_ID
WHERE v.VenueSeries_ID IN (SELECT VenueSeries_ID FROM dblp_VenueSeries WHERE VenueSeries_Name IN ('ACM Trans. Database Syst.', 'SIGMOD Conference', 'SIGMOD Record', 'VLDB', 'VLDB J.'))) AS dblp

ON acm.Title = dblp.Titel AND acm.Jahr = dblp.Jahr
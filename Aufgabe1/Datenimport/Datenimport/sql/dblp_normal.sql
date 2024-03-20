/*
747 Duplikate in dblp_Author, gleiche Homepage: Duplikat
SELECT *  FROM dblp_Author a
JOIN  (SELECT Vorname, Familienname, Homepage, COUNT(*) AS cnt FROM dblp_Author WHERE Homepage!= 'NULL' 
GROUP BY Vorname, Familienname, Homepage HAVING COUNT(*) > 1) aa 
ON a.Vorname=aa.Vorname AND a.Familienname = aa.Familienname and a.Homepage = aa.Homepage
ORDER BY a.Vorname, a.Familienname
*/

UPDATE dblp_Author_Publication
SET Author_ID=53786 WHERE Author_ID = 250965
DELETE FROM dblp_Author WHERE Author_ID=250965;

UPDATE dblp_Author_Publication
SET Author_ID=2547 WHERE Author_ID = 366699
DELETE FROM dblp_Author WHERE Author_ID=366699;

UPDATE dblp_Author_Publication
SET Author_ID=28932 WHERE Author_ID = 20883
DELETE FROM dblp_Author WHERE Author_ID=20883;

UPDATE dblp_Author_Publication
SET Author_ID=2691 WHERE Author_ID = 158248
DELETE FROM dblp_Author WHERE Author_ID=158248;

UPDATE dblp_Author_Publication
SET Author_ID=417082 WHERE Author_ID = 6273
DELETE FROM dblp_Author WHERE Author_ID=6273;

UPDATE dblp_Author_Publication
SET Author_ID=60870 WHERE Author_ID = 8173
DELETE FROM dblp_Author WHERE Author_ID=8173;

UPDATE dblp_Author_Publication
SET Author_ID=16885 WHERE Author_ID = 454242
DELETE FROM dblp_Author WHERE Author_ID=454242;

UPDATE dblp_Author_Publication
SET Author_ID=11455 WHERE Author_ID = 144332
DELETE FROM dblp_Author WHERE Author_ID=144332;

UPDATE dblp_Author_Publication
SET Author_ID=18662 WHERE Author_ID = 20851
DELETE FROM dblp_Author WHERE Author_ID=20851;

UPDATE dblp_Author_Publication
SET Author_ID=33981 WHERE Author_ID = 282490
DELETE FROM dblp_Author WHERE Author_ID=282490;

UPDATE dblp_Author_Publication
SET Author_ID=4266 WHERE Author_ID = 215001
DELETE FROM dblp_Author WHERE Author_ID=215001;

UPDATE dblp_Author_Publication
SET Author_ID=25200 WHERE Author_ID = 2573
DELETE FROM dblp_Author WHERE Author_ID=2573;

UPDATE dblp_Author_Publication
SET Author_ID=31631 WHERE Author_ID = 80188
DELETE FROM dblp_Author WHERE Author_ID=80188;

UPDATE dblp_Author_Publication
SET Author_ID=14663 WHERE Author_ID = 18602
DELETE FROM dblp_Author WHERE Author_ID=18602;

UPDATE dblp_Author_Publication
SET Author_ID=17109 WHERE Author_ID = 242588
DELETE FROM dblp_Author WHERE Author_ID=242588;

UPDATE dblp_Author_Publication
SET Author_ID=46201 WHERE Author_ID = 118079
DELETE FROM dblp_Author WHERE Author_ID=118079;

UPDATE dblp_Author_Publication
SET Author_ID=75377 WHERE Author_ID = 70643
DELETE FROM dblp_Author WHERE Author_ID=70643;

UPDATE dblp_Author_Publication
SET Author_ID=12502 WHERE Author_ID = 99794
DELETE FROM dblp_Author WHERE Author_ID=99794;

UPDATE dblp_Author_Publication
SET Author_ID=20053 WHERE Author_ID = 191119
DELETE FROM dblp_Author WHERE Author_ID=191119;

UPDATE dblp_Author_Publication
SET Author_ID=18757 WHERE Author_ID = 442636
DELETE FROM dblp_Author WHERE Author_ID=442636;


/*
Duplikate in dblp_VenueSeries entfernen

SELECT VenueSeries_Name, vs_type, COUNT(*) FROM dblp_VenueSeries GROUP BY VenueSeries_Name, VenueSeries_Type HAVING COUNT(*) > 1 ORDER BY COUNT(*) DESC
*/
UPDATE dblp_VenueSeries_Publication
SET VenueSeries_ID=227 WHERE VenueSeries_ID = 892 OR VenueSeries_ID=2013 --NETWORKING
DELETE FROM dblp_VenueSeries WHERE VenueSeries_ID=892 OR VenueSeries_ID=2013


UPDATE dblp_VenueSeries_Publication
SET VenueSeries_ID=2372 WHERE VenueSeries_ID = 3262 --TEX, XML, and Digital Typography
DELETE FROM dblp_VenueSeries WHERE VenueSeries_ID = 3262


UPDATE dblp_VenueSeries_Publication
SET VenueSeries_ID=1983 WHERE VenueSeries_ID = 3212 --DIWeb
DELETE FROM dblp_VenueSeries WHERE VenueSeries_ID=3212


UPDATE dblp_VenueSeries_Publication
SET VenueSeries_ID=1386 WHERE VenueSeries_ID = 3201 --FroCos
DELETE FROM dblp_VenueSeries WHERE VenueSeries_ID=3201


UPDATE dblp_VenueSeries_Publication
SET VenueSeries_ID=2060 WHERE VenueSeries_ID = 2133 --MOBIS
DELETE FROM dblp_VenueSeries WHERE VenueSeries_ID=2133


UPDATE dblp_VenueSeries_Publication
SET VenueSeries_ID=398 WHERE VenueSeries_ID = 1749 --PaCT
DELETE FROM dblp_VenueSeries WHERE VenueSeries_ID=1749


UPDATE dblp_VenueSeries_Publication
SET VenueSeries_ID=1672 WHERE VenueSeries_ID = 1970 --PAM
DELETE FROM dblp_VenueSeries WHERE VenueSeries_ID=1970


UPDATE dblp_VenueSeries_Publication
SET VenueSeries_ID=895 WHERE VenueSeries_ID = 3275 --VLSI-SOC
DELETE FROM dblp_VenueSeries WHERE VenueSeries_ID=3275


UPDATE dblp_VenueSeries_Publication
SET VenueSeries_ID=1551 WHERE VenueSeries_ID = 2498 --XSym
DELETE FROM dblp_VenueSeries WHERE VenueSeries_ID=2498


-- Venue_Tabelle befüllen
INSERT INTO dblp_Venue(VenueSeries_ID, Jahr)
SELECT DISTINCT vsp.VenueSeries_ID, p.Veröffentlichungsjahr FROM dblp_VenueSeries_Publication AS vsp JOIN dblp_Publication AS p ON vsp.Publication_ID=p.Publication_ID


-- temporäre Venue_Publication-Tabelle erstellen und befüllen
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='dblp_Publication_Venue_tmp' and xtype='U')
CREATE TABLE dblp_Publication_Venue_tmp (
    [Publication_ID] BIGINT           NULL,
    [Venue_ID]       UNIQUEIDENTIFIER NULL
);

INSERT INTO dblp_Publication_Venue_tmp(publication_id, venue_id)
SELECT p.Publication_ID, v.Venue_ID 
FROM
	dblp_publication AS p
	JOIN
	dblp_VenueSeries_Publication AS vsp
	ON p.Publication_ID=vsp.Publication_ID
	JOIN
	dblp_venue AS v
	ON vsp.VenueSeries_ID=v.VenueSeries_ID AND p.Veröffentlichungsjahr = v.Jahr

UPDATE p
  SET p.Venue_ID = pv.Venue_ID
  FROM dblp_Publication AS p
  JOIN dblp_Publication_Venue_tmp AS pv
  ON p.Publication_ID = pv.Publication_ID
	
ALTER TABLE dblp_Publication
DROP COLUMN Veröffentlichungsjahr;

/*
61 Duplikate in dblp_Author_Publication
SELECT Author_ID, Publication_ID, count(1) FROM dbpl_Author_Publication GROUP BY Author_ID, Publication_ID HAVING count(1) > 1;

SELECT * FROM dblp_Author_Publication WHERE Author_ID NOT IN (SELECT Author_ID FROM dblp_Author); -- 0 Ergebnisse
*/

DELETE p FROM dblp_Author_Publication p
INNER JOIN
(SELECT Publication_ID, Author_ID, MAX(Author_Position) AS position FROM dblp_Author_Publication GROUP BY Author_ID, Publication_ID HAVING COUNT(*) > 1)
t ON p.Publication_ID = t.Publication_ID AND p.Author_ID = t.Author_ID AND p.Author_Position = t.position

/*
keine Duplikate in dblp_Publication
SELECT Titel, DBLP_Code, Veröffentlichungsjahr, Startseite, Endseite, COUNT(*) FROM dblp_Publication GROUP BY Titel, DBLP_Code, Veröffentlichungsjahr, Startseite, Endseite HAVING COUNT(*) > 1
*/

/*
keine Duplikate in dblp_VenueSeries_Publication
SELECT VenueSeries_ID, Publication_ID, count(1) FROM dblp_VenueSeries_Publication GROUP BY VenueSeries_ID, Publication_ID HAVING count(1) > 1;
*/

DROP TABLE dblp_Publication_Venue_tmp;
DROP TABLE dblp_VenueSeries_Publication;
-- temporäre Venue_VenueSeries-Tabelle erstellen
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='acm_Venue_VenueSeries_tmp' and xtype='U')
CREATE TABLE acm_Venue_VenueSeries_tmp (
	[Venue_ID] bigint NOT NULL FOREIGN KEY REFERENCES acm_Venue(Venue_ID),
    [VenueSeries_ID] nvarchar(255) NOT NULL FOREIGN KEY REFERENCES acm_VenueSeries(VenueSeries_ID),
    CONSTRAINT acm_Venue_VenueSeries_pk_tmp PRIMARY KEY (Venue_ID, VenueSeries_ID)
);


-- Venue-Tabelle und befüllen
INSERT INTO acm_Venue(Venue_ID, Venue_Name, Jahr)
SELECT DISTINCT vr.id, vr.text, vrt.year 
FROM acm_Venue_raw vr JOIN
(SELECT id, MIN(year) AS year FROM acm_Venue_raw GROUP BY id) vrt ON vr.id = vrt.id AND vr.year = vrt.year


-- Duplikate für VenueSeries löschen
INSERT INTO acm_VenueSeries(VenueSeries_ID, VenueSeries_Name)
SELECT DISTINCT id, text FROM acm_VenueSeries_raw;


-- temporäre Venue_VenueSeries bekommen
INSERT INTO acm_Venue_VenueSeries_tmp(Venue_ID, VenueSeries_ID)
SELECT vr.id, vsr.id 
FROM acm_Venue_raw AS vr LEFT JOIN acm_VenueSeries_raw AS vsr ON vr.Publication_Id=vsr.Publication_Id
GROUP BY vr.id, vsr.id
ORDER BY vsr.id;


-- VenueSeries_ID in Venue-Tabelle setzen
UPDATE v
  SET v.VenueSeries_ID = vvs.VenueSeries_ID
  FROM acm_Venue AS v
  LEFT JOIN acm_Venue_VenueSeries_tmp AS vvs
  ON v.Venue_ID=vvs.Venue_ID;


-- Temporäre Author-Tabelle erstellen
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='acm_Author_tmp' and xtype='U')
CREATE TABLE acm_Author_tmp (
	[Author_ID] uniqueidentifier NOT NULL DEFAULT NEWID(),
	[Name] nvarchar(255),
	[Institution] nvarchar(255),
	CONSTRAINT acm_Author_tmp_pk PRIMARY KEY (Author_ID)
);


-- temporäre Author-Tabelle befüllen und Duplikate löschen
INSERT INTO acm_Author_tmp(Name, Institution)
SELECT Name, Institution FROM acm_Author_raw GROUP BY Name, Institution;


-- Author-Tabelle befüllen und Name in Vorname und Familienname teilen
INSERT INTO acm_Author(Author_ID, Vorname, Familienname, Institution)
SELECT Author_ID, 
TRIM(SUBSTRING(Name,0,(LEN(Name) - CHARINDEX(' ', REVERSE(Name)) + 1))) AS Vorname,
TRIM(SUBSTRING(Name,(LEN(Name) - CHARINDEX(' ', REVERSE(Name)) + 2), LEN(Name))) AS Familienname, 
Institution  FROM acm_Author_tmp;


-- Publication-Tabelle befüllen und Duplikate löschen
INSERT INTO acm_Publication(Publication_Id, Title, Fulltext, StartPage, EndPage)
SELECT Publication_Id, Title, Fulltext, StartPage, EndPage FROM acm_Publication_raw WHERE Publication_Id IN (SELECT MIN(Publication_Id) FROM acm_Publication_raw GROUP BY id)

-- Fremdschlüssel für Venue hinzufügen
UPDATE p
SET p.Venue_ID = vr.id
FROM acm_Publication AS p
JOIN (
	SELECT vr.Publication_Id, vr.id
	FROM acm_Venue_raw AS vr)
	AS vr 
	ON p.Publication_ID=vr.Publication_Id


-- Author_Publication bekommen
INSERT INTO acm_Author_Publication(Author_ID, Publication_ID, Author_Position)
SELECT atmp.Author_ID, ar.Publication_Id, ar.pos
FROM acm_Author_raw AS ar LEFT JOIN acm_Author_tmp AS atmp
ON (((ar.Name = atmp.Name) OR (ar.Name IS NULL AND atmp.Name IS NULL)) AND ((ar.Institution = atmp.Institution) OR (ar.Institution IS NULL and atmp.Institution IS NULL)));


-- CitingPub-Tabelle bekommen
INSERT INTO acm_CitingPub(ZitatPub_ID, CitingPub_ID, Beschreibung)
SELECT cpr.Publication_Id, p.Publication_Id, cpr.text FROM acm_CitingPub_raw AS cpr LEFT JOIN (SELECT id, Publication_Id FROM acm_Publication_raw WHERE Publication_Id 
IN (SELECT MIN(Publication_Id) FROM acm_Publication_raw GROUP BY id)) AS p ON cpr.id = p.id ORDER BY cpr.id;


-- temporäre Tabellen löschen
DROP TABLE acm_Author_tmp;
DROP TABLE acm_Venue_VenueSeries_tmp;
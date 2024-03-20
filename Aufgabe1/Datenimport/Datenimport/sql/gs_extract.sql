
TRUNCATE TABLE gs_Author_temp
TRUNCATE TABLE gs_Author_publication_temp
TRUNCATE TABLE gs_Venue_temp

-- Jahr vom Muster extrahieren
UPDATE gs_Publication_temp
	SET Venue_Jahr = REVERSE(SUBSTRING(
		REVERSE(Additional),
		NULLIF(PATINDEX('%[0-9][0-9][0-9][1-2] %', REVERSE(TRIM(Additional))),0),
		4
	))

-- Venue_Name extrahieren
UPDATE gs_Publication_temp
	SET Venue_Name = SUBSTRING(
		Additional,
		NULLIF(CHARINDEX('-', Additional),0),
		CASE
			WHEN NULLIF(PATINDEX('%[1-2][0-9][0-9][0-9]%', Additional),0) - NULLIF(CHARINDEX('-', Additional),0) < 0 THEN 0
			ELSE NULLIF(PATINDEX('%[1-2][0-9][0-9][0-9]%', Additional),0) - NULLIF(CHARINDEX('-', Additional),0)
		END
		)

-- unerwünschte Zeichen entfernen
UPDATE gs_Publication_temp
SET Venue_Name = TRIM(REPLACE(REPLACE(REPLACE(Venue_Name,',',''),'-',''),'&hellip;',''))

-- Autoren extrahieren 
UPDATE gs_Publication_temp SET Authoren = TRIM(REPLACE(SUBSTRING(Additional,0, CHARINDEX('-', Additional)),'&hellip;',''))

-- Zeilen mit Nullwerten löschen
DELETE FROM gs_Publication_temp WHERE Venue_Jahr IS NULL OR Authoren IS NULL OR NULLIF(Authoren,'') IS NULL OR NULLIF(Venue_Name,'') IS NULL 

-- nach , aufteilen und alle Verweise einfügen
INSERT INTO gs_Author_Publication_temp(Publication_ID, Name)
SELECT  Publication_ID, TRIM(value)
FROM gs_Publication_temp
CROSS APPLY STRING_SPLIT(Authoren,',')

-- leere Werte löschen
DELETE FROM gs_Author_Publication_temp WHERE TRIM(Name) = ''

-- eindeutige Autoren in eine neue Tabelle einfügen
INSERT INTO gs_Author_temp(Name)
SELECT DISTINCT Name FROM gs_Author_Publication_temp

-- Referenz auf Author_ID setzen
UPDATE gs_Author_Publication_temp
SET gs_Author_Publication_temp.Author_ID = gs_Author_temp.Author_ID
FROM gs_Author_Publication_temp 
JOIN gs_Author_temp ON gs_Author_Publication_temp.Name = gs_Author_temp.Name

-- Autorenname in Vor- und Nachname umwandeln
UPDATE gs_Author_temp
SET Vorname = TRIM(SUBSTRING(Name,0,CHARINDEX(' ',Name))),
	Familienname = TRIM(SUBSTRING(Name,CHARINDEX(' ',Name), LEN(Name)))

-- eindeutige Werte in eine neue Tabelle einfügen
INSERT INTO gs_Venue_temp (Name, Jahr)
SELECT DISTINCT Venue_Name, Venue_Jahr FROM gs_Publication_temp

-- Referenz auf Venue_ID setzen
UPDATE gs_Publication_temp 
SET gs_Publication_temp.Venue_ID = gs_Venue_temp.Venue_ID
FROM gs_Publication_temp
JOIN gs_Venue_temp  ON gs_Publication_temp.Venue_Name = gs_Venue_temp.Name AND gs_Publication_temp.Venue_Jahr = gs_Venue_temp.Jahr
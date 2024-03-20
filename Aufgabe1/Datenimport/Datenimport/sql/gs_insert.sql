TRUNCATE TABLE gs_Author_Publication
TRUNCATE TABLE gs_Author
TRUNCATE TABLE gs_Publication
TRUNCATE TABLE gs_Venue


-- Venues einfügen
INSERT INTO gs_Venue (Venue_ID, Name, Jahr)
SELECT Venue_ID, Name, Jahr FROM gs_Venue_temp

-- Publications einfügen
INSERT INTO gs_Publication (Publication_ID, Titel, No_Citings, URL, Venue_ID)
SELECT Publication_ID, Titel, No_Citings, URL, Venue_ID FROM gs_Publication_temp

-- Autoren einfügen
INSERT INTO gs_Author (Author_ID, Vorname, Familienname)
SELECT Author_ID, Vorname, Familienname FROM gs_Author_temp

-- Referenz für Author_Publication einfügen
INSERT INTO gs_Author_Publication(Publication_ID, Author_ID, Position)
SELECT Publication_ID, Author_ID, 0 FROM gs_Author_Publication_temp

DROP TABLE gs_Author_temp
DROP TABLE gs_Venue_temp
DROP TABLE gs_Publication_temp
DROP TABLE gs_Author_Publication_temp

/*
DROP TABLE gs_Author
DROP TABLE gs_Venue
DROP TABLE gs_Publication
DROP TABLE gs_Author_Publication*/
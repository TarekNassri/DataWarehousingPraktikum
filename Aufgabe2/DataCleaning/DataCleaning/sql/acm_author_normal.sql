INSERT INTO acm_Author_Clean(Vorname, Familienname, Institution, Author_ID)
SELECT Vorname_Clean, Familienname_Clean, Institution_Clean, Key_Out as Author_ID
FROM acm_Author_Institution
GROUP BY Vorname_Clean, Familienname_Clean, Institution_Clean, Key_Out


INSERT INTO acm_Author_Publication_Clean(Author_ID, Publication_ID, Position)
SELECT a.Key_Out, b.Publication_ID, b.Author_Position
FROM acm_Author_Institution a
JOIN acm_Author_Publication b ON a.Author_ID = b.Author_ID
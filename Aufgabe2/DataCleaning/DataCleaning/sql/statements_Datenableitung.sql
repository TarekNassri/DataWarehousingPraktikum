-- Queries to crosscheck whether person is author in two publications and they cite each other
-- before cleaning of authors we only found 272 self citations this way
-- SELECT * FROM acm_author_publication WHERE publication_id=285
-- SELECT * FROM acm_author_publication WHERE publication_id=86382
-- SELECT * FROM acm_citing_pub WHERE gets_cited_pub_id=285
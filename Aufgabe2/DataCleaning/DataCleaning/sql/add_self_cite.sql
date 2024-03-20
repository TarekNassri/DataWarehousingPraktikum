IF NOT EXISTS (
  SELECT * 
  FROM   sys.columns 
  WHERE  object_id = OBJECT_ID(N'[dbo].[acm_CitingPub]') 
         AND name = 'Selbstzitat'
)
ALTER TABLE acm_CitingPub ADD [Selbstzitat] BIT default 'FALSE';
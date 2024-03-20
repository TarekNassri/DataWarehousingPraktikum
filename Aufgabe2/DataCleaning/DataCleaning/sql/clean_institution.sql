CREATE OR ALTER FUNCTION dbo.clean_institution (@institution_name NVARCHAR(255), @pattern NVARCHAR(255))
RETURNS NVARCHAR(255)
AS
BEGIN
	RETURN 
		CASE WHEN LOWER(@institution_name) LIKE @pattern
		THEN
			SUBSTRING(
			@institution_name,
			PATINDEX(@pattern,LOWER(@institution_name)),
			CASE WHEN CHARINDEX(',',@institution_name,PATINDEX(@pattern,LOWER(@institution_name))) = 0 
			THEN 10000
			ELSE CHARINDEX(',',@institution_name,PATINDEX(@pattern,LOWER(@institution_name))) - PATINDEX(@pattern,LOWER(@institution_name)) END)
		ELSE NULL
		END
END;
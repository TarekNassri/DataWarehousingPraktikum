-- disable all constraints
EXEC sp_MSForEachTable "ALTER TABLE ? NOCHECK CONSTRAINT all"



-- enable all constraints
exec sp_MSForEachTable "ALTER TABLE ? WITH CHECK CHECK CONSTRAINT all"
/* Listing 1-6: CREATE statement for index on WidePosts table */

IF NOT EXISTS (SELECT 1
    FROM sys.indexes
    WHERE object_id = OBJECT_ID('dbo.WidePosts')
    AND name='ix_Posts_ownerUserID')
BEGIN
CREATE NONCLUSTERED INDEX IX_WidePosts_OwnerUserID
  ON dbo.WidePosts (OwnerUserID);
END;
GO
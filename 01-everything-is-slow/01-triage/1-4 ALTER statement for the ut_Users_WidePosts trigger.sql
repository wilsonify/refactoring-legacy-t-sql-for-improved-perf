/* Listing 1-4: ALTER statement for the ut_Users_WidePosts trigger */

/**************************************************************
  Object Description: Pushes user changes to the WidePosts table.
  Revision History:
  Date         Name     Label/PTS Description
  -----------  --------------   ---------- -------------------
  2019.05.12   LBohm           Initial Release
*****************************************************************
**/
ALTER TRIGGER [dbo].[ut_Users_WidePosts] ON [dbo].[Users]
FOR UPDATE
AS
SET NOCOUNT ON;
IF EXISTS
(
SELECT 1
FROM INSERTED i
INNER JOIN dbo.WidePosts wp ON i.id = wp.OwnerUserId
)
BEGIN
IF EXISTS
(
SELECT 1
FROM INSERTED i
INNER JOIN dbo.WidePosts wp ON i.id = wp.OwnerUserId
WHERE i.Age <> wp.Age
OR i.CreationDate <> wp.UserCreationDate
OR i.DisplayName <> wp.DisplayName
OR i.DownVotes <> wp.DownVotes
OR i.EmailHash <> wp.EmailHash
OR i.[Location] <> wp.[location]
OR i.Reputation <> wp.Reputation
OR i.UpVotes <> wp.UpVotes
OR i.[Views] <> wp.[Views]
OR i.WebsiteUrl <> wp.WebsiteUrl

)
BEGIN
UPDATE wp
SET 
wp.[AboutMe] = LEFT(i.AboutMe, 2000)
, wp.[Age] = i.Age
, wp.[UserCreationDate] = i.CreationDate
, wp.[DisplayName] = i.DisplayName
, wp.[DownVotes] = i.DownVotes
, wp.[EmailHash] = i.EmailHash
, wp.[LastAccessDate] = i.LastAccessDate
, wp.[Location] = i.[Location]
, wp.[Reputation] = i.Reputation
, wp.[UpVotes] = i.UpVotes
, wp.[Views] = i.[Views]
, wp.[WebsiteUrl] = i.WebsiteUrl
, wp.AccountID = i.AccountID
FROM dbo.WidePosts wp
INNER JOIN INSERTED i ON wp.OwnerUserId = i.id
WHERE i.Age <> wp.Age
OR i.CreationDate <> wp.UserCreationDate
OR i.DisplayName <> wp.DisplayName
OR i.DownVotes <> wp.DownVotes
OR i.EmailHash <> wp.EmailHash
OR i.[Location] <> wp.[location]
OR i.Reputation <> wp.Reputation
OR i.UpVotes <> wp.UpVotes
OR i.[Views] <> wp.[Views]
OR i.WebsiteUrl <> wp.WebsiteUrl;

END;
END;
GO

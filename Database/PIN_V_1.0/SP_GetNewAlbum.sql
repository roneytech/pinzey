USE GroupSendIt
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetNewAlbum' and schema_id = (select schema_id from sys.schemas where name = 'dbo'))
    DROP PROCEDURE dbo.[GetNewAlbum] 
GO
CREATE PROCEDURE [GetNewAlbum]
  @albumName nvarchar(250),
  @userId nvarchar(128)
AS
BEGIN
BEGIN TRANSACTION
	DECLARE @albumId BIGINT;
	SET @albumId = (SELECT MIN(Id) FROM Album WHERE AlbumName IS NULL);
	UPDATE Album 
	  SET AlbumName = @albumName, 
	      DateCreated = GetDate(),
	      UserId = @userId
	WHERE Id = @albumId;
	SELECT AlbumPin FROM Album WHERE Id = @albumId;
COMMIT TRANSACTION
END
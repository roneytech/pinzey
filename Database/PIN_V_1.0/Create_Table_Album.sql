USE [GroupSendIt]
GO

/****** Object:  Table [dbo].[Album]    Script Date: 05/10/2015 1:44:07 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'u' AND name = 'Album' and schema_id = (select schema_id from sys.schemas where name = 'dbo'))
	DROP TABLE [dbo].[Album] 
GO

CREATE TABLE [dbo].[Album](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[AlbumName] [nvarchar](250) NULL,
	[DateCreated] [datetime2](7) NOT NULL CONSTRAINT [DF_Album_DateCreated]  DEFAULT (getdate()),
	[AlbumPin] [varchar](50) NOT NULL,
	[UserId] [nvarchar](128) NULL,
 CONSTRAINT [AK_ALBUM_AlbumPin] UNIQUE NONCLUSTERED 
(
	[AlbumPin] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO



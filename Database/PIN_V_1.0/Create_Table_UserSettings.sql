USE [GroupSendIt]
GO

/****** Object:  Table [dbo].[AccountSettings]    Script Date: 11/10/2015 6:05:38 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[AccountSettings](
	[UserSettingId] [bigint] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[SettingName] [varchar](50) NOT NULL,
	[SettingValue] [varchar](50) NOT NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[AccountSettings] ADD  CONSTRAINT [DF_AccountSettings_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO



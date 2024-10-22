USE [ImmidartDMS]
GO
/****** Object:  User [EnterpriseDMS]    Script Date: 29-05-2017 16:11:53 ******/
CREATE USER [EnterpriseDMS] FOR LOGIN [EnterpriseDMS] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [IDDev]    Script Date: 29-05-2017 16:11:53 ******/
CREATE USER [IDDev] FOR LOGIN [IDDev] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [IDLeads]    Script Date: 29-05-2017 16:11:53 ******/
CREATE USER [IDLeads] FOR LOGIN [IDLeads] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [EnterpriseDMS]
GO
/****** Object:  UserDefinedFunction [dbo].[UDF_Split]    Script Date: 29-05-2017 16:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[UDF_Split]
(
  @delimited nvarchar(max),
  @delimiter nvarchar(100)
) RETURNS @t TABLE
(
-- Id column can be commented out, not required for sql splitting string
  id int identity(1,1), -- I use this column for numbering splitted parts
  val nvarchar(max)
)
AS
BEGIN
  declare @xml xml
  set @xml = N'<root><r>' + replace(@delimited,@delimiter,'</r><r>') + '</r></root>'

  insert into @t(val)
  select
    r.value('.','varchar(max)') as item
  from @xml.nodes('//root/r') as records(r)

  RETURN
END

GO
/****** Object:  Table [dbo].[Client]    Script Date: 29-05-2017 16:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Client](
	[ClientID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](200) NULL,
	[Email] [varchar](150) NULL,
	[MaxSizeLimitPerFile] [int] NULL,
	[MaxSizeBufferLimit] [int] NULL,
	[MaxSizeLimit] [int] NULL,
	[IsActive] [bit] NULL,
	[CreatedDate] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[ClientID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DocumentDetail]    Script Date: 29-05-2017 16:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DocumentDetail](
	[DocumentDetailID] [varchar](255) NOT NULL,
	[ClientID] [int] NOT NULL,
	[DocumentModuleID] [int] NOT NULL,
	[DocumentTypeID] [int] NOT NULL,
	[FileName] [nvarchar](150) NULL,
	[FileType] [varchar](5) NULL,
	[FileSize] [int] NULL,
	[DirectoryName] [varchar](10) NULL,
	[IsDeleted] [bit] NULL,
	[IsArchived] [bit] NULL,
	[IsPrivate] [bit] NULL,
	[MimeType] [varchar](50) NULL,
	[UploadedDate] [date] NULL,
	[UploadedBy] [varchar](100) NULL,
 CONSTRAINT [PK__Document__9885B80CAA8478DF] PRIMARY KEY CLUSTERED 
(
	[DocumentDetailID] ASC,
	[ClientID] ASC,
	[DocumentModuleID] ASC,
	[DocumentTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DocumentModule]    Script Date: 29-05-2017 16:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DocumentModule](
	[DocumentModuleID] [int] IDENTITY(1,1) NOT NULL,
	[ClientID] [int] NULL,
	[Name] [varchar](100) NULL,
	[IsActive] [bit] NULL,
	[CreatedDate] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[DocumentModuleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DocumentType]    Script Date: 29-05-2017 16:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DocumentType](
	[DocumentTypeID] [int] IDENTITY(1,1) NOT NULL,
	[DocumentModuleID] [int] NULL,
	[ClientID] [int] NULL,
	[Name] [varchar](100) NULL,
	[IsActive] [bit] NULL,
	[CreatedDate] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[DocumentTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ServiceAuth]    Script Date: 29-05-2017 16:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ServiceAuth](
	[ServiceAuthID] [int] IDENTITY(1,1) NOT NULL,
	[ClientID] [int] NULL,
	[AccountName] [varchar](100) NULL,
	[Password] [varchar](100) NULL,
	[Salt] [varchar](5) NULL,
	[NextPasswordReset] [date] NULL,
	[IsActive] [bit] NULL,
	[CreatedDate] [date] NULL,
 CONSTRAINT [PK__ServiceA__512519C0DA705218] PRIMARY KEY CLUSTERED 
(
	[ServiceAuthID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ServiceAuthLog]    Script Date: 29-05-2017 16:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ServiceAuthLog](
	[ServiceAuthLogID] [int] IDENTITY(1,1) NOT NULL,
	[ServiceAuthID] [int] NOT NULL,
	[ClientID] [int] NOT NULL,
	[AccountName] [varchar](100) NULL,
	[AccessTime] [datetime] NULL,
	[IPAddress] [varchar](15) NULL,
	[RequestHeader] [varchar](max) NULL,
	[WebMethodName] [varchar](10) NULL,
	[ResponseTime] [datetime] NULL,
	[ResponseStatus] [bit] NULL,
	[ErrorDescription] [varchar](max) NULL,
 CONSTRAINT [PK__ServiceA__48F696C917364532] PRIMARY KEY CLUSTERED 
(
	[ServiceAuthLogID] ASC,
	[ServiceAuthID] ASC,
	[ClientID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[usp_AddApiLog]    Script Date: 29-05-2017 16:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_AddApiLog]
(
@LogDate DATETIME,
@LogEntry NVARCHAR(MAX)
)
As
BEGIN
	SET NOCOUNT ON;
	INSERT INTO [Log](LogDate,LogEntry)VALUES(@LogDate,@LogEntry) 
END

GO
/****** Object:  StoredProcedure [dbo].[USP_DMSDocumentDelete]    Script Date: 29-05-2017 16:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		Sharath
-- Create date: 07 July 2015
-- Description:	File Delete Process
-- =============================================


CREATE PROCEDURE [dbo].[USP_DMSDocumentDelete]
(
	@AccountName varchar(100),
	@Password varchar(100),
	@DocumentDetailID varchar(255),
	@UploadedBy Varchar(100)
)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @CLIENT_ID int
	DECLARE @Count int
	DECLARE @Category varchar(100)
	DECLARE @Success int = 1
	DECLARE @Failure int = 0
	DECLARE @Invalid_ID int = -5
	DECLARE @No_Permission int = -1
	DECLARE @Is_Active int = 1
	DECLARE @Deleted int = 1

	BEGIN TRY

	SELECT @CLIENT_ID = ClientID FROM ServiceAuth WHERE  AccountName = @AccountName AND [Password] = @Password AND IsActive = @Is_Active


	IF @CLIENT_ID IS NOT NULL 
	BEGIN
		 SELECT @Count = COUNT(*) FROM DocumentDetail WHERE DocumentDetailID = @DocumentDetailID 
		 IF @Count > 0
		 BEGIN    
		
				UPDATE DocumentDetail SET IsDeleted = @Deleted,
										  UploadedBy = @UploadedBy
								    WHERE DocumentDetailID = @DocumentDetailID 

				SELECT @Category = DM.Name 
				FROM DocumentDetail DD INNER JOIN DocumentModule DM
				ON  DD.DocumentModuleID = DM.DocumentModuleID 
				WHERE DD.DocumentDetailID = @DocumentDetailID

				SELECT 
					@Category DocumentModule,
					DD.ClientID,
					DD.[FileName],
					DD.FileType,
					DD.IsPrivate,
					DD.DocumentDetailID,				
					DD.DocumentModuleID ,
					DD.DocumentTypeID,				
					DD.DirectoryName,
					DD.MimeType,
					@Success [Status]	
				FROM 
					DocumentDetail DD 
				WHERE DD.DocumentDetailID = @DocumentDetailID 
				
		 END
		 ELSE
		 BEGIN
				SELECT @Invalid_ID [Status];
		 END
	END
	ELSE
	IF @CLIENT_ID IS  NULL
	BEGIN
				SELECT @No_Permission [Status];
	END 
	
	END TRY
	BEGIN CATCH
			SELECT @Failure		
	END CATCH

	    
END










GO
/****** Object:  StoredProcedure [dbo].[USP_DMSDocumentDetailsGet]    Script Date: 29-05-2017 16:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Shanmugapriya Murugeshan
-- Create date: 02 July 2015
-- Description:	Get Document details 
-- =============================================
CREATE PROCEDURE [dbo].[USP_DMSDocumentDetailsGet] 
(
    @AccountName varchar(100),
	@Password varchar(100),
	@DocumentGuid varchar(255)
)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @Success int = 1
	DECLARE @Failure int = 0
	DECLARE @No_Permission int = -1
	DECLARE @Category varchar(100)
	DECLARE @Invalid_Document int = -2

	BEGIN TRY

	IF EXISTS(SELECT ClientID FROM ServiceAuth WHERE  AccountName = @AccountName AND [Password] = @Password AND IsActive = 1)
	BEGIN					
			--SELECT @Category = DM.Name FROM DocumentDetail DD INNER JOIN DocumentModule DM ON  DD.DocumentModuleID = DM.DocumentModuleID WHERE DD.DocumentDetailID = @DocumentGuid
			
			IF EXISTS ( SELECT * FROM DocumentDetail WHERE DocumentDetailID = @DocumentGuid and (IsDeleted=0 or IsDeleted is null))
			BEGIN
			SELECT 
				@Category DocumentModule,
				DD.ClientID,
				DD.[FileName],
				DD.FileType,
				DD.IsPrivate,
				--Modified by chandan on 23-02-2017 for to get file size
				DD.FileSize,
				DD.DocumentDetailID,				
				DD.DocumentModuleID ,
				DD.DocumentTypeID,		
				DT.Name DocumentType,
				DD.DirectoryName,
				DD.MimeType,
				@Success [Status],
				DD.UploadedBy 
			FROM 
				DocumentDetail DD 
			left JOIN DocumentType DT
			ON DT.DocumentTypeID = DD.DocumentTypeID
			WHERE DD.DocumentDetailID = @DocumentGuid
			END
			ELSE
			BEGIN
				SELECT @Invalid_Document [Status]
			END

	END
	ELSE
	BEGIN
		SELECT @No_Permission [Status]
	END

	END TRY
	BEGIN CATCH
			SELECT @Failure [Status]
	END CATCH
END


GO
/****** Object:  StoredProcedure [dbo].[USP_DMSDocumentDetailsGetList]    Script Date: 29-05-2017 16:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Chandan Jha
-- Create date: 23 Feb 2017
-- Description:	Get Document details List 
-- =============================================
CREATE  PROCEDURE [dbo].[USP_DMSDocumentDetailsGetList] 
(
    @AccountName varchar(100),
	@Password varchar(100),
	@DocumentGuid varchar(max)
)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @Success int = 1
	DECLARE @Failure int = 0
	DECLARE @No_Permission int = -1
	DECLARE @Category varchar(100)
	DECLARE @Invalid_Document int = -2

	BEGIN TRY

	IF EXISTS(SELECT ClientID FROM ServiceAuth WHERE  AccountName = @AccountName AND [Password] = @Password AND IsActive = 1)
	BEGIN					
			--SELECT @Category = DM.Name FROM DocumentDetail DD INNER JOIN DocumentModule DM ON  DD.DocumentModuleID = DM.DocumentModuleID WHERE DD.DocumentDetailID = @DocumentGuid
			
			IF EXISTS ( SELECT * FROM DocumentDetail WHERE DocumentDetailID in(select val from dbo.UDF_Split(@DocumentGuid,',')) and (IsDeleted=0 or IsDeleted is null))
			BEGIN
			SELECT 
				@Category DocumentModule,
				DD.ClientID,
				DD.[FileName],
				DD.FileType,
				DD.IsPrivate,
				DD.FileSize,
				DD.DocumentDetailID,				
				DD.DocumentModuleID ,
				DD.DocumentTypeID,		
				DT.Name DocumentType,
				DD.DirectoryName,
				DD.MimeType,
				@Success [Status],
				DD.UploadedBy 
			FROM 
				DocumentDetail DD 
			left JOIN DocumentType DT
			ON DT.DocumentTypeID = DD.DocumentTypeID
			WHERE DD.DocumentDetailID in(select val from dbo.UDF_Split(@DocumentGuid,','))
			END
			ELSE
			BEGIN
				SELECT @Invalid_Document [Status]
			END

	END
	ELSE
	BEGIN
		SELECT @No_Permission [Status]
	END

	END TRY
	BEGIN CATCH
			SELECT @Failure [Status]
			--Select ERROR_NUMBER();
			--Select ERROR_LINE();
			--Select ERROR_MESSAGE();
			
	END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[USP_DMSDocumentDetailsInsert]    Script Date: 29-05-2017 16:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		Sharath
-- Create date: 01 July 2015
-- Description:	File Upload Process
-- =============================================
CREATE PROCEDURE [dbo].[USP_DMSDocumentDetailsInsert]
(
	@AccountName varchar(100),
	@Password varchar(100),
	@DocumentType varchar(100),
	@FileName nvarchar(150),
	@FileType varchar(5),
	@FileSize int,
	@DirectoryName varchar(10),
	@IsPrivate int,
	@MimeType varchar(50),
	@UploadedBy varchar(100),
	@DocumentModuleID int out,
	@DocumentTypeID int out,
	@DocumentDetailID varchar(255) out,
	@Client int out
)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @CLIENT_ID int
	DECLARE @Document_Type_ID int=0
	DECLARE @Document_Module_ID int=0
	
	DECLARE @Success int = 1
	DECLARE @Failure int = 0
	DECLARE @No_Permission int = -1
	DECLARE @Invalid_Document int = -2
	DECLARE @File_Size_Exceeds int = -3
	DECLARE @MAX_File_Size int
	DECLARE @NEW_ID varchar(255) = NEWID()

	

	SELECT @CLIENT_ID = ClientID FROM ServiceAuth WHERE  AccountName = @AccountName AND [Password] = @Password AND IsActive = 1
	

	IF @CLIENT_ID IS NOT NULL 
	BEGIN
		 --IF EXISTS(SELECT DocumentTypeID FROM DocumentType WHERE ClientID = @CLIENT_ID AND Name = @DocumentType AND IsActive = 1)
		 --BEGIN
				

			       --SELECT @Document_Type_ID = DocumentTypeID,@Document_Module_ID = DocumentModuleID  FROM DocumentType WHERE ClientID = @CLIENT_ID AND Name = @DocumentType AND IsActive = 1

				 
				   SELECT @MAX_File_Size = MaxSizeLimitPerFile FROM Client WHERE ClientID = @CLIENT_ID  AND IsActive = 1 
				   
				   IF (@FileSize > @MAX_File_Size)
				   BEGIN
						RETURN @File_Size_Exceeds;
				   END
				   ELSE
				   
				   BEGIN   
				   	SET @DocumentDetailID = @NEW_ID
										SET @DocumentModuleID = @Document_Module_ID
										SET @DocumentTypeID = @Document_Type_ID 
										SET @Client = @CLIENT_ID
						   BEGIN TRY
								BEGIN TRANSACTION;  
								INSERT INTO [dbo].[DocumentDetail]
									   ([DocumentDetailID]
									   ,[ClientID]
									   ,[DocumentModuleID]
									   ,[DocumentTypeID]
									   ,[FileName]
									   ,[FileType]
									   ,[FileSize]
									   ,[DirectoryName]
									   ,[IsPrivate]
									   ,[MimeType]
									   ,[UploadedDate]
									   ,[UploadedBy])
								  VALUES(
										   @NEW_ID
										  ,@CLIENT_ID
										  ,@Document_Module_ID
										  ,@Document_Type_ID
										  ,@FileName
										  ,@FileType
										  ,@FileSize
										  ,@DirectoryName
										  ,@IsPrivate
										  ,@MimeType
										  ,GETDATE()
										  ,@UploadedBy
										)
									
									COMMIT TRANSACTION;
									SELECT @Success
							END TRY
							BEGIN CATCH
								IF @@TRANCOUNT > 0
								ROLLBACK TRANSACTION;
								SELECT @Failure
							END CATCH
					END
		 --END
		 --ELSE
		 --BEGIN
			--SELECT @Invalid_Document;
		 --END
		 END
	ELSE IF @CLIENT_ID IS NULL
	BEGIN
		SELECT @No_Permission;
	END 
	ELSE
	BEGIN
		SELECT @Success;
	END 

	






    
END





GO
/****** Object:  StoredProcedure [dbo].[USP_DMSFilePathGet]    Script Date: 29-05-2017 16:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[USP_DMSFilePathGet]
(
	@DocumentDetailID varchar(255)
)
AS
BEGIN

SELECT 
ClientID,
DocumentModuleID,
DocumentTypeID,
[FileName],
FileType,
FileSize,
DirectoryName,
IsDeleted,
IsArchived,
IsPrivate,
MimeType

FROM DocumentDetail WITH(NOLOCK) where DocumentDetailID=@DocumentDetailID

END


GO
/****** Object:  StoredProcedure [dbo].[USP_DMSServiceAuthLogInsert]    Script Date: 29-05-2017 16:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Bharat
-- Create date: 13 July 2015
-- Description:	Web API Logging
-- =============================================
CREATE PROCEDURE [dbo].[USP_DMSServiceAuthLogInsert]
(
    @AccountName VARCHAR(100)= '',
	@Password VARCHAR(100)='',
	@AccessTime DATETIME,
	@IPAddress VARCHAR(15),
	@RequestHeader VARCHAR(MAX),
	@WebMethodName VARCHAR(10),
	@ResponseTime DATETIME,
	@ResponseStatus BIT,
	@ErrorDescription VARCHAR(MAX)
		)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @CLIENT_ID INT, @SERVICE_AUTH_ID INT, @Success INT = 1, @Faliure INT = 0

	BEGIN TRY

	SELECT @CLIENT_ID = ClientID,
		   @SERVICE_AUTH_ID=ServiceAuthID 
    FROM ServiceAuth
	WHERE  AccountName = @AccountName AND [Password] = @Password 

	IF @CLIENT_ID IS NOT NULL 
	BEGIN
	INSERT INTO ServiceAuthLog(ServiceAuthID,
							   ClientID,
							   AccountName,
							   AccessTime,
	                           IPAddress,
							   RequestHeader,
							   WebMethodName,
							   ResponseTime,
							   ResponseStatus,
							   ErrorDescription
							  )
						      VALUES
							  (
							   @SERVICE_AUTH_ID,
							   @CLIENT_ID,
							   @AccountName,
							   @AccessTime,
							   @IPAddress,
							   @RequestHeader,
							   @WebMethodName,
							   @ResponseTime,
							   @ResponseStatus,
							   @ErrorDescription) 
	END
	ELSE
	IF @CLIENT_ID IS  NULL
	BEGIN
	INSERT INTO ServiceAuthLog(ServiceAuthID,
							   ClientID,
							   AccountName,
							   AccessTime,
							   IPAddress,
							   RequestHeader,
							   WebMethodName,
							   ResponseTime,
							   ResponseStatus,
							   ErrorDescription
	 						   )
							   VALUES
							   (
							   0,
							   0,
							   @AccountName,
							   @AccessTime,
							   @IPAddress,
							   @RequestHeader,
							   @WebMethodName,
							   @ResponseTime,
							   @ResponseStatus,
							   @ErrorDescription) 
	END 
	END TRY
	BEGIN CATCH
			SELECT  @Faliure
	END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[USP_GetDocumnetDetail]    Script Date: 29-05-2017 16:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		chandan Jha
-- Create date: 26 May 2017
-- Description:	Get Document Details based on the Document DetailID
-- =============================================
CREATE PROCEDURE [dbo].[USP_GetDocumnetDetail] 
(
    
	@DocumentGuid varchar(max),
	@AccountName varchar(100),
	@APIUserPassword varchar(100)

)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @Success int = 1
	DECLARE @Failure int = 0
	DECLARE @No_Permission int = -1
	DECLARE @Category varchar(100)
	DECLARE @Invalid_Document int = -2

	BEGIN TRY
	    select DocumentDetailID,
               ClientID,
               DocumentModuleID,
               DocumentTypeID
               FileName,
               FileType,
               FileSize,
               DirectoryName,
               IsDeleted,
               MimeType 
               from DocumentDetail where  DocumentDetailID in(select val from UDF_Split(@DocumentGuid,',')) 
			   and ClientID= (select top 1 ClientID from ServiceAuth where AccountName=@AccountName and [Password]=@APIUserPassword and Isactive=1)

			   return @Success 

	END TRY
	BEGIN CATCH
			return @Failure 
	END CATCH
END


GO

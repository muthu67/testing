USE [ImmidartIdentitySystem]
GO
/****** Object:  User [EnterpriseIS]    Script Date: 30-05-2017 17:10:31 ******/
CREATE USER [EnterpriseIS] FOR LOGIN [EnterpriseIS] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [IDDev]    Script Date: 30-05-2017 17:10:31 ******/
CREATE USER [IDDev] FOR LOGIN [IDDev] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [IDLeads]    Script Date: 30-05-2017 17:10:31 ******/
CREATE USER [IDLeads] FOR LOGIN [IDLeads] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [EnterpriseIS]
GO
ALTER ROLE [db_owner] ADD MEMBER [IDLeads]
GO
/****** Object:  UserDefinedTableType [dbo].[UserClaim]    Script Date: 30-05-2017 17:10:31 ******/
CREATE TYPE [dbo].[UserClaim] AS TABLE(
	[UserClaimID] [nvarchar](256) NULL,
	[UserID] [nvarchar](256) NULL,
	[ProductID] [nvarchar](256) NULL,
	[ClaimType] [varchar](max) NULL,
	[ClaimValue] [varchar](max) NULL,
	[CreatedDate] [varchar](255) NULL,
	[CreatedBy] [varchar](128) NULL
)
GO
/****** Object:  Table [dbo].[APILog]    Script Date: 30-05-2017 17:10:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[APILog](
	[APILogID] [nvarchar](128) NOT NULL,
	[APIUserID] [nvarchar](128) NOT NULL,
	[Request] [nvarchar](max) NULL,
	[RequestTime] [datetime] NULL,
	[Response] [nvarchar](max) NULL,
	[ResponseTime] [datetime] NULL,
 CONSTRAINT [PK_APILog] PRIMARY KEY CLUSTERED 
(
	[APILogID] ASC,
	[APIUserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[APIUser]    Script Date: 30-05-2017 17:10:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[APIUser](
	[APIUserID] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_AppUser_APIUser]  DEFAULT (newid()),
	[Name] [nvarchar](150) NULL,
	[Password] [nvarchar](max) NULL,
	[IsActive] [bit] NULL,
	[DeactivatedDate] [datetime] NULL,
	[Remarks] [varchar](250) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](128) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](128) NULL,
 CONSTRAINT [PK_APIUser] PRIMARY KEY CLUSTERED 
(
	[APIUserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[App]    Script Date: 30-05-2017 17:10:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[App](
	[AppID] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_App_AppID]  DEFAULT (newid()),
	[Name] [nvarchar](256) NULL,
	[Code] [nvarchar](256) NULL,
	[WebUrl] [nvarchar](256) NULL,
	[MobileUrl] [nvarchar](256) NULL,
	[ContactEmail] [nvarchar](256) NULL,
	[IPAddress] [varchar](150) NULL,
	[IsActive] [bit] NOT NULL DEFAULT ((1)),
	[DeactivatedDate] [datetime] NULL,
	[IsTwoFactor] [bit] NULL,
	[SecretKey] [nvarchar](max) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](128) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](128) NULL,
 CONSTRAINT [PK_App] PRIMARY KEY CLUSTERED 
(
	[AppID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AppUser]    Script Date: 30-05-2017 17:10:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AppUser](
	[AppUserID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_AppUser_AppUserID]  DEFAULT (newid()),
	[AppID] [uniqueidentifier] NOT NULL,
	[UserID] [uniqueidentifier] NOT NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](128) NULL,
 CONSTRAINT [PK__AppUser] PRIMARY KEY CLUSTERED 
(
	[AppUserID] ASC,
	[AppID] ASC,
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AppUserClaim]    Script Date: 30-05-2017 17:10:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AppUserClaim](
	[AppUserClaimID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_AppUserClaim_AppUserClaimID]  DEFAULT (newid()),
	[UserID] [nvarchar](128) NOT NULL,
	[AppID] [nvarchar](128) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](128) NULL,
 CONSTRAINT [PK__AppUserClaim] PRIMARY KEY CLUSTERED 
(
	[AppUserClaimID] ASC,
	[UserID] ASC,
	[AppID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PasswordHistory]    Script Date: 30-05-2017 17:10:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PasswordHistory](
	[UserId] [uniqueidentifier] NOT NULL,
	[EmailId] [nvarchar](256) NULL,
	[Password] [nvarchar](max) NULL,
	[CreatedDate] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TwoFactorAuthentication]    Script Date: 30-05-2017 17:10:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TwoFactorAuthentication](
	[TwoFactorAuthenticationID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_TFA_TwoFactorAuthenticationID]  DEFAULT (newid()),
	[UserID] [uniqueidentifier] NOT NULL,
	[ImageID] [uniqueidentifier] NULL,
	[ImageName] [varchar](128) NULL,
	[IsActive] [bit] NOT NULL CONSTRAINT [DF_TFA_IsActive]  DEFAULT ((1)),
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](128) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](128) NULL,
 CONSTRAINT [PK__TwoFactorAuthentication] PRIMARY KEY CLUSTERED 
(
	[TwoFactorAuthenticationID] ASC,
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[User]    Script Date: 30-05-2017 17:10:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[User](
	[UserID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_User_UserID]  DEFAULT (newid()),
	[FirstName] [nvarchar](256) NULL,
	[LastName] [nvarchar](150) NULL,
	[Email] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NULL,
	[TwoFactorEnabled] [bit] NULL,
	[IsActive] [bit] NOT NULL CONSTRAINT [DF_User_IsActive]  DEFAULT ((1)),
	[AccessedFailedCount] [tinyint] NULL,
	[IsLockedOut] [bit] NULL,
	[LockedOn] [datetime] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](128) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](128) NULL,
	[MiddleName] [nvarchar](150) NULL,
	[ResetToken] [uniqueidentifier] NULL,
	[ResetTokenSentOn] [datetime] NULL,
	[IsDefaultPwdChange] [bit] NULL,
 CONSTRAINT [PK__User__1788CCAC44CA0419] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[USP_ForgotPasswordGetName]    Script Date: 30-05-2017 17:10:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_ForgotPasswordGetName]
(
	@EmailId NVARCHAR(128)
)
AS
BEGIN
SET NOCOUNT ON;
	DECLARE @Success INT = 1,
			@Failure INT = 0			

	IF EXISTS(SELECT 1 FROM [User] WITH(NOLOCK) WHERE Email = @EmailId and IsActive=1)
	BEGIN
	Select [FirstName], [LastName],
	       [PasswordHash] as 'Password' from  [User]	
	where Email = @EmailId
	  return @Success
		END
	ELSE 
	BEGIN 
		RETURN @Failure 
	END
SET NOCOUNT OFF;
END


GO
/****** Object:  StoredProcedure [dbo].[USP_ForgotPasswordUpdatePassword]    Script Date: 30-05-2017 17:10:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_ForgotPasswordUpdatePassword]
(
	@EmailId NVARCHAR(128),
	@Password NVARCHAR(MAX)
)
AS
BEGIN
SET NOCOUNT ON;
	DECLARE @Success INT = 1,
			@Failure INT = 0			

	IF EXISTS(SELECT 1 FROM [User] WITH(NOLOCK) WHERE Email = @EmailId and IsActive=1)
	BEGIN
	update [User]
	set [PasswordHash]=@Password
	where Email = @EmailId
	  return @Success
		END
	ELSE 
	BEGIN 
		RETURN @Failure 
	END
SET NOCOUNT OFF;
END


GO
/****** Object:  StoredProcedure [dbo].[USP_ForgotPasswordValidateEmail]    Script Date: 30-05-2017 17:10:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_ForgotPasswordValidateEmail]
(
	@EmailId NVARCHAR(128)
)
AS
BEGIN
SET NOCOUNT ON;
	DECLARE @Success INT = 1,
			@Failure INT = 0			

	IF EXISTS(SELECT 1 FROM [User] WITH(NOLOCK) WHERE Email = @EmailId and IsActive=1)
	BEGIN
		select cast(UserID as nvarchar(150)) as UserID from [User] where Email=@EmailId and IsActive=1
	    return @Success
		END
	ELSE 
	BEGIN 
		RETURN @Failure 
	END
SET NOCOUNT OFF;
END


GO
/****** Object:  StoredProcedure [dbo].[USP_InsertUser]    Script Date: 30-05-2017 17:10:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Rahul Hemadri
-- Create date: 12-04-2017
-- Description:	To insert User using Jobs
-- =============================================
CREATE PROCEDURE [dbo].[USP_InsertUser]
	@FirstName nvarchar(256),
	@LastName nvarchar(150),
	@Email nvarchar(256),
	@MiddleName nvarchar(150),
	@PhoneNumber nvarchar(MAX),
	@CreatedBy varchar(128)

AS
BEGIN
	DECLARE @UserID uniqueidentifier
	SET NOCOUNT ON;

	INSERT into [User] 
	(UserID
	,FirstName
	,LastName
	,Email
	,MiddleName
	,PhoneNumber
	,CreatedBy
	,CreatedDate
	)
	VALUES
	(newid()
	,@FirstName
	,@LastName
	,@Email
	,@MiddleName
	,@PhoneNumber
	,@CreatedBy
	,GETUTCDATE()
	)

	set @UserID = (SELECT UserID from [User] where Email = @Email) 

	SELECT @UserID as UserID

    
	
END

GO
/****** Object:  StoredProcedure [dbo].[USP_PasswordHistoryCheck]    Script Date: 30-05-2017 17:10:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		CS PANDA
-- Create date: 22-05-2017
-- Description:	Password check and insert. 
-- =============================================
CREATE PROCEDURE [dbo].[USP_PasswordHistoryCheck] 
@UserId uniqueidentifier,
@EmailId nvarchar(256),
@Password nvarchar(max)
AS
BEGIN
BEGIN TRY
	SET NOCOUNT ON;
	Declare @RecordCount int;
	DECLARE @Success int = 1,@Exist int =2, @Failure int = 0
	-- CASE WHEN @EmailId IS NULL THEN select Email from [User] where UserID=@UserId Else @EmailId='' END
	--Added for forget password page
	set @EmailId=CASE WHEN @EmailId IS NULL THEN (select Distinct(Email) from [User] where UserID=@UserId) Else @EmailId END
	IF NOT EXISTS(SELECT 1 FROM PasswordHistory WHERE [Password]=@Password AND UserId=@UserId AND EmailId=@EmailId)
	BEGIN
	--Count no of records .
	 SELECT @RecordCount=COUNT(UserId) FROM PasswordHistory WHERE UserId=@UserId AND EmailId=@EmailId
        IF(@RecordCount>=5)
        BEGIN 
		--Delete oldest (top 1 record) from 5 password  record  
         DELETE  FROM PasswordHistory WHERE [Password] IN
         (SELECT TOP(1) [Password] FROM PasswordHistory  WHERE UserId=@UserId AND EmailId=@EmailId  ORDER BY CreatedDate ASC)
        END
		--after delete old record insert new record.
	 INSERT INTO PasswordHistory (UserId, EmailId, [Password], CreatedDate) VALUES (@UserId,@EmailId,@Password,GETUTCDATE())
	RETURN @Success
	END
	ELSE
	BEGIN
		RETURN @Exist
	END
END TRY
BEGIN CATCH
SELECT ERROR_MESSAGE()
RETURN @Failure
END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[USP_RegisteredProductInsertUpdate]    Script Date: 30-05-2017 17:10:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Shanmugapriya M
-- Create date: 09 Dec 2015
-- Description:	Registering Product
-- =============================================
Create PROCEDURE [dbo].[USP_RegisteredProductInsertUpdate]
(
	@ProductID uniqueidentifier = NULL,
	@Name nvarchar(256),
	@Code nvarchar(256),
	@WebUrl nvarchar(256),
	@MobileUrl nvarchar(256),
	@ContactEmail nvarchar(256),
	@IPAddress nvarchar(15),
	@SecretKey nvarchar(MAX),
	@SessionUser varchar(100),
	@IsUpdate bit
)
AS
BEGIN
	  DECLARE @Success int = 1, @Failure int = 0

	  BEGIN TRY
		  SET NOCOUNT ON;
		  IF @IsUpdate = 0
		  BEGIN
			   INSERT INTO RegisteredProduct 
				(
					Name,
					Code,
					WebUrl,
					MobileUrl,
					ContactEmail,
					IPAddress,
					SecretKey,
					CreatedBy,
					CreatedDate
				)
				VALUES
				(
					@Name,
					@Code,
					@WebUrl,
					@MobileUrl,
					@ContactEmail,
					@IPAddress,
					@SecretKey,
					@SessionUser,
					GETUTCDATE()
				)
			END
			ELSE
			BEGIN
				UPDATE RegisteredProduct 
					SET Name		 = @Name,
						Code		 = @Code,
						WebUrl		 = @WebUrl,
						MobileUrl	 = @MobileUrl,
						ContactEmail = @ContactEmail,
						IPAddress	 = @IPAddress,
						SecretKey	 = @SecretKey,
						UpdatedBy	 = @SessionUser ,				
						CreatedDate	 = GETUTCDATE()
					WHERE ProductID	 = @ProductID
			END
			RETURN @Success
		END TRY
		BEGIN CATCH
			RETURN @Failure
		ENd CATCH
END


GO
/****** Object:  StoredProcedure [dbo].[USP_RegisteredUserAuthenticate]    Script Date: 30-05-2017 17:10:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Shanmugapriya.M
-- Create date: 09 Dec 2015
-- Description:	Authenticate User
-- =============================================
CREATE PROCEDURE [dbo].[USP_RegisteredUserAuthenticate]
(
	@UserName nvarchar(256),
	@Password nvarchar(max),
	@SecretKey nvarchar(256)
)
AS
BEGIN
	SET NOCOUNT ON;

   DECLARE  @ProductID uniqueidentifier,
			@UserID uniqueidentifier,
			@ClaimCount int,
			@Success int = 1,
			@Failure int = 0,
			@Not_Registered_Product int = -1,
			@Not_Registered_User int = -2,
			@Not_Registered_ProductUser int = -4

	BEGIN TRY
		SELECT @ProductID =  ProductID FROM RegisteredProduct where SecretKey = @SecretKey
		SELECT @UserID = UserID FROM [User] where Email = @UserName  AND PasswordHash = @Password
		Select @ClaimCount=Count(*) from UserClaim where UserID=@UserID and ProductID=@ProductID 
		
		IF @ProductID IS NULL
		BEGIN
			RETURN @Not_Registered_Product
		END

		IF @UserID IS NULL
		BEGIN
			RETURN @Not_Registered_User
		END

		IF (@ClaimCount IS NULL or @ClaimCount=0)
		BEGIN
			RETURN @Not_Registered_ProductUser
		END
		
		SELECT UserID,ProductID, ClaimType,ClaimValue,CreatedBy,CreatedDate FROM UserClaim WHERE  UserID=@UserID and ProductID=@ProductID
		
		RETURN @Success
  END TRY
  BEGIN CATCH 
		RETURN @Failure
  END CATCH
END


GO
/****** Object:  StoredProcedure [dbo].[USP_UpdateUserClaims]    Script Date: 30-05-2017 17:10:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Rahul Hemadri
-- Create date: 02-05-2017
-- Description:	Update User Claims 
-- =============================================
CREATE PROCEDURE [dbo].[USP_UpdateUserClaims]
	@userid nvarchar(150)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	insert into AppUserClaim
	(
		AppUserClaimId,
		UserID,
		AppID,
		ClaimType,
		ClaimValue,
		CreatedDate,
		CreatedBy
	)
	values
	(
		NEWID(),
		@userid,
		'6350E685-9B90-4B95-A6CE-F23292D36181',
		'Role',
		'Manager',
		GETDATE(),
		'sa@immidartenterprise.com'
	)
END

GO
/****** Object:  StoredProcedure [dbo].[usp_UserClaimsInsertUpdate]    Script Date: 30-05-2017 17:10:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Shanmugapriya M
-- Create date: 10 Dec 2015
-- Description:	Insert Claims
-- =============================================
CREATE PROCEDURE  [dbo].[usp_UserClaimsInsertUpdate]
   @UserClaims UserClaim READONLY,
   @UserID uniqueidentifier,
   @ProductID uniqueidentifier,
   @SessionUser varchar(100),
   @IsUpdate bit

AS
BEGIN
	SET NOCOUNT ON;
	IF @IsUpdate = 0
	BEGIN

	INSERT INTO UserClaim
	(
		UserClaimID,
		UserID,
		ProductID,
		ClaimType,
		ClaimValue,
		CreatedBy,
		CreatedDate
	)
	SELECT 
		NEWID(),
		@UserID,
		@ProductID,
		ClaimType,
		ClaimValue,
		@SessionUser,
		GETUTCDATE()
	FROM
		@UserClaims 
	END
	ELSE
	BEGIN

		delete from UserClaim where UserID=@UserID and ProductID=@ProductID

		INSERT INTO UserClaim
	(
		UserClaimID,
		UserID,
		ProductID,
		ClaimType,
		ClaimValue,
		CreatedBy,
		CreatedDate
	)
	SELECT 
		NEWID(),
		@UserID,
		@ProductID,
		ClaimType,
		ClaimValue,
		@SessionUser,
		GETUTCDATE()
	FROM
		@UserClaims 
		--UPDATE UC
		--	SET UC.ClaimValue = SP.ClaimValue
		--FROM UserClaim UC
		--INNER JOIN 
		--	@UserClaims SP
		--ON SP.ClaimType = UC.ClaimType and SP.UserID=UC.UserID and UC.ProductID=SP.ProductID 
			--AND UserClaimID = UC.UserClaimID
	END

END




GO

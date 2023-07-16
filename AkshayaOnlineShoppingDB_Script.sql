USE [master]
GO
IF (EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE ('[' + name + ']' = N'AkshayaOS' OR name = N'AkshayaOS')))
DROP DATABASE QuickKartDB

CREATE DATABASE AkshayaOS
GO
Use AkshayaOS
GO

CREATE TABLE [dbo].[Admins] (
    [UserId]    VARCHAR (30) NOT NULL,
    [AdminName] VARCHAR (30) NOT NULL,
    [Password]  VARCHAR (12) NOT NULL,
    PRIMARY KEY CLUSTERED ([UserId] ASC)
)
GO

INSERT INTO Admins VALUES ('Admin','admin','Admin@123')
INSERT INTO Admins VALUES ('Admin2','admin','Admin@2516')
GO

CREATE TABLE [dbo].[Users] (
    [UserNo]       INT           IDENTITY (1, 1) NOT NULL,
    [UserName]     VARCHAR (30)  NOT NULL,
    [UserId]       VARCHAR (30)  NOT NULL,
    [Password]     VARCHAR (12)  NOT NULL,
    [MobileNumber] NUMERIC (10)  NOT NULL,
    [Address]      VARCHAR (255) NULL,
    PRIMARY KEY CLUSTERED ([UserNo] ASC),
    UNIQUE NONCLUSTERED ([MobileNumber] ASC),
    UNIQUE NONCLUSTERED ([UserId] ASC)
)
GO
INSERT INTO Users VALUES('Durga',	'Durga251614',	'Durga@2516',	9963616878,	'Machayapalem')
GO

CREATE TABLE [dbo].[Products] (
    [ProductId]           INT           IDENTITY (100, 1) NOT NULL,
    [ProductName]         VARCHAR (30)  NOT NULL,
    [Price]               INT           NOT NULL,
    [Discount]            INT           NOT NULL,
    [AvailablePieces]     INT           NOT NULL,
    [PictureFileLocation] VARCHAR (200) NULL,
    [Description]         VARCHAR (500) NULL,
    PRIMARY KEY CLUSTERED ([ProductId] ASC)
)
GO

INSERT INTO Products VALUES('Redmi 6A',	5000,	5,	3,	'E:/Pictures', 'RAM')
INSERT INTO Products VALUES('SANSUI', 5000,	2,	4,	'E://assets/images', '32 inches TV, Dual Speakers')
INSERT INTO Products VALUES('Surabhi Supremo',	3000,	5,	16,	'....',	'Table fan, Height : 3 feet, 3 step regulator(speed controller)')
GO

CREATE TABLE [dbo].[DeliveryMans] (
    [DeliveryManNo] INT          IDENTITY (1, 1) NOT NULL,
    [DMName]        VARCHAR (30) NOT NULL,
    [DMId]          VARCHAR (30) NOT NULL,
    [Password]      VARCHAR (12) NOT NULL,
    [MobileNumber]  NUMERIC (10) NOT NULL,
    PRIMARY KEY CLUSTERED ([DeliveryManNo] ASC),
    UNIQUE NONCLUSTERED ([MobileNumber] ASC),
    UNIQUE NONCLUSTERED ([DMId] ASC)
)
GO

INSERT INTO DeliveryMans VALUES('Naga',	'Naga56789',	'Naga@2516',	7675059479)
INSERT INTO DeliveryMans VALUES('delivery',	'deliveryMan', 'delivery@123',	9632587410)
INSERT INTO DeliveryMans VALUES('dm',	'dm2516',	'dm@2516',	7894567891)
GO



CREATE TABLE [dbo].[PurchaseDetails] (
    [PurchaseId]      INT           IDENTITY (1, 1) NOT NULL,
    [UserNo]          INT           NOT NULL,
    [ProductId]       INT           NOT NULL,
    [DeliveryManNo]   INT           NOT NULL,
    [Quantity]        INT           NOT NULL,
    [TotalAmount]     INT           NOT NULL,
    [OrderedDate]     DATETIME      DEFAULT (getdate()) NULL,
    [ShippingAddress] VARCHAR (200) NULL,
    [OTP]             INT           NOT NULL,
    [Status]          VARCHAR (20)  NULL,
    PRIMARY KEY CLUSTERED ([PurchaseId] ASC),
    FOREIGN KEY ([UserNo]) REFERENCES [dbo].[Users] ([UserNo]),
    FOREIGN KEY ([ProductId]) REFERENCES [dbo].[Products] ([ProductId]),
    FOREIGN KEY ([DeliveryManNo]) REFERENCES [dbo].[DeliveryMans] ([DeliveryManNo]),
    CHECK ([Status]='Pending' OR [Status]='Delivered')
)
GO
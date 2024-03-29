USE [master]
GO
/****** Object:  Database [Project221]    Script Date: 7/22/2023 9:54:56 PM ******/
CREATE DATABASE [Project221]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Project221', FILENAME = N'D:\SQL2022\Update\MSSQL16.SQLEXPRESS\MSSQL\DATA\Project221.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Project221_log', FILENAME = N'D:\SQL2022\Update\MSSQL16.SQLEXPRESS\MSSQL\DATA\Project221_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [Project221] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Project221].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Project221] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Project221] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Project221] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Project221] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Project221] SET ARITHABORT OFF 
GO
ALTER DATABASE [Project221] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Project221] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Project221] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Project221] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Project221] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Project221] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Project221] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Project221] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Project221] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Project221] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Project221] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Project221] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Project221] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Project221] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Project221] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Project221] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Project221] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Project221] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Project221] SET  MULTI_USER 
GO
ALTER DATABASE [Project221] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Project221] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Project221] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Project221] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Project221] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Project221] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Project221] SET QUERY_STORE = ON
GO
ALTER DATABASE [Project221] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [Project221]
GO
/****** Object:  Table [dbo].[Customers]    Script Date: 7/22/2023 9:54:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[CustomerID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerName] [nvarchar](100) NULL,
	[CustomerAddress] [nvarchar](200) NULL,
	[CustomerPhone] [nvarchar](20) NULL,
	[IsActive] [bit] NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employees]    Script Date: 7/22/2023 9:54:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employees](
	[EmployeeID] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeName] [nvarchar](100) NULL,
	[Position] [nvarchar](50) NULL,
	[IsActive] [bit] NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Inventory]    Script Date: 7/22/2023 9:54:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inventory](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[ProductName] [nvarchar](100) NULL,
	[SupplierID] [int] NULL,
	[Quantity] [int] NULL,
	[UnitPrice] [money] NULL,
	[IsActive] [bit] NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 7/22/2023 9:54:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetails](
	[OrderDetailID] [int] IDENTITY(1,1) NOT NULL,
	[OrderID] [int] NULL,
	[ProductID] [int] NULL,
	[Quantity] [int] NULL,
	[UnitPrice] [money] NULL,
	[IsActive] [bit] NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 7/22/2023 9:54:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerID] [int] NULL,
	[OrderDate] [datetime] NULL,
	[TotalAmount] [money] NULL,
	[IsActive] [bit] NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 7/22/2023 9:54:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[ProductName] [nvarchar](100) NULL,
	[CategoryID] [int] NULL,
	[SupplierID] [int] NULL,
	[Quantity] [int] NULL,
	[UnitPrice] [money] NULL,
	[IsActive] [bit] NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
	[image] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductCategory]    Script Date: 7/22/2023 9:54:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductCategory](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](100) NULL,
	[IsActive] [bit] NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Profits]    Script Date: 7/22/2023 9:54:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Profits](
	[ProfitID] [int] IDENTITY(1,1) NOT NULL,
	[OrderID] [int] NULL,
	[Amount] [money] NULL,
	[IsActive] [bit] NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ProfitID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Suppliers]    Script Date: 7/22/2023 9:54:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Suppliers](
	[SupplierID] [int] IDENTITY(1,1) NOT NULL,
	[SupplierName] [nvarchar](100) NULL,
	[SupplierAddress] [nvarchar](200) NULL,
	[SupplierPhone] [nvarchar](20) NULL,
	[IsActive] [bit] NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[SupplierID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 7/22/2023 9:54:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](50) NULL,
	[Password] [nvarchar](100) NULL,
	[Role] [nvarchar](20) NULL,
	[IsActive] [bit] NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
	[EmployeeID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Customers] ON 

INSERT [dbo].[Customers] ([CustomerID], [CustomerName], [CustomerAddress], [CustomerPhone], [IsActive], [CreatedDate], [ModifiedDate]) VALUES (1, N'Khách hàng A', N'Đ?a ch? A', N'0123456789', 1, CAST(N'2023-07-22T15:40:38.123' AS DateTime), CAST(N'2023-07-22T15:40:38.123' AS DateTime))
INSERT [dbo].[Customers] ([CustomerID], [CustomerName], [CustomerAddress], [CustomerPhone], [IsActive], [CreatedDate], [ModifiedDate]) VALUES (2, N'Khách hàng B', N'Đ?a ch? B', N'0987654321', 1, CAST(N'2023-07-22T15:40:38.123' AS DateTime), CAST(N'2023-07-22T15:40:38.123' AS DateTime))
INSERT [dbo].[Customers] ([CustomerID], [CustomerName], [CustomerAddress], [CustomerPhone], [IsActive], [CreatedDate], [ModifiedDate]) VALUES (3, N'Khách hàng C', N'Đ?a ch? C', N'0111222333', 1, CAST(N'2023-07-22T15:40:38.123' AS DateTime), CAST(N'2023-07-22T15:40:38.123' AS DateTime))
INSERT [dbo].[Customers] ([CustomerID], [CustomerName], [CustomerAddress], [CustomerPhone], [IsActive], [CreatedDate], [ModifiedDate]) VALUES (4, N'Khách hàng D', N'Đ?a ch? D', N'0333444555', 1, CAST(N'2023-07-22T15:40:38.123' AS DateTime), CAST(N'2023-07-22T15:40:38.123' AS DateTime))
INSERT [dbo].[Customers] ([CustomerID], [CustomerName], [CustomerAddress], [CustomerPhone], [IsActive], [CreatedDate], [ModifiedDate]) VALUES (5, N'Khách hàng E', N'Đ?a ch? E', N'0444555666', 1, CAST(N'2023-07-22T15:40:38.123' AS DateTime), CAST(N'2023-07-22T15:40:38.123' AS DateTime))
INSERT [dbo].[Customers] ([CustomerID], [CustomerName], [CustomerAddress], [CustomerPhone], [IsActive], [CreatedDate], [ModifiedDate]) VALUES (6, N'Khách hàng F', N'Đ?a ch? F', N'0555666777', 1, CAST(N'2023-07-22T15:40:38.123' AS DateTime), CAST(N'2023-07-22T15:40:38.123' AS DateTime))
INSERT [dbo].[Customers] ([CustomerID], [CustomerName], [CustomerAddress], [CustomerPhone], [IsActive], [CreatedDate], [ModifiedDate]) VALUES (7, N'Khách hàng G', N'Đ?a ch? G', N'0666777888', 1, CAST(N'2023-07-22T15:40:38.123' AS DateTime), CAST(N'2023-07-22T15:40:38.123' AS DateTime))
INSERT [dbo].[Customers] ([CustomerID], [CustomerName], [CustomerAddress], [CustomerPhone], [IsActive], [CreatedDate], [ModifiedDate]) VALUES (8, N'Khách hàng H', N'Đ?a ch? H', N'0777888999', 1, CAST(N'2023-07-22T15:40:38.123' AS DateTime), CAST(N'2023-07-22T15:40:38.123' AS DateTime))
INSERT [dbo].[Customers] ([CustomerID], [CustomerName], [CustomerAddress], [CustomerPhone], [IsActive], [CreatedDate], [ModifiedDate]) VALUES (9, N'Khách hàng I', N'Đ?a ch? I', N'0888999000', 1, CAST(N'2023-07-22T15:40:38.123' AS DateTime), CAST(N'2023-07-22T15:40:38.123' AS DateTime))
INSERT [dbo].[Customers] ([CustomerID], [CustomerName], [CustomerAddress], [CustomerPhone], [IsActive], [CreatedDate], [ModifiedDate]) VALUES (10, N'Khách hàng J', N'Đ?a ch? J', N'0999000111', 1, CAST(N'2023-07-22T15:40:38.123' AS DateTime), CAST(N'2023-07-22T15:40:38.123' AS DateTime))
SET IDENTITY_INSERT [dbo].[Customers] OFF
GO
SET IDENTITY_INSERT [dbo].[Employees] ON 

INSERT [dbo].[Employees] ([EmployeeID], [EmployeeName], [Position], [IsActive], [CreatedDate], [ModifiedDate]) VALUES (1, N'Nhân viên 1', N'V? trí 1', 1, CAST(N'2023-07-22T15:41:00.453' AS DateTime), CAST(N'2023-07-22T15:41:00.453' AS DateTime))
INSERT [dbo].[Employees] ([EmployeeID], [EmployeeName], [Position], [IsActive], [CreatedDate], [ModifiedDate]) VALUES (2, N'Nhân viên 2', N'V? trí 2', 1, CAST(N'2023-07-22T15:41:00.453' AS DateTime), CAST(N'2023-07-22T15:41:00.453' AS DateTime))
INSERT [dbo].[Employees] ([EmployeeID], [EmployeeName], [Position], [IsActive], [CreatedDate], [ModifiedDate]) VALUES (3, N'Nhân viên 3', N'V? trí 3', 1, CAST(N'2023-07-22T15:41:00.453' AS DateTime), CAST(N'2023-07-22T15:41:00.453' AS DateTime))
INSERT [dbo].[Employees] ([EmployeeID], [EmployeeName], [Position], [IsActive], [CreatedDate], [ModifiedDate]) VALUES (4, N'Nhân viên 4', N'V? trí 4', 1, CAST(N'2023-07-22T15:41:00.453' AS DateTime), CAST(N'2023-07-22T15:41:00.453' AS DateTime))
INSERT [dbo].[Employees] ([EmployeeID], [EmployeeName], [Position], [IsActive], [CreatedDate], [ModifiedDate]) VALUES (5, N'Nhân viên 5', N'V? trí 5', 1, CAST(N'2023-07-22T15:41:00.453' AS DateTime), CAST(N'2023-07-22T15:41:00.453' AS DateTime))
INSERT [dbo].[Employees] ([EmployeeID], [EmployeeName], [Position], [IsActive], [CreatedDate], [ModifiedDate]) VALUES (6, N'Nhân viên 6', N'V? trí 6', 1, CAST(N'2023-07-22T15:41:00.453' AS DateTime), CAST(N'2023-07-22T15:41:00.453' AS DateTime))
INSERT [dbo].[Employees] ([EmployeeID], [EmployeeName], [Position], [IsActive], [CreatedDate], [ModifiedDate]) VALUES (7, N'Nhân viên 7', N'V? trí 7', 1, CAST(N'2023-07-22T15:41:00.453' AS DateTime), CAST(N'2023-07-22T15:41:00.453' AS DateTime))
INSERT [dbo].[Employees] ([EmployeeID], [EmployeeName], [Position], [IsActive], [CreatedDate], [ModifiedDate]) VALUES (8, N'Nhân viên 8', N'V? trí 8', 1, CAST(N'2023-07-22T15:41:00.453' AS DateTime), CAST(N'2023-07-22T15:41:00.453' AS DateTime))
INSERT [dbo].[Employees] ([EmployeeID], [EmployeeName], [Position], [IsActive], [CreatedDate], [ModifiedDate]) VALUES (9, N'Nhân viên 9', N'V? trí 9', 1, CAST(N'2023-07-22T15:41:00.453' AS DateTime), CAST(N'2023-07-22T15:41:00.453' AS DateTime))
INSERT [dbo].[Employees] ([EmployeeID], [EmployeeName], [Position], [IsActive], [CreatedDate], [ModifiedDate]) VALUES (10, N'Nhân viên 10', N'V? trí 10', 1, CAST(N'2023-07-22T15:41:00.453' AS DateTime), CAST(N'2023-07-22T15:41:00.453' AS DateTime))
SET IDENTITY_INSERT [dbo].[Employees] OFF
GO
SET IDENTITY_INSERT [dbo].[Orders] ON 

INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [IsActive], [CreatedDate], [ModifiedDate]) VALUES (1, 1, CAST(N'2023-07-22T15:40:43.733' AS DateTime), 100.0000, 1, CAST(N'2023-07-22T15:40:43.733' AS DateTime), CAST(N'2023-07-22T15:40:43.733' AS DateTime))
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [IsActive], [CreatedDate], [ModifiedDate]) VALUES (2, 2, CAST(N'2023-07-22T15:40:43.733' AS DateTime), 75.5000, 1, CAST(N'2023-07-22T15:40:43.733' AS DateTime), CAST(N'2023-07-22T15:40:43.733' AS DateTime))
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [IsActive], [CreatedDate], [ModifiedDate]) VALUES (3, 3, CAST(N'2023-07-22T15:40:43.733' AS DateTime), 60.2000, 1, CAST(N'2023-07-22T15:40:43.733' AS DateTime), CAST(N'2023-07-22T15:40:43.733' AS DateTime))
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [IsActive], [CreatedDate], [ModifiedDate]) VALUES (4, 4, CAST(N'2023-07-22T15:40:43.733' AS DateTime), 120.8000, 1, CAST(N'2023-07-22T15:40:43.733' AS DateTime), CAST(N'2023-07-22T15:40:43.733' AS DateTime))
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [IsActive], [CreatedDate], [ModifiedDate]) VALUES (5, 5, CAST(N'2023-07-22T15:40:43.733' AS DateTime), 45.9000, 1, CAST(N'2023-07-22T15:40:43.733' AS DateTime), CAST(N'2023-07-22T15:40:43.733' AS DateTime))
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [IsActive], [CreatedDate], [ModifiedDate]) VALUES (6, 6, CAST(N'2023-07-22T15:40:43.733' AS DateTime), 88.3000, 1, CAST(N'2023-07-22T15:40:43.733' AS DateTime), CAST(N'2023-07-22T15:40:43.733' AS DateTime))
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [IsActive], [CreatedDate], [ModifiedDate]) VALUES (7, 7, CAST(N'2023-07-22T15:40:43.733' AS DateTime), 102.6000, 1, CAST(N'2023-07-22T15:40:43.733' AS DateTime), CAST(N'2023-07-22T15:40:43.733' AS DateTime))
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [IsActive], [CreatedDate], [ModifiedDate]) VALUES (8, 8, CAST(N'2023-07-22T15:40:43.733' AS DateTime), 95.0000, 1, CAST(N'2023-07-22T15:40:43.733' AS DateTime), CAST(N'2023-07-22T15:40:43.733' AS DateTime))
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [IsActive], [CreatedDate], [ModifiedDate]) VALUES (9, 9, CAST(N'2023-07-22T15:40:43.733' AS DateTime), 78.4000, 1, CAST(N'2023-07-22T15:40:43.733' AS DateTime), CAST(N'2023-07-22T15:40:43.733' AS DateTime))
INSERT [dbo].[Orders] ([OrderID], [CustomerID], [OrderDate], [TotalAmount], [IsActive], [CreatedDate], [ModifiedDate]) VALUES (10, 10, CAST(N'2023-07-22T15:40:43.733' AS DateTime), 110.2000, 1, CAST(N'2023-07-22T15:40:43.733' AS DateTime), CAST(N'2023-07-22T15:40:43.733' AS DateTime))
SET IDENTITY_INSERT [dbo].[Orders] OFF
GO
SET IDENTITY_INSERT [dbo].[Product] ON 

INSERT [dbo].[Product] ([ProductID], [ProductName], [CategoryID], [SupplierID], [Quantity], [UnitPrice], [IsActive], [CreatedDate], [ModifiedDate], [image]) VALUES (6, N'S?n ph?m 5', 5, 3, 50, 9.9000, 1, NULL, NULL, NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [CategoryID], [SupplierID], [Quantity], [UnitPrice], [IsActive], [CreatedDate], [ModifiedDate], [image]) VALUES (13, N'Sản phẩm 12', 2, 3, 2333, 23.0000, 0, NULL, NULL, NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [CategoryID], [SupplierID], [Quantity], [UnitPrice], [IsActive], [CreatedDate], [ModifiedDate], [image]) VALUES (16, N'S?n ph?m 1', 1, 1, 100, 10.5000, 1, CAST(N'2023-07-22T17:03:55.283' AS DateTime), CAST(N'2023-07-22T17:03:55.283' AS DateTime), NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [CategoryID], [SupplierID], [Quantity], [UnitPrice], [IsActive], [CreatedDate], [ModifiedDate], [image]) VALUES (17, N'S?n ph?m 2', 2, 2, 50, 8.7500, 1, CAST(N'2023-07-22T17:03:55.283' AS DateTime), CAST(N'2023-07-22T17:03:55.283' AS DateTime), NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [CategoryID], [SupplierID], [Quantity], [UnitPrice], [IsActive], [CreatedDate], [ModifiedDate], [image]) VALUES (18, N'S?n ph?m 3', 3, 3, 80, 12.0000, 1, CAST(N'2023-07-22T17:03:55.283' AS DateTime), CAST(N'2023-07-22T17:03:55.283' AS DateTime), NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [CategoryID], [SupplierID], [Quantity], [UnitPrice], [IsActive], [CreatedDate], [ModifiedDate], [image]) VALUES (19, N'S?n ph?m 4', 4, 4, 120, 15.2500, 1, CAST(N'2023-07-22T17:03:55.283' AS DateTime), CAST(N'2023-07-22T17:03:55.283' AS DateTime), NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [CategoryID], [SupplierID], [Quantity], [UnitPrice], [IsActive], [CreatedDate], [ModifiedDate], [image]) VALUES (20, N'S?n ph?m 5', 5, 5, 70, 9.9000, 1, CAST(N'2023-07-22T17:03:55.283' AS DateTime), CAST(N'2023-07-22T17:03:55.283' AS DateTime), NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [CategoryID], [SupplierID], [Quantity], [UnitPrice], [IsActive], [CreatedDate], [ModifiedDate], [image]) VALUES (21, N'S?n ph?m 6', 6, 6, 90, 11.5000, 1, CAST(N'2023-07-22T17:03:55.283' AS DateTime), CAST(N'2023-07-22T17:03:55.283' AS DateTime), NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [CategoryID], [SupplierID], [Quantity], [UnitPrice], [IsActive], [CreatedDate], [ModifiedDate], [image]) VALUES (22, N'S?n ph?m 7', 7, 7, 60, 14.0000, 1, CAST(N'2023-07-22T17:03:55.283' AS DateTime), CAST(N'2023-07-22T17:03:55.283' AS DateTime), NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [CategoryID], [SupplierID], [Quantity], [UnitPrice], [IsActive], [CreatedDate], [ModifiedDate], [image]) VALUES (23, N'S?n ph?m 8', 8, 8, 110, 18.5000, 1, CAST(N'2023-07-22T17:03:55.283' AS DateTime), CAST(N'2023-07-22T17:03:55.283' AS DateTime), NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [CategoryID], [SupplierID], [Quantity], [UnitPrice], [IsActive], [CreatedDate], [ModifiedDate], [image]) VALUES (24, N'S?n ph?m 9', 9, 9, 75, 16.7500, 1, CAST(N'2023-07-22T17:03:55.283' AS DateTime), CAST(N'2023-07-22T17:03:55.283' AS DateTime), NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [CategoryID], [SupplierID], [Quantity], [UnitPrice], [IsActive], [CreatedDate], [ModifiedDate], [image]) VALUES (25, N'S?n ph?m 10', 10, 10, 40, 7.8000, 1, CAST(N'2023-07-22T17:03:55.283' AS DateTime), CAST(N'2023-07-22T17:03:55.283' AS DateTime), NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [CategoryID], [SupplierID], [Quantity], [UnitPrice], [IsActive], [CreatedDate], [ModifiedDate], [image]) VALUES (26, N'S?n ph?m 1', 1, 1, 100, 10.5000, 1, CAST(N'2023-07-22T17:03:55.807' AS DateTime), CAST(N'2023-07-22T17:03:55.807' AS DateTime), NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [CategoryID], [SupplierID], [Quantity], [UnitPrice], [IsActive], [CreatedDate], [ModifiedDate], [image]) VALUES (27, N'S?n ph?m 2', 2, 2, 50, 8.7500, 1, CAST(N'2023-07-22T17:03:55.807' AS DateTime), CAST(N'2023-07-22T17:03:55.807' AS DateTime), NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [CategoryID], [SupplierID], [Quantity], [UnitPrice], [IsActive], [CreatedDate], [ModifiedDate], [image]) VALUES (28, N'S?n ph?m 3', 3, 3, 80, 12.0000, 1, CAST(N'2023-07-22T17:03:55.807' AS DateTime), CAST(N'2023-07-22T17:03:55.807' AS DateTime), NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [CategoryID], [SupplierID], [Quantity], [UnitPrice], [IsActive], [CreatedDate], [ModifiedDate], [image]) VALUES (29, N'S?n ph?m 4', 4, 4, 120, 15.2500, 1, CAST(N'2023-07-22T17:03:55.807' AS DateTime), CAST(N'2023-07-22T17:03:55.807' AS DateTime), NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [CategoryID], [SupplierID], [Quantity], [UnitPrice], [IsActive], [CreatedDate], [ModifiedDate], [image]) VALUES (30, N'S?n ph?m 5', 5, 5, 70, 9.9000, 1, CAST(N'2023-07-22T17:03:55.807' AS DateTime), CAST(N'2023-07-22T17:03:55.807' AS DateTime), NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [CategoryID], [SupplierID], [Quantity], [UnitPrice], [IsActive], [CreatedDate], [ModifiedDate], [image]) VALUES (31, N'S?n ph?m 6', 6, 6, 90, 11.5000, 1, CAST(N'2023-07-22T17:03:55.807' AS DateTime), CAST(N'2023-07-22T17:03:55.807' AS DateTime), NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [CategoryID], [SupplierID], [Quantity], [UnitPrice], [IsActive], [CreatedDate], [ModifiedDate], [image]) VALUES (32, N'S?n ph?m 7', 7, 7, 60, 14.0000, 1, CAST(N'2023-07-22T17:03:55.807' AS DateTime), CAST(N'2023-07-22T17:03:55.807' AS DateTime), NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [CategoryID], [SupplierID], [Quantity], [UnitPrice], [IsActive], [CreatedDate], [ModifiedDate], [image]) VALUES (33, N'S?n ph?m 8', 8, 8, 110, 18.5000, 1, CAST(N'2023-07-22T17:03:55.807' AS DateTime), CAST(N'2023-07-22T17:03:55.807' AS DateTime), NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [CategoryID], [SupplierID], [Quantity], [UnitPrice], [IsActive], [CreatedDate], [ModifiedDate], [image]) VALUES (34, N'S?n ph?m 9', 9, 9, 75, 16.7500, 1, CAST(N'2023-07-22T17:03:55.807' AS DateTime), CAST(N'2023-07-22T17:03:55.807' AS DateTime), NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [CategoryID], [SupplierID], [Quantity], [UnitPrice], [IsActive], [CreatedDate], [ModifiedDate], [image]) VALUES (35, N'S?n ph?m 10', 10, 10, 40, 7.8000, 1, CAST(N'2023-07-22T17:03:55.807' AS DateTime), CAST(N'2023-07-22T17:03:55.807' AS DateTime), NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [CategoryID], [SupplierID], [Quantity], [UnitPrice], [IsActive], [CreatedDate], [ModifiedDate], [image]) VALUES (36, N'S?n ph?m 1', 1, 1, 100, 10.5000, 1, CAST(N'2023-07-22T17:03:56.260' AS DateTime), CAST(N'2023-07-22T17:03:56.260' AS DateTime), NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [CategoryID], [SupplierID], [Quantity], [UnitPrice], [IsActive], [CreatedDate], [ModifiedDate], [image]) VALUES (37, N'S?n ph?m 2', 2, 2, 50, 8.7500, 1, CAST(N'2023-07-22T17:03:56.260' AS DateTime), CAST(N'2023-07-22T17:03:56.260' AS DateTime), NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [CategoryID], [SupplierID], [Quantity], [UnitPrice], [IsActive], [CreatedDate], [ModifiedDate], [image]) VALUES (38, N'S?n ph?m 3', 3, 3, 80, 12.0000, 1, CAST(N'2023-07-22T17:03:56.260' AS DateTime), CAST(N'2023-07-22T17:03:56.260' AS DateTime), NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [CategoryID], [SupplierID], [Quantity], [UnitPrice], [IsActive], [CreatedDate], [ModifiedDate], [image]) VALUES (39, N'S?n ph?m 4', 4, 4, 120, 15.2500, 1, CAST(N'2023-07-22T17:03:56.260' AS DateTime), CAST(N'2023-07-22T17:03:56.260' AS DateTime), NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [CategoryID], [SupplierID], [Quantity], [UnitPrice], [IsActive], [CreatedDate], [ModifiedDate], [image]) VALUES (40, N'S?n ph?m 5', 5, 5, 70, 9.9000, 1, CAST(N'2023-07-22T17:03:56.260' AS DateTime), CAST(N'2023-07-22T17:03:56.260' AS DateTime), NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [CategoryID], [SupplierID], [Quantity], [UnitPrice], [IsActive], [CreatedDate], [ModifiedDate], [image]) VALUES (41, N'S?n ph?m 6', 6, 6, 90, 11.5000, 1, CAST(N'2023-07-22T17:03:56.260' AS DateTime), CAST(N'2023-07-22T17:03:56.260' AS DateTime), NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [CategoryID], [SupplierID], [Quantity], [UnitPrice], [IsActive], [CreatedDate], [ModifiedDate], [image]) VALUES (42, N'S?n ph?m 7', 7, 7, 60, 14.0000, 1, CAST(N'2023-07-22T17:03:56.260' AS DateTime), CAST(N'2023-07-22T17:03:56.260' AS DateTime), NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [CategoryID], [SupplierID], [Quantity], [UnitPrice], [IsActive], [CreatedDate], [ModifiedDate], [image]) VALUES (43, N'S?n ph?m 8', 8, 8, 110, 18.5000, 1, CAST(N'2023-07-22T17:03:56.260' AS DateTime), CAST(N'2023-07-22T17:03:56.260' AS DateTime), NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [CategoryID], [SupplierID], [Quantity], [UnitPrice], [IsActive], [CreatedDate], [ModifiedDate], [image]) VALUES (44, N'S?n ph?m 9', 9, 9, 75, 16.7500, 1, CAST(N'2023-07-22T17:03:56.260' AS DateTime), CAST(N'2023-07-22T17:03:56.260' AS DateTime), NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [CategoryID], [SupplierID], [Quantity], [UnitPrice], [IsActive], [CreatedDate], [ModifiedDate], [image]) VALUES (45, N'S?n ph?m 10', 10, 10, 40, 7.8000, 1, CAST(N'2023-07-22T17:03:56.260' AS DateTime), CAST(N'2023-07-22T17:03:56.260' AS DateTime), NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [CategoryID], [SupplierID], [Quantity], [UnitPrice], [IsActive], [CreatedDate], [ModifiedDate], [image]) VALUES (46, N'S?n ph?m 1', 1, 1, 100, 10.5000, 1, CAST(N'2023-07-22T17:03:56.710' AS DateTime), CAST(N'2023-07-22T17:03:56.710' AS DateTime), NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [CategoryID], [SupplierID], [Quantity], [UnitPrice], [IsActive], [CreatedDate], [ModifiedDate], [image]) VALUES (47, N'S?n ph?m 2', 2, 2, 50, 8.7500, 1, CAST(N'2023-07-22T17:03:56.710' AS DateTime), CAST(N'2023-07-22T17:03:56.710' AS DateTime), NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [CategoryID], [SupplierID], [Quantity], [UnitPrice], [IsActive], [CreatedDate], [ModifiedDate], [image]) VALUES (48, N'S?n ph?m 3', 3, 3, 80, 12.0000, 1, CAST(N'2023-07-22T17:03:56.710' AS DateTime), CAST(N'2023-07-22T17:03:56.710' AS DateTime), NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [CategoryID], [SupplierID], [Quantity], [UnitPrice], [IsActive], [CreatedDate], [ModifiedDate], [image]) VALUES (49, N'S?n ph?m 4', 4, 4, 120, 15.2500, 1, CAST(N'2023-07-22T17:03:56.710' AS DateTime), CAST(N'2023-07-22T17:03:56.710' AS DateTime), NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [CategoryID], [SupplierID], [Quantity], [UnitPrice], [IsActive], [CreatedDate], [ModifiedDate], [image]) VALUES (50, N'S?n ph?m 5', 5, 5, 70, 9.9000, 1, CAST(N'2023-07-22T17:03:56.710' AS DateTime), CAST(N'2023-07-22T17:03:56.710' AS DateTime), NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [CategoryID], [SupplierID], [Quantity], [UnitPrice], [IsActive], [CreatedDate], [ModifiedDate], [image]) VALUES (51, N'S?n ph?m 6', 6, 6, 90, 11.5000, 1, CAST(N'2023-07-22T17:03:56.710' AS DateTime), CAST(N'2023-07-22T17:03:56.710' AS DateTime), NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [CategoryID], [SupplierID], [Quantity], [UnitPrice], [IsActive], [CreatedDate], [ModifiedDate], [image]) VALUES (52, N'S?n ph?m 7', 7, 7, 60, 14.0000, 1, CAST(N'2023-07-22T17:03:56.710' AS DateTime), CAST(N'2023-07-22T17:03:56.710' AS DateTime), NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [CategoryID], [SupplierID], [Quantity], [UnitPrice], [IsActive], [CreatedDate], [ModifiedDate], [image]) VALUES (53, N'S?n ph?m 8', 8, 8, 110, 18.5000, 1, CAST(N'2023-07-22T17:03:56.710' AS DateTime), CAST(N'2023-07-22T17:03:56.710' AS DateTime), NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [CategoryID], [SupplierID], [Quantity], [UnitPrice], [IsActive], [CreatedDate], [ModifiedDate], [image]) VALUES (54, N'S?n ph?m 9', 9, 9, 75, 16.7500, 1, CAST(N'2023-07-22T17:03:56.710' AS DateTime), CAST(N'2023-07-22T17:03:56.710' AS DateTime), NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [CategoryID], [SupplierID], [Quantity], [UnitPrice], [IsActive], [CreatedDate], [ModifiedDate], [image]) VALUES (55, N'S?n ph?m 10', 10, 10, 40, 7.8000, 1, CAST(N'2023-07-22T17:03:56.710' AS DateTime), CAST(N'2023-07-22T17:03:56.710' AS DateTime), NULL)
INSERT [dbo].[Product] ([ProductID], [ProductName], [CategoryID], [SupplierID], [Quantity], [UnitPrice], [IsActive], [CreatedDate], [ModifiedDate], [image]) VALUES (56, N'fpt', 2, 1, 12, 324.0000, 1, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Product] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductCategory] ON 

INSERT [dbo].[ProductCategory] ([CategoryID], [CategoryName], [IsActive], [CreatedDate], [ModifiedDate]) VALUES (1, N'Danh m?c 1', 1, CAST(N'2023-07-22T15:40:26.727' AS DateTime), CAST(N'2023-07-22T15:40:26.727' AS DateTime))
INSERT [dbo].[ProductCategory] ([CategoryID], [CategoryName], [IsActive], [CreatedDate], [ModifiedDate]) VALUES (2, N'Danh m?c 2', 1, CAST(N'2023-07-22T15:40:26.727' AS DateTime), CAST(N'2023-07-22T15:40:26.727' AS DateTime))
INSERT [dbo].[ProductCategory] ([CategoryID], [CategoryName], [IsActive], [CreatedDate], [ModifiedDate]) VALUES (3, N'Danh m?c 3', 1, CAST(N'2023-07-22T15:40:26.727' AS DateTime), CAST(N'2023-07-22T15:40:26.727' AS DateTime))
INSERT [dbo].[ProductCategory] ([CategoryID], [CategoryName], [IsActive], [CreatedDate], [ModifiedDate]) VALUES (4, N'Danh m?c 4', 1, CAST(N'2023-07-22T15:40:26.727' AS DateTime), CAST(N'2023-07-22T15:40:26.727' AS DateTime))
INSERT [dbo].[ProductCategory] ([CategoryID], [CategoryName], [IsActive], [CreatedDate], [ModifiedDate]) VALUES (5, N'Danh m?c 5', 1, CAST(N'2023-07-22T15:40:26.727' AS DateTime), CAST(N'2023-07-22T15:40:26.727' AS DateTime))
INSERT [dbo].[ProductCategory] ([CategoryID], [CategoryName], [IsActive], [CreatedDate], [ModifiedDate]) VALUES (6, N'Danh m?c 6', 1, CAST(N'2023-07-22T15:40:26.727' AS DateTime), CAST(N'2023-07-22T15:40:26.727' AS DateTime))
INSERT [dbo].[ProductCategory] ([CategoryID], [CategoryName], [IsActive], [CreatedDate], [ModifiedDate]) VALUES (7, N'Danh m?c 7', 1, CAST(N'2023-07-22T15:40:26.727' AS DateTime), CAST(N'2023-07-22T15:40:26.727' AS DateTime))
INSERT [dbo].[ProductCategory] ([CategoryID], [CategoryName], [IsActive], [CreatedDate], [ModifiedDate]) VALUES (8, N'Danh m?c 8', 1, CAST(N'2023-07-22T15:40:26.727' AS DateTime), CAST(N'2023-07-22T15:40:26.727' AS DateTime))
INSERT [dbo].[ProductCategory] ([CategoryID], [CategoryName], [IsActive], [CreatedDate], [ModifiedDate]) VALUES (9, N'Danh m?c 9', 1, CAST(N'2023-07-22T15:40:26.727' AS DateTime), CAST(N'2023-07-22T15:40:26.727' AS DateTime))
INSERT [dbo].[ProductCategory] ([CategoryID], [CategoryName], [IsActive], [CreatedDate], [ModifiedDate]) VALUES (10, N'Danh m?c 10', 1, CAST(N'2023-07-22T15:40:26.727' AS DateTime), CAST(N'2023-07-22T15:40:26.727' AS DateTime))
SET IDENTITY_INSERT [dbo].[ProductCategory] OFF
GO
SET IDENTITY_INSERT [dbo].[Profits] ON 

INSERT [dbo].[Profits] ([ProfitID], [OrderID], [Amount], [IsActive], [CreatedDate], [ModifiedDate]) VALUES (1, 1, 20.0000, 1, CAST(N'2023-07-22T15:40:56.347' AS DateTime), CAST(N'2023-07-22T15:40:56.347' AS DateTime))
INSERT [dbo].[Profits] ([ProfitID], [OrderID], [Amount], [IsActive], [CreatedDate], [ModifiedDate]) VALUES (2, 2, 12.5000, 1, CAST(N'2023-07-22T15:40:56.347' AS DateTime), CAST(N'2023-07-22T15:40:56.347' AS DateTime))
INSERT [dbo].[Profits] ([ProfitID], [OrderID], [Amount], [IsActive], [CreatedDate], [ModifiedDate]) VALUES (3, 3, 8.2000, 1, CAST(N'2023-07-22T15:40:56.347' AS DateTime), CAST(N'2023-07-22T15:40:56.347' AS DateTime))
INSERT [dbo].[Profits] ([ProfitID], [OrderID], [Amount], [IsActive], [CreatedDate], [ModifiedDate]) VALUES (4, 4, 22.8000, 1, CAST(N'2023-07-22T15:40:56.347' AS DateTime), CAST(N'2023-07-22T15:40:56.347' AS DateTime))
INSERT [dbo].[Profits] ([ProfitID], [OrderID], [Amount], [IsActive], [CreatedDate], [ModifiedDate]) VALUES (5, 5, 5.9000, 1, CAST(N'2023-07-22T15:40:56.347' AS DateTime), CAST(N'2023-07-22T15:40:56.347' AS DateTime))
INSERT [dbo].[Profits] ([ProfitID], [OrderID], [Amount], [IsActive], [CreatedDate], [ModifiedDate]) VALUES (6, 6, 18.3000, 1, CAST(N'2023-07-22T15:40:56.347' AS DateTime), CAST(N'2023-07-22T15:40:56.347' AS DateTime))
INSERT [dbo].[Profits] ([ProfitID], [OrderID], [Amount], [IsActive], [CreatedDate], [ModifiedDate]) VALUES (7, 7, 10.6000, 1, CAST(N'2023-07-22T15:40:56.347' AS DateTime), CAST(N'2023-07-22T15:40:56.347' AS DateTime))
INSERT [dbo].[Profits] ([ProfitID], [OrderID], [Amount], [IsActive], [CreatedDate], [ModifiedDate]) VALUES (8, 8, 25.0000, 1, CAST(N'2023-07-22T15:40:56.347' AS DateTime), CAST(N'2023-07-22T15:40:56.347' AS DateTime))
INSERT [dbo].[Profits] ([ProfitID], [OrderID], [Amount], [IsActive], [CreatedDate], [ModifiedDate]) VALUES (9, 9, 17.4000, 1, CAST(N'2023-07-22T15:40:56.347' AS DateTime), CAST(N'2023-07-22T15:40:56.347' AS DateTime))
INSERT [dbo].[Profits] ([ProfitID], [OrderID], [Amount], [IsActive], [CreatedDate], [ModifiedDate]) VALUES (10, 10, 30.2000, 1, CAST(N'2023-07-22T15:40:56.347' AS DateTime), CAST(N'2023-07-22T15:40:56.347' AS DateTime))
SET IDENTITY_INSERT [dbo].[Profits] OFF
GO
SET IDENTITY_INSERT [dbo].[Suppliers] ON 

INSERT [dbo].[Suppliers] ([SupplierID], [SupplierName], [SupplierAddress], [SupplierPhone], [IsActive], [CreatedDate], [ModifiedDate]) VALUES (1, N'Nhà cung c?p A', N'Đ?a ch? A', N'0123456789', NULL, NULL, CAST(N'2023-07-22T19:53:25.983' AS DateTime))
INSERT [dbo].[Suppliers] ([SupplierID], [SupplierName], [SupplierAddress], [SupplierPhone], [IsActive], [CreatedDate], [ModifiedDate]) VALUES (2, N'Nhà cung c?p B', N'Đ?a ch? B', N'0987654321', 1, CAST(N'2023-07-22T15:40:21.150' AS DateTime), CAST(N'2023-07-22T15:40:21.150' AS DateTime))
INSERT [dbo].[Suppliers] ([SupplierID], [SupplierName], [SupplierAddress], [SupplierPhone], [IsActive], [CreatedDate], [ModifiedDate]) VALUES (3, N'Nhà cung c?p C', N'Đ?a ch? C', N'0111222333', 1, CAST(N'2023-07-22T15:40:21.150' AS DateTime), CAST(N'2023-07-22T15:40:21.150' AS DateTime))
INSERT [dbo].[Suppliers] ([SupplierID], [SupplierName], [SupplierAddress], [SupplierPhone], [IsActive], [CreatedDate], [ModifiedDate]) VALUES (4, N'Nhà cung c?p D', N'Đ?a ch? D', N'0333444555', 1, CAST(N'2023-07-22T15:40:21.150' AS DateTime), CAST(N'2023-07-22T15:40:21.150' AS DateTime))
INSERT [dbo].[Suppliers] ([SupplierID], [SupplierName], [SupplierAddress], [SupplierPhone], [IsActive], [CreatedDate], [ModifiedDate]) VALUES (5, N'Nhà cung c?p E', N'Đ?a ch? E', N'0444555666', 1, CAST(N'2023-07-22T15:40:21.150' AS DateTime), CAST(N'2023-07-22T15:40:21.150' AS DateTime))
INSERT [dbo].[Suppliers] ([SupplierID], [SupplierName], [SupplierAddress], [SupplierPhone], [IsActive], [CreatedDate], [ModifiedDate]) VALUES (6, N'Nhà cung c?p F', N'Đ?a ch? F', N'05556667', NULL, NULL, CAST(N'2023-07-22T19:54:48.173' AS DateTime))
INSERT [dbo].[Suppliers] ([SupplierID], [SupplierName], [SupplierAddress], [SupplierPhone], [IsActive], [CreatedDate], [ModifiedDate]) VALUES (7, N'Nhà cung c?p G', N'Đ?a ch? G', N'0666777888', 1, CAST(N'2023-07-22T15:40:21.150' AS DateTime), CAST(N'2023-07-22T15:40:21.150' AS DateTime))
INSERT [dbo].[Suppliers] ([SupplierID], [SupplierName], [SupplierAddress], [SupplierPhone], [IsActive], [CreatedDate], [ModifiedDate]) VALUES (8, N'Nhà cung c?p H', N'Đ?a ch? H', N'0777888999', 1, CAST(N'2023-07-22T15:40:21.150' AS DateTime), CAST(N'2023-07-22T15:40:21.150' AS DateTime))
INSERT [dbo].[Suppliers] ([SupplierID], [SupplierName], [SupplierAddress], [SupplierPhone], [IsActive], [CreatedDate], [ModifiedDate]) VALUES (9, N'Nhà cung c?p I', N'Đ?a ch? I', N'0888999000', 1, CAST(N'2023-07-22T15:40:21.150' AS DateTime), CAST(N'2023-07-22T15:40:21.150' AS DateTime))
INSERT [dbo].[Suppliers] ([SupplierID], [SupplierName], [SupplierAddress], [SupplierPhone], [IsActive], [CreatedDate], [ModifiedDate]) VALUES (10, N'Nhà cung c?p J', N'Đ?a ch? J', N'0999000111', 1, CAST(N'2023-07-22T15:40:21.150' AS DateTime), CAST(N'2023-07-22T15:40:21.150' AS DateTime))
INSERT [dbo].[Suppliers] ([SupplierID], [SupplierName], [SupplierAddress], [SupplierPhone], [IsActive], [CreatedDate], [ModifiedDate]) VALUES (11, N'FPT', N'HaNoi', N'231244123123', 1, CAST(N'2023-07-22T19:32:57.623' AS DateTime), CAST(N'2023-07-22T19:32:57.623' AS DateTime))
SET IDENTITY_INSERT [dbo].[Suppliers] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([UserID], [Username], [Password], [Role], [IsActive], [CreatedDate], [ModifiedDate], [EmployeeID]) VALUES (1, N'user1', N'password1', N'Role1', 1, CAST(N'2023-07-22T15:41:19.647' AS DateTime), CAST(N'2023-07-22T15:41:19.647' AS DateTime), 1)
INSERT [dbo].[Users] ([UserID], [Username], [Password], [Role], [IsActive], [CreatedDate], [ModifiedDate], [EmployeeID]) VALUES (2, N'user2', N'password2', N'Role2', 1, CAST(N'2023-07-22T15:41:19.647' AS DateTime), CAST(N'2023-07-22T15:41:19.647' AS DateTime), 2)
INSERT [dbo].[Users] ([UserID], [Username], [Password], [Role], [IsActive], [CreatedDate], [ModifiedDate], [EmployeeID]) VALUES (3, N'user3', N'password3', N'Role3', 1, CAST(N'2023-07-22T15:41:19.647' AS DateTime), CAST(N'2023-07-22T15:41:19.647' AS DateTime), 3)
INSERT [dbo].[Users] ([UserID], [Username], [Password], [Role], [IsActive], [CreatedDate], [ModifiedDate], [EmployeeID]) VALUES (4, N'user4', N'password4', N'Role4', 1, CAST(N'2023-07-22T15:41:19.647' AS DateTime), CAST(N'2023-07-22T15:41:19.647' AS DateTime), 4)
INSERT [dbo].[Users] ([UserID], [Username], [Password], [Role], [IsActive], [CreatedDate], [ModifiedDate], [EmployeeID]) VALUES (5, N'user5', N'password5', N'Role5', 1, CAST(N'2023-07-22T15:41:19.647' AS DateTime), CAST(N'2023-07-22T15:41:19.647' AS DateTime), 5)
INSERT [dbo].[Users] ([UserID], [Username], [Password], [Role], [IsActive], [CreatedDate], [ModifiedDate], [EmployeeID]) VALUES (6, N'user6', N'password6', N'Role6', 1, CAST(N'2023-07-22T15:41:19.647' AS DateTime), CAST(N'2023-07-22T15:41:19.647' AS DateTime), 6)
INSERT [dbo].[Users] ([UserID], [Username], [Password], [Role], [IsActive], [CreatedDate], [ModifiedDate], [EmployeeID]) VALUES (7, N'user7', N'password7', N'Role7', 1, CAST(N'2023-07-22T15:41:19.647' AS DateTime), CAST(N'2023-07-22T15:41:19.647' AS DateTime), 7)
INSERT [dbo].[Users] ([UserID], [Username], [Password], [Role], [IsActive], [CreatedDate], [ModifiedDate], [EmployeeID]) VALUES (8, N'user8', N'password8', N'Role8', 1, CAST(N'2023-07-22T15:41:19.647' AS DateTime), CAST(N'2023-07-22T15:41:19.647' AS DateTime), 8)
INSERT [dbo].[Users] ([UserID], [Username], [Password], [Role], [IsActive], [CreatedDate], [ModifiedDate], [EmployeeID]) VALUES (9, N'user9', N'password9', N'Role9', 1, CAST(N'2023-07-22T15:41:19.647' AS DateTime), CAST(N'2023-07-22T15:41:19.647' AS DateTime), 9)
INSERT [dbo].[Users] ([UserID], [Username], [Password], [Role], [IsActive], [CreatedDate], [ModifiedDate], [EmployeeID]) VALUES (10, N'user10', N'password10', N'Role10', 1, CAST(N'2023-07-22T15:41:19.647' AS DateTime), CAST(N'2023-07-22T15:41:19.647' AS DateTime), 10)
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
ALTER TABLE [dbo].[Inventory]  WITH CHECK ADD FOREIGN KEY([SupplierID])
REFERENCES [dbo].[Suppliers] ([SupplierID])
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD FOREIGN KEY([OrderID])
REFERENCES [dbo].[Orders] ([OrderID])
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD FOREIGN KEY([ProductID])
REFERENCES [dbo].[Inventory] ([ProductID])
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customers] ([CustomerID])
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD FOREIGN KEY([CategoryID])
REFERENCES [dbo].[ProductCategory] ([CategoryID])
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD FOREIGN KEY([SupplierID])
REFERENCES [dbo].[Suppliers] ([SupplierID])
GO
ALTER TABLE [dbo].[Profits]  WITH CHECK ADD FOREIGN KEY([OrderID])
REFERENCES [dbo].[Orders] ([OrderID])
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employees] ([EmployeeID])
GO
USE [master]
GO
ALTER DATABASE [Project221] SET  READ_WRITE 
GO

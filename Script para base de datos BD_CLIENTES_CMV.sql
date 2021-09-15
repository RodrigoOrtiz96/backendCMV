USE [master]
GO

/****** Object:  Database [CLIENTES_CMV]    Script Date: 13/09/2021 06:42:12 p. m. ******/
CREATE DATABASE [CLIENTES_CMV]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CLIENTES_CMV', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\CLIENTES_CMV.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'CLIENTES_CMV_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\CLIENTES_CMV_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CLIENTES_CMV].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [CLIENTES_CMV] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [CLIENTES_CMV] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [CLIENTES_CMV] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [CLIENTES_CMV] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [CLIENTES_CMV] SET ARITHABORT OFF 
GO

ALTER DATABASE [CLIENTES_CMV] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [CLIENTES_CMV] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [CLIENTES_CMV] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [CLIENTES_CMV] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [CLIENTES_CMV] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [CLIENTES_CMV] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [CLIENTES_CMV] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [CLIENTES_CMV] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [CLIENTES_CMV] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [CLIENTES_CMV] SET  DISABLE_BROKER 
GO

ALTER DATABASE [CLIENTES_CMV] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [CLIENTES_CMV] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [CLIENTES_CMV] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [CLIENTES_CMV] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [CLIENTES_CMV] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [CLIENTES_CMV] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [CLIENTES_CMV] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [CLIENTES_CMV] SET RECOVERY FULL 
GO

ALTER DATABASE [CLIENTES_CMV] SET  MULTI_USER 
GO

ALTER DATABASE [CLIENTES_CMV] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [CLIENTES_CMV] SET DB_CHAINING OFF 
GO

ALTER DATABASE [CLIENTES_CMV] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO

ALTER DATABASE [CLIENTES_CMV] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO

ALTER DATABASE [CLIENTES_CMV] SET DELAYED_DURABILITY = DISABLED 
GO

ALTER DATABASE [CLIENTES_CMV] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO

ALTER DATABASE [CLIENTES_CMV] SET QUERY_STORE = OFF
GO

ALTER DATABASE [CLIENTES_CMV] SET  READ_WRITE 
GO

USE [CLIENTES_CMV]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*Se crea la tabla para clientes*/
CREATE TABLE TBL_CMV_CLIENTE(
	[idCliente] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[apellidoPaterno] [varchar](50) NOT NULL,
	[apellidoMaterno] [varchar](50) NOT NULL,
	[rfc] [varchar](13) NOT NULL,
	[curp] [varchar](18) NOT NULL,
	[fechaAlta] [datetime] NOT NULL,
 CONSTRAINT [PK_TBL_CMV_CLIENTE] PRIMARY KEY CLUSTERED 
(
	[idCliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/*Se crea la tabla para tipos de cuentas*/
CREATE TABLE CAT_CMV_TIPO_CUENTA(
	[idCuenta] [int] NOT NULL,
	[nombreCuenta] [varchar](50) NOT NULL,
 CONSTRAINT [PK_CAT_CMV_TIPO_CUENTA] PRIMARY KEY CLUSTERED 
(
	[idCuenta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/*Se crea la tabla para relacionar clientes con cuentas*/
CREATE TABLE TBL_CMV_CLIENTE_CUENTA(
	[idClienteCuenta] [int] IDENTITY(1,1) NOT NULL,
	[idCliente] [int] NOT NULL,
	[idCuenta] [int] NOT NULL,
	[saldoActual] [money] NOT NULL,
	[fechaContratacion] [datetime] NOT NULL,
	[fechaUltimoMovimiento] [datetime] NOT NULL,
 CONSTRAINT [PK_TBL_CMV_CLIENTE_CUENTA] PRIMARY KEY CLUSTERED 
(
	[idClienteCuenta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[TBL_CMV_CLIENTE_CUENTA]  WITH CHECK ADD  CONSTRAINT [FK_CMV_CLIENTE] FOREIGN KEY([idCliente])
REFERENCES [dbo].[TBL_CMV_CLIENTE] ([idCliente])
GO

ALTER TABLE [dbo].[TBL_CMV_CLIENTE_CUENTA] CHECK CONSTRAINT [FK_CMV_CLIENTE]
GO

ALTER TABLE [dbo].[TBL_CMV_CLIENTE_CUENTA]  WITH CHECK ADD  CONSTRAINT [FK_CMV_CUENTA] FOREIGN KEY([idCuenta])
REFERENCES [dbo].[CAT_CMV_TIPO_CUENTA] ([idCuenta])
GO

ALTER TABLE [dbo].[TBL_CMV_CLIENTE_CUENTA] CHECK CONSTRAINT [FK_CMV_CUENTA]
GO

/*Procedimientos almacenados*/

/*Seleccionar clientes*/
CREATE PROCEDURE selecClientes
AS
SELECT * FROM TBL_CMV_CLIENTE
GO

/*Actualizad cliente*/
CREATE PROCEDURE actualizarCliente (@idCliente int,
								   @nombre varchar(50),
								   @apellidoPaterno varchar(50),
								   @apellidoMaterno varchar(50),
								   @rfc varchar(13),
								   @curp varchar(18))
AS

UPDATE TBL_CMV_CLIENTE
   SET [nombre] = @nombre,
      [apellidoPaterno] = @apellidoPaterno,
      [apellidoMaterno] = @apellidoMaterno,
      [rfc] = @rfc,
      [curp] = @curp
   WHERE idCliente = @idCliente
GO

/*Eliminar cliente*/
CREATE PROCEDURE eliminarCliente @idCliente int
AS
DELETE FROM TBL_CMV_CLIENTE_CUENTA WHERE idCliente = @idCliente
DELETE FROM TBL_CMV_CLIENTE WHERE idCliente = @idCliente;
GO

/*Alta cliente*/
CREATE PROCEDURE altaCliente (@nombre varchar(50),
							  @apellidoPaterno varchar(50),
							  @apellidoMaterno varchar(50),
							  @rfc varchar(13),
							  @curp varchar(18))
AS

INSERT INTO TBL_CMV_CLIENTE
           ([nombre] ,[apellidoPaterno] ,[apellidoMaterno] ,[rfc] ,[curp] ,[fechaAlta])
     VALUES
           (@nombre, @apellidoPaterno, @apellidoMaterno, @rfc, @curp, CURRENT_TIMESTAMP);
GO

/*Asociar cuenta con cliente*/
CREATE PROCEDURE asociarCuenta (@idCliente int,
								@idCuenta int,
								@saldoActual Money)
AS
INSERT INTO TBL_CMV_CLIENTE_CUENTA
           ([idCliente] ,[idCuenta] ,[saldoActual] ,[fechaContratacion] ,[fechaUltimoMovimiento])
     VALUES
           (@idCliente, @idCuenta, @saldoActual, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
GO

/*Consultar cuentas asociadas con algún cliente*/
CREATE PROCEDURE consultarCuenta (@idCliente int)
AS
SELECT TBL_CMV_CLIENTE.nombre, TBL_CMV_CLIENTE.apellidoPaterno, TBL_CMV_CLIENTE.apellidoMaterno
	   , CAT_CMV_TIPO_CUENTA.nombreCuenta
	   , TBL_CMV_CLIENTE_CUENTA.saldoActual, TBL_CMV_CLIENTE_CUENTA.fechaUltimoMovimiento
	   FROM TBL_CMV_CLIENTE INNER JOIN TBL_CMV_CLIENTE_CUENTA ON TBL_CMV_CLIENTE.idCliente=TBL_CMV_CLIENTE_CUENTA.idCliente 
	   INNER JOIN CAT_CMV_TIPO_CUENTA ON CAT_CMV_TIPO_CUENTA.idCuenta=TBL_CMV_CLIENTE_CUENTA.idCuenta
	   WHERE TBL_CMV_CLIENTE_CUENTA.idCliente=@idCliente;
GO

/*Datos para llenar las tablas*/
INSERT INTO [dbo].[TBL_CMV_CLIENTE]
           ([rfc] ,[curp] ,[nombre] ,[apellidoPaterno] ,[apellidoMaterno] ,[fechaAlta])
     VALUES
           ('BEDF441203D49', 'BEDF441203HSERZR00', 'Francisco Javier', 'Bernabe', 'Diaz', '20050819'),
           ('BEHN750719000', 'BEHN750719MGRLRR09', 'Noraney', 'Beltran', 'Hernandez', '20040211'),
           ('BEPB860909000', 'BEPB860909HGRDLS01', 'Bismarck Cayetano', 'Bedolla', 'Platero', '20050804'),
           ('BESC820502E14', 'BESC820502MSENLL00', 'Maria Del Carmen', 'Benitez', 'Salgado', '20040107'),
           ('BESS650131UK5', 'BESS650131HSERLR00', 'Serafin', 'Bernal', 'Salgado', '20030917'),
           ('BETA751228000', 'BETA751228HGRNBN01', 'Andres', 'Benitez', 'Taboada', '20030729'),
           ('BUSP8204276H2', 'BUSP820427HGRSLDOZ', 'Pedro', 'Bustamante', 'Salgado', '20031010'),
           ('CAEA781129SRA', 'CAEA781129MGRSLRO5', 'Araceli', 'Castrejon', 'Elizalde', '20051002'),
           ('CAGK810128TZ4', 'CAGK810128MSEHRT00', 'Katia', 'Chavez', 'Guerrero', '20050604'),
           ('CAGL720718000', 'CAGL720718MGRTSC02', 'Luciana', 'Catalan', 'Gusman', '20051209'),
           ('CAHE850328000', 'CAHE850328MGRSRL04', 'Elideth', 'Castro', 'Herrera', '20030314'),
           ('CAMA821217UJ2', 'CAMA821217MGRTRNO0', 'Anahi', 'Catarino', 'Martinez', '20030124'),
           ('CAMJ650413000', 'CAMJ650413MDFSRS06', 'Josefina', 'Casarrubias', 'Martinez', '20010323'),
           ('CAPH690316SZ3', 'CAPH690316HSESBR00', 'Heriberto', 'Casimiro', 'Poblete', '20040127'),
           ('CAQM871231000', 'CAQM871231MGRMNR04', 'Mariel Anahi', 'Campuzano', 'Quinto', '20001001'),
           ('CARC920814000', 'CARC920814HGRBMR07', 'Cristian Samuel', 'Cabañas', 'Ramirez', '20041214'),
           ('CARM590708000', 'CARM590608HGRLMG04', 'Miguel', 'Calixto', 'Ramirez', '20041015'),
           ('CARM780929000', 'CARM780929HGRHMG07', 'Miguel', 'Chavez', 'Ramirez', '20040825'),
           ('CARM810205000', 'CARM810205HGRRMG02', 'Miguel Angel', 'Carrera', 'Romero', '20050320'),
           ('CASF710129000', 'CASF710129MGRSGN08', 'Fany', 'Castro', 'Segura', '20050405'),
           ('CATH780914D73', 'CATH780914MGRSRDOO', 'Heidi', 'Castillo', 'Tornes', '20000627');

GO

INSERT INTO [dbo].[CAT_CMV_TIPO_CUENTA]
           ([idCuenta] ,[nombreCuenta])
     VALUES
           (0, 'Cuenta corriente'),
		   (1 ,'Cuenta de cheques'),
		   (2 ,'Cuenta de ahorro'),
		   (3 ,'Cuenta de nomina'),
		   (4 ,'Cuenta en dolares');
GO

INSERT INTO [dbo].[TBL_CMV_CLIENTE_CUENTA]
           ([idCliente] ,[idCuenta] ,[saldoActual] ,[fechaContratacion] ,[fechaUltimoMovimiento])
     VALUES
           (12, 0, 4148.41, '20070701', '20170508'),
           (16, 2, 58906.00, '20070302', '20090707'),
           (1, 3, 88067.58, '20070108', '20080224'),
           (11, 4, 51406.48, '20080308', '20090424'),
           (1, 2, 32696.15, '20100514', '20080406'),
           (19, 1, 52105.64, '20081117', '20091026'),
           (15, 3, 36099.77, '20100526', '20100812'),
           (13, 3, 7615.26, '20080608', '20081005'),
           (6, 2, 19424.67, '20081121', '20080701'),
           (4, 2, 22830.09, '20080303', '20100806'),
           (8, 2, 32298.16, '20081112', '20090916'),
           (13, 2, 41494.80, '20100103', '20091019'),
           (9, 2, 5083.93, '20080713', '20060728'),
           (4, 2, 5494.40, '20060904', '20060706'),
           (10, 1, 11488.10, '20060314', '20080615'),
           (9, 4, 30046.60, '20090415', '20080701'),
           (4, 3, 11544.26, '20060726', '20070219'),
           (12, 2, 53493.18, '20060923', '20090315'),
           (17, 4, 32902.00, '20060610', '20070404'),
           (5, 0, 23793.82, '20070214', '20070523'),
           (6, 2, 52300.85, '20060924', '20060301'),
           (8, 0, 3700.84, '20070331', '20090721'),
           (6, 3, 8482.31, '20080129', '20070701'),
           (5, 4, 949.98, '20090329', '20080501'),
           (3, 3, 3677.07, '20060915', '20071119'),
           (1, 0, 45246.60, '20081122', '20080116'),
           (6, 4, 9768.06, '20071225', '20060509'),
           (9, 1, 1707.05, '20071211', '20100801'),
           (5, 0, 5270.31, '20080201', '20061118'),
           (13, 0, 24779.12, '20070729', '20080103'),
           (11, 1, 40362.30, '20060406', '20060303'),
           (17, 4, 31605.70, '20091018', '20091229'),
           (10, 0, 16802.92, '20060927', '20070318'),
           (6, 2, 29050.01, '20061201', '20101227'),
           (20, 1, 8442.68, '20070920', '20090727'),
           (17, 3, 13076.51, '20091012', '20090913'),
           (3, 4, 52896.70, '20070422', '20070603'),
           (9, 0, 4937.91, '20061101', '20090406'),
           (7, 0, 13621.91, '20080809', '20070421'),
           (18, 3, 37574.54, '20100705', '20060606'),
           (12, 1, 16031.94, '20100610', '20090915');
GO


/*Creación del usuario Prueba*/
USE [master]
GO
CREATE LOGIN [Prueba] WITH PASSWORD=N'123456', DEFAULT_DATABASE=[CLIENTES_CMV], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO
use [CLIENTES_CMV];
GO
use [master];
GO
USE [CLIENTES_CMV]
GO
CREATE USER [Prueba] FOR LOGIN [Prueba]
GO
USE [CLIENTES_CMV]
GO
ALTER ROLE [db_owner] ADD MEMBER [Prueba]
GO

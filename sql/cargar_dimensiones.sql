
-- =============================================
-- PROYECTO: DATA WAREHOUSE ITLA
-- BASE DE DATOS: DW_ITLA
-- MODELO: ESQUEMA ESTRELLA
-- =============================================

-- 1. CREAR BASE DE DATOS
USE master;
GO

IF DB_ID('DW_ITLA') IS NULL
BEGIN
    CREATE DATABASE DW_ITLA;
END
GO

USE DW_ITLA;
GO

-- =============================================
-- 2. DIMENSION FECHA
-- =============================================

CREATE TABLE DimFecha (
    FechaKey INT PRIMARY KEY,
    Fecha DATE NOT NULL,
    Dia INT,
    Mes INT,
    NombreMes NVARCHAR(20),
    Trimestre INT,
    Anio INT,
    DiaSemana INT,
    NombreDia NVARCHAR(20)
);
GO

-- CARGAR FECHAS DESDE 2020 HASTA 2035

DECLARE @Fecha DATE = '2020-01-01';

WHILE @Fecha <= '2035-12-31'
BEGIN
    INSERT INTO DimFecha (
        FechaKey, Fecha, Dia, Mes,
        NombreMes, Trimestre, Anio,
        DiaSemana, NombreDia
    )
    VALUES (
        CONVERT(INT, FORMAT(@Fecha, 'yyyyMMdd')),
        @Fecha,
        DAY(@Fecha),
        MONTH(@Fecha),
        DATENAME(MONTH, @Fecha),
        DATEPART(QUARTER, @Fecha),
        YEAR(@Fecha),
        DATEPART(WEEKDAY, @Fecha),
        DATENAME(WEEKDAY, @Fecha)
    );

    SET @Fecha = DATEADD(DAY, 1, @Fecha);
END;
GO

-- =============================================
-- 3. DIMENSION CLIENTE
-- =============================================

CREATE TABLE DimCliente (
    ClienteKey INT IDENTITY(1,1) PRIMARY KEY,
    ClienteID INT NOT NULL UNIQUE,
    Nombre NVARCHAR(100),
    Apellido NVARCHAR(100),
    Correo NVARCHAR(150),
    Telefono NVARCHAR(20),
    Ciudad NVARCHAR(100),
    Provincia NVARCHAR(100),
    Pais NVARCHAR(100)
);
GO

-- =============================================
-- 4. DIMENSION PRODUCTO
-- =============================================

CREATE TABLE DimProducto (
    ProductoKey INT IDENTITY(1,1) PRIMARY KEY,
    ProductoID INT NOT NULL UNIQUE,
    NombreProducto NVARCHAR(150),
    Categoria NVARCHAR(100),
    Marca NVARCHAR(100),
    Precio DECIMAL(12,2)
);
GO

-- =============================================
-- 5. DIMENSION SUCURSAL
-- =============================================

CREATE TABLE DimSucursal (
    SucursalKey INT IDENTITY(1,1) PRIMARY KEY,
    SucursalID INT NOT NULL UNIQUE,
    NombreSucursal NVARCHAR(150),
    Ciudad NVARCHAR(100),
    Provincia NVARCHAR(100),
    Pais NVARCHAR(100)
);
GO

-- =============================================
-- 6. DIMENSION VENDEDOR
-- =============================================

CREATE TABLE DimVendedor (
    VendedorKey INT IDENTITY(1,1) PRIMARY KEY,
    VendedorID INT NOT NULL UNIQUE,
    Nombre NVARCHAR(100),
    Apellido NVARCHAR(100),
    Departamento NVARCHAR(100),
    Cargo NVARCHAR(100)
);
GO

-- =============================================
-- 7. INDICES PARA OPTIMIZAR CONSULTAS
-- =============================================

CREATE INDEX IX_DimFecha_Anio
ON DimFecha(Anio);

CREATE INDEX IX_DimCliente_Ciudad
ON DimCliente(Ciudad);

CREATE INDEX IX_DimProducto_Categoria
ON DimProducto(Categoria);

CREATE INDEX IX_DimSucursal_Ciudad
ON DimSucursal(Ciudad);

-- =============================================
-- 8. INSERTAR DATOS DE EJEMPLO
-- =============================================

INSERT INTO DimCliente
(ClienteID, Nombre, Apellido, Correo, Telefono, Ciudad, Provincia, Pais)
VALUES
(1, 'Juan', 'Perez', 'juan@email.com', '8091111111', 'Santo Domingo', 'Distrito Nacional', 'Republica Dominicana'),
(2, 'Maria', 'Garcia', 'maria@email.com', '8092222222', 'Santiago', 'Santiago', 'Republica Dominicana'),
(3, 'Pedro', 'Lopez', 'pedro@email.com', '8093333333', 'La Vega', 'La Vega', 'Republica Dominicana');

INSERT INTO DimProducto
(ProductoID, NombreProducto, Categoria, Marca, Precio)
VALUES
(1, 'Laptop', 'Tecnologia', 'HP', 35000.00),
(2, 'Mouse', 'Accesorios', 'Logitech', 850.00),
(3, 'Teclado', 'Accesorios', 'Dell', 1500.00);

INSERT INTO DimSucursal
(SucursalID, NombreSucursal, Ciudad, Provincia, Pais)
VALUES
(1, 'Sucursal Central', 'Santo Domingo', 'Distrito Nacional', 'Republica Dominicana'),
(2, 'Sucursal Norte', 'Santiago', 'Santiago', 'Republica Dominicana'),
(3, 'Sucursal Este', 'La Romana', 'La Romana', 'Republica Dominicana');

INSERT INTO DimVendedor
(VendedorID, Nombre, Apellido, Departamento, Cargo)
VALUES
(1, 'Carlos', 'Rodriguez', 'Ventas', 'Supervisor'),
(2, 'Ana', 'Martinez', 'Ventas', 'Vendedora'),
(3, 'Luis', 'Fernandez', 'Ventas', 'Vendedor');
GO

-- =============================================
-- 9. VERIFICAR LAS DIMENSIONES CARGADAS
-- =============================================

SELECT * FROM DimFecha;
SELECT * FROM DimCliente;
SELECT * FROM DimProducto;
SELECT * FROM DimSucursal;
SELECT * FROM DimVendedor;
GO

-- =============================================
-- 10. RESUMEN DE REGISTROS
-- =============================================

SELECT 'DimFecha' AS Tabla, COUNT(*) AS Registros FROM DimFecha
UNION ALL
SELECT 'DimCliente', COUNT(*) FROM DimCliente
UNION ALL
SELECT 'DimProducto', COUNT(*) FROM DimProducto
UNION ALL
SELECT 'DimSucursal', COUNT(*) FROM DimSucursal
UNION ALL
SELECT 'DimVendedor', COUNT(*) FROM DimVendedor;
GO


-- =============================================
-- VERIFICACION DE DIMENSIONES
-- PROYECTO: DW_ITLA
-- =============================================

USE DW_ITLA;
GO

-- 1. Verificar que existan las dimensiones

SELECT
    TABLE_NAME AS NombreTabla
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE'
AND TABLE_NAME IN (
    'DimFecha',
    'DimCliente',
    'DimProducto',
    'DimSucursal',
    'DimVendedor'
)
ORDER BY TABLE_NAME;
GO

-- 2. Verificar cantidad de registros

SELECT 'DimFecha' AS Dimension, COUNT(*) AS TotalRegistros
FROM DimFecha
UNION ALL
SELECT 'DimCliente', COUNT(*) FROM DimCliente
UNION ALL
SELECT 'DimProducto', COUNT(*) FROM DimProducto
UNION ALL
SELECT 'DimSucursal', COUNT(*) FROM DimSucursal
UNION ALL
SELECT 'DimVendedor', COUNT(*) FROM DimVendedor;
GO

-- 3. Consultar los datos de cada dimension

SELECT TOP 10 * FROM DimFecha;
SELECT * FROM DimCliente;
SELECT * FROM DimProducto;
SELECT * FROM DimSucursal;
SELECT * FROM DimVendedor;
GO

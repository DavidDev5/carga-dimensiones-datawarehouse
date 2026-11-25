
# INSTITUTO TECNOLÓGICO DE LAS AMÉRICAS (ITLA)

# Carga de Dimensiones del Almacén de Datos

## Introducción

El presente proyecto tiene como finalidad desarrollar la estructura dimensional de un almacén de datos utilizando SQL Server y organizar los scripts mediante GitHub.

## Objetivo

Diseñar y preparar las dimensiones necesarias para un modelo de Data Warehouse orientado al análisis de información de ventas.

## Base de datos

Nombre: DW_ITLA

Modelo: Esquema estrella.

## Dimensiones

1. DimFecha: almacena información temporal.
2. DimCliente: contiene información de clientes.
3. DimProducto: contiene información de productos.
4. DimSucursal: almacena información de sucursales.
5. DimVendedor: contiene información de vendedores.

## Herramientas utilizadas

- GitHub.
- GitHub Actions.
- SQL Server (tecnología objetivo del script).
- SQL (T-SQL).

## Procedimiento

1. Creación del repositorio en GitHub.
2. Desarrollo del script de creación de dimensiones.
3. Elaboración de consultas de verificación.
4. Configuración de GitHub Actions.
5. Validación sintáctica de los archivos SQL.

## Resultados

Se configuró correctamente un workflow de GitHub Actions que finalizó con estado exitoso.

Los scripts SQL quedaron almacenados en el repositorio.

Nota: La ejecución contra un motor SQL Server real y la comprobación de registros cargados quedan pendientes de realizar.

## Repositorio


[Ver repositorio del proyecto](https://github.com/DavidDev5/carga-dimensiones-datawarehouse)

## Conclusión

El proyecto permitió organizar los scripts de un modelo dimensional y utilizar herramientas de integración continua para validar los archivos SQL.

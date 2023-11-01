USE ProyectoPeluqueria

CREATE VIEW VistaCantidadProductos AS
SELECT
    d.nombre AS NombreDeposito,
    p.descripcion AS DescripcionProducto,
    ppd.cantidad AS CantidadEnDeposito
FROM productos_por_depositos ppd
INNER JOIN depositos d ON ppd.id_deposito = d.id_deposito
INNER JOIN productos p ON ppd.id_producto = p.id_producto;

CREATE VIEW VistaExistenciaProductos AS
SELECT
    p.id_producto,
    p.descripcion AS Producto,
    SUM(ppd.cantidad) AS ExistenciaTotal
FROM
    productos p
LEFT JOIN
    productos_por_depositos ppd ON p.id_producto = ppd.id_producto
GROUP BY
    p.id_producto, p.descripcion;

-- Crear una vista de facturas de proveedores vencidas con nombres de proveedores
CREATE VIEW FacturasVencidas AS
SELECT
    f.id_factura,
    p.nombre AS nombre_proveedor,
    f.fecha_compra,
    f.condicion_compra,
    f.fecha_vencimiento,
    f.numero_factura,
    f.total,
    f.saldo_pendiente
FROM
    facturas f
JOIN
    proveedores p ON f.id_proveedor = p.id_proveedor -- Realizar una uni�n con la tabla de proveedores
WHERE
    f.fecha_vencimiento < GETDATE(); -- Filtrar facturas vencidas


select * from VistaCantidadProductos Where DescripcionProducto ='shampoo nivea';
select * from VistaExistenciaProductos Where producto ='shampoo nivea';
select * from FacturasVencidas
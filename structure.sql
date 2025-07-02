DROP DATABASE IF EXISTS examen;
CREATE DATABASE IF NOT EXISTS examen;
USE examen;
DROP TABLE IF EXISTS `pais`;

CREATE TABLE `pais` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pais_unique` (`nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



DROP TABLE IF EXISTS `departamento`;

CREATE TABLE `departamento` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(80) NOT NULL,
  `paisid` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `departamento_pais_FK` (`paisid`),
  CONSTRAINT `departamento_pais_FK` FOREIGN KEY (`paisid`) REFERENCES `pais` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;




DROP TABLE IF EXISTS `municipio`;

CREATE TABLE `municipio` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(80) DEFAULT NULL,
  `depid` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `municipio_departamento_FK` (`depid`),
  CONSTRAINT `municipio_departamento_FK` FOREIGN KEY (`depid`) REFERENCES `departamento` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `empresa`;

CREATE TABLE `empresa` (
  `id` VARCHAR(100) NOT NULL ,
  `nombre` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `empresa_unique` (`nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `sucursal`;
CREATE TABLE `sucursal` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(80) NOT NULL,
  `direccion` varchar(80) NOT NULL,
  `empresaid` VARCHAR(100) NOT NULL,
  `municipioid` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sucursal_empresa_FK` (`empresaid`),
  KEY `sucursal_municipio_FK` (`municipioid`),
  CONSTRAINT `sucursal_empresa_FK` FOREIGN KEY (`empresaid`) REFERENCES `empresa` (`id`),
  CONSTRAINT `sucursal_municipio_FK` FOREIGN KEY (`municipioid`) REFERENCES `municipio` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `clientes`;

CREATE TABLE `clientes` (
  `cliente_id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(80) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  `direccion` varchar(50) DEFAULT NULL,
  `fecha_registro` date DEFAULT NULL,
  `municipioid` int DEFAULT NULL,
  PRIMARY KEY (`cliente_id`),
  UNIQUE KEY `email` (`email`),
  KEY `clientes_municipio_FK` (`municipioid`),
  CONSTRAINT `clientes_municipio_FK` FOREIGN KEY (`municipioid`) REFERENCES `municipio` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `empleados`;

CREATE TABLE `empleados` (
  `empleado_id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(80) DEFAULT NULL,
  `puesto` varchar(50) DEFAULT NULL,
  `fecha_contratacion` date DEFAULT NULL,
  `salario` decimal(10,2) DEFAULT NULL,
  `sucursalid` int DEFAULT NULL,
  PRIMARY KEY (`empleado_id`),
  KEY `empleados_sucursal_FK` (`sucursalid`),
  CONSTRAINT `empleados_sucursal_FK` FOREIGN KEY (`sucursalid`) REFERENCES `sucursal` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



DROP TABLE IF EXISTS `pedidos`;

CREATE TABLE `pedidos` (
  `pedido_id` int NOT NULL AUTO_INCREMENT,
  `cliente_id` int DEFAULT NULL,
  `empleado_id` int DEFAULT NULL,
  `fecha_pedido` date DEFAULT NULL,
  `estado` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`pedido_id`),
  KEY `cliente_id` (`cliente_id`),
  KEY `empleado_id` (`empleado_id`),
  CONSTRAINT `pedidos_ibfk_1` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`cliente_id`),
  CONSTRAINT `pedidos_ibfk_2` FOREIGN KEY (`empleado_id`) REFERENCES `empleados` (`empleado_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;




DROP TABLE IF EXISTS `productos`;
CREATE TABLE `productos` (
  `producto_id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(80) DEFAULT NULL,
  `categoria` varchar(80) DEFAULT NULL,
  `precio` decimal(10,2) DEFAULT NULL,
  `stock` int DEFAULT NULL,
  PRIMARY KEY (`producto_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;






DROP TABLE IF EXISTS `producto_suc`;

CREATE TABLE `producto_suc` (
  `productoid` int NOT NULL,
  `sucursalid` int NOT NULL,
  PRIMARY KEY (`productoid`,`sucursalid`),
  KEY `producto_suc_sucursal_FK` (`sucursalid`),
  CONSTRAINT `producto_suc_productos_FK` FOREIGN KEY (`productoid`) REFERENCES `productos` (`producto_id`),
  CONSTRAINT `producto_suc_sucursal_FK` FOREIGN KEY (`sucursalid`) REFERENCES `sucursal` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;




DROP TABLE IF EXISTS `detalles_pedidos`;
CREATE TABLE `detalles_pedidos` (
  `detalle_id` int NOT NULL AUTO_INCREMENT,
  `pedido_id` int DEFAULT NULL,
  `producto_id` int DEFAULT NULL,
  `cantidad` int DEFAULT NULL,
  `precio_unitario` decimal(10,2) DEFAULT NULL,
  `sucid` int DEFAULT NULL,
  PRIMARY KEY (`detalle_id`),
  KEY `pedido_id` (`pedido_id`),
  KEY `detalles_pedidos_producto_suc_FK` (`producto_id`,`sucid`),
  CONSTRAINT `detalles_pedidos_ibfk_1` FOREIGN KEY (`pedido_id`) REFERENCES `pedidos` (`pedido_id`),
  CONSTRAINT `detalles_pedidos_producto_suc_FK` FOREIGN KEY (`producto_id`, `sucid`) REFERENCES `producto_suc` (`productoid`, `sucursalid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;





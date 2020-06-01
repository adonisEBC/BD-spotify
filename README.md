# BD-spotify
-- MySQL dump 10.13  Distrib 8.0.19, for osx10.14 (x86_64)
--
-- Host: 127.0.0.1    Database: world
-- ------------------------------------------------------
-- Server version	8.0.19-debug
CREATE TABLE `usuario` (
  `id_user` int PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `Nombre_user` char(35) NOT NULL,
  `Correo` char(3) NOT NULL,
  `Contraseña` char(20) NOT NULL,
  `Fecha_creacion` date NOT NULL,
  `Nombre` char(35) NOT NULL,
  `apellido` char(35) NOT NULL ,
  `ciudad` char(35) NOT NULL 
);

CREATE TABLE `login` (
  `id_login` int(11) PRIMARY KEY NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_salida` date NOT NULL 
);

CREATE TABLE `albunes` (
  `id` int(11) PRIMARY KEY NOT NULL,
  `id_album` int(11) NOT NULL,
  `nombre` int(25) NOT NULL,
  `artista` int(25) NOT NULL,
  `fecha de estreno` date NOT NULL
);

CREATE TABLE `artistas` (
  `id` int(11) PRIMARY KEY NOT NULL,
  `id_artista` int(11) NOT NULL,
  `nombre` varchar(25) NOT NULL,
  `apellido` varchar(25) NOT NULL
);

CREATE TABLE `canciones` (
  `id_cancion` int(11) PRIMARY KEY NOT NULL,
  `nombre` varchar(25) NOT NULL,
  `id_artista` int(11) NOT NULL,
  `id_album` int(11) NOT NULL,
  `id_genero` int(11) NOT NULL
);

CREATE TABLE `pago` (
  `id_pago` int(11) PRIMARY KEY NOT NULL,
  `fecha_create` date NOT NULL,
  `tipo_pago` int(8) NOT NULL,
  `id_user` int NOT NULL 
);

CREATE TABLE `lista_reproducciones` (
  `id` int(10) PRIMARY KEY NOT NULL,
  `nombre` int(25) NOT NULL,
  `usuario` int(8) NOT NULL
);


CREATE TABLE `factura` (
  `id_factura` int(11) PRIMARY KEY NOT NULL,
  `id_pago` int(11) NOT NULL,
  `fecha_emision` date NOT NULL
);

CREATE TABLE `detalle` (
  `num_detalle` int(11) PRIMARY KEY NOT NULL,
  `id_factura` int(11) NOT NULL,
  `id_pago` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio` int(11) NOT NULL
);

CREATE TABLE `producto` (
  `id_producto` int(11) PRIMARY KEY NOT NULL,
  `nombre` varchar(8) NOT NULL,
  `precio` int(11) NOT NULL,
  `stock` int(8) NOT NULL
);

CREATE TABLE `canciones_preferidas` (
  `id_cancionpre` int(11) PRIMARY KEY NOT NULL,
  `nombre` varchar(8) NOT NULL,
  `id_user` int NOT NULL 
);

CREATE TABLE `lista_cancion_preferidas` (
  `id_cancionpre` int(11) PRIMARY KEY NOT NULL,
  `id_cancion` int(11) NOT NULL
);

CREATE TABLE `genero` (
  `id` int(11) PRIMARY KEY NOT NULL,
  `nombre` varchar(11) NOT NULL,
  `id_genero` int(11) NOT NULL
);

CREATE TABLE `forma_pago` (
  `id` int(11) PRIMARY KEY NOT NULL,
  `id_pago` int(11) NOT NULL,
  `nombre` varchar(11) NOT NULL,
  `apellido` varchar(11) NOT NULL,
  `numero_tarjeta` int(11) NOT NULL,
  `fecha_inicio_pago` date NOT NULL
);

CREATE TABLE `identity_rol` (
  `id_identity` int(11) PRIMARY KEY NOT NUll,
  `tipo_rol` char(30) NOT NULL DEFAULT ""
 
);

CREATE TABLE `rol_user` (
  `id_rol` int(11) PRIMARY KEY NOT NULL,
  `tipo_user` char(30) NOT NULL ,
  `fecha_update` date NOT NULL, 
  `id_identity` int(11) NOT NULL
);


CREATE TABLE `playlist` (
  `id` int(11) PRIMARY KEY NOT NULL,
  `nombre` varchar(11) NOT NULL,
  `id_genero` int(11) NOT NULL,
  `id_cancion` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL
);

ALTER TABLE `usuario` ADD FOREIGN KEY (`id_user`) REFERENCES `identity_rol` (`id_identity`);

ALTER TABLE `usuario` ADD FOREIGN KEY (`id_user`) REFERENCES `login` (`id_login`);

ALTER TABLE `usuario` ADD FOREIGN KEY (`id_user`) REFERENCES `canciones_preferidas` (`id_cancionpre`);

ALTER TABLE `identity_rol` ADD FOREIGN KEY (`id_identity`) REFERENCES `rol_user` (`id_rol`);

ALTER TABLE `usuario` ADD FOREIGN KEY (`id_user`) REFERENCES `playlist` (`id`);

ALTER TABLE `pago` ADD FOREIGN KEY (`id_pago`) REFERENCES `usuario` (`id_user`);

ALTER TABLE `forma_pago` ADD FOREIGN KEY (`id_pago`) REFERENCES `factura` (`id_factura`);

ALTER TABLE `lista_cancion_preferidas` ADD FOREIGN KEY (`id_cancionpre`) REFERENCES `canciones_preferidas` (`id_cancionpre`);

ALTER TABLE `canciones` ADD FOREIGN KEY (`id_cancion`) REFERENCES `lista_cancion_preferidas` (`id_cancionpre`);

ALTER TABLE `canciones` ADD FOREIGN KEY (`id_cancion`) REFERENCES `lista_reproducciones` (`id`);

ALTER TABLE `artistas` ADD FOREIGN KEY (`id_artista`) REFERENCES `canciones` (`id_cancion`);

ALTER TABLE `genero` ADD FOREIGN KEY (`id_genero`) REFERENCES `canciones` (`id_cancion`);

ALTER TABLE `albunes` ADD FOREIGN KEY (`id_album`) REFERENCES `artistas` (`id_artista`);

CREATE INDEX `id_user` ON `usuario` (`id_user`);

CREATE INDEX `id_identity` ON `identity_rol` (`id_identity`);

CREATE TABLE `albunes` (
  `id` int(11) NOT NULL,
  `id_album` int(11) NOT NULL,
  `nombre` int(25) NOT NULL,
  `artista` int(25) DEFAULT NULL,
  `fecha de estreno` date(10) NOT NULL
);

CREATE TABLE `artistas` (
  `id` int(11) NOT NULL,
  `id_artista` int(11) NOT NULL,
  `nombre` varchar(25) NOT NULL,
  `apellido` varchar(25) NOT NULL
);

CREATE TABLE `canciones` (
  `id_cancion` int(11) NOT NULL,
  `nombre` varchar(25) NOT NULL,
  `id_artista` int(11) NOT NULL,
  `id_album` int(11) NOT NULL,
  `id_genero` int(11) NOT NULL
);

CREATE TABLE `usuario` (
  `id_user` int(11) NOT NULL,
  `nombre` varchar(25) NOT NULL,
  `contraseña` int(8) NOT NULL
);

CREATE TABLE `pago` (
  `id_pago` int(11) NOT NULL,
  `fecha_create` date(25) NOT NULL,
  `tipo_pago` int(8) NOT NULL,
  `id_user` int(8) NOT NULL
);

CREATE TABLE `lista_reproducciones` (
  `id` int(10) NOT NULL,
  `nombre` int(25) NOT NULL,
  `usuario` int(8) NOT NULL
);

CREATE TABLE `artistas_favoritos` (
  `id_artista` int(11) NOT NULL,
  `id_genero` int(8) NOT NULL
);

CREATE TABLE `rol_user` (
  `id` int(11) NOT NULL,
  `tipo_user` varchar(25) NOT NULL,
  `fecha_update` date(8) NOT NULL
);

CREATE TABLE `identity_rol` (
  `id` int(11) NOT NULL,
  `tipo_rol` varchar(25) NOT NULL
);

CREATE TABLE `factura` (
  `id_factura` int(11) NOT NULL,
  `id_pago` int(11) NOT NULL,
  `fecha_emision` date(25) NOT NULL
);

CREATE TABLE `detalle` (
  `num_detalle` int(11) NOT NULL,
  `id_factura` int(11) NOT NULL,
  `id_pago` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio` int(11) NOT NULL
);

CREATE TABLE `producto` (
  `id_producto` int(11) NOT NULL,
  `nombre` varchar(8) NOT NULL,
  `precio` int(11) NOT NULL,
  `stock` int(8) NOT NULL
);

CREATE TABLE `canciones_preferidas` (
  `id_cancionpre` int(11) NOT NULL,
  `nombre` varchar(8) NOT NULL,
  `id_user` int(11) NOT NULL
);

CREATE TABLE `lista_cancion_preferidas` (
  `id_cancionpre` int(11) NOT NULL,
  `id_cancion` int(11) NOT NULL
);

CREATE TABLE `genero` (
  `id` int(11) NOT NULL,
  `nombre` varchar(11) NOT NULL,
  `id_genero` int(11) NOT NULL
);

CREATE TABLE `forma_pago` (
  `id` int(11) NOT NULL,
  `id_pago` int(11) NOT NULL,
  `nombre` varchar(11) NOT NULL,
  `apellido` varchar(11) NOT NULL,
  `numero_tarjeta` int(11) NOT NULL,
  `fecha_inicio_pago` date(11) NOT NULL
);

CREATE TABLE `playlist` (
  `id` int(11) NOT NULL,
  `nombre` varchar(11) NOT NULL,
  `id_genero` int(11) NOT NULL,
  `id_cancion` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL
);

ALTER TABLE `usuario` ADD FOREIGN KEY (`id_user`) REFERENCES `rolidentity` (`id`);

ALTER TABLE `pago` ADD FOREIGN KEY (`id_pago`) REFERENCES `usuario` (`id_user`);

ALTER TABLE `identity_rol` ADD FOREIGN KEY (`id`) REFERENCES `rol_user` (`id`);

ALTER TABLE `factura` ADD FOREIGN KEY (`id_factura`) REFERENCES `pago` (`id_pago`);

ALTER TABLE `forma_pago` ADD FOREIGN KEY (`id_pago`) REFERENCES `factura` (`id_factura`);

ALTER TABLE `detalle` ADD FOREIGN KEY (`num_detalle`) REFERENCES `forma_pago` (`id`);

ALTER TABLE `producto` ADD FOREIGN KEY (`id_producto`) REFERENCES `forma_pago` (`id`);

ALTER TABLE `canciones_preferidas` ADD FOREIGN KEY (`id_cancionpre`) REFERENCES `usuario` (`id_user`);

ALTER TABLE `lista_cancion_preferidas` ADD FOREIGN KEY (`id_cancionpre`) REFERENCES `canciones_preferidas` (`id_cancionpre`);

ALTER TABLE `canciones` ADD FOREIGN KEY (`id_cancion`) REFERENCES `lista_cancion_preferidas` (`id_cancion`);

ALTER TABLE `usuario` ADD FOREIGN KEY (`id_user`) REFERENCES `lista_reproducciones` (`id`);

ALTER TABLE `canciones` ADD FOREIGN KEY (`id_cancion`) REFERENCES `lista_reproducciones` (`id`);

ALTER TABLE `artistas` ADD FOREIGN KEY (`id_artista`) REFERENCES `canciones` (`id_cancion`);

ALTER TABLE `genero` ADD FOREIGN KEY (`id_genero`) REFERENCES `canciones` (`id_cancion`);

ALTER TABLE `albunes` ADD FOREIGN KEY (`id_album`) REFERENCES `artistas` (`id`);

ALTER TABLE `artistas_favoritos` ADD FOREIGN KEY (`id_artista`) REFERENCES `artistas` (`id`);

ALTER TABLE `artistas_favoritos` ADD FOREIGN KEY (`id_artista`) REFERENCES `genero` (`id`);

ALTER TABLE `playlist` ADD FOREIGN KEY (`id`) REFERENCES `albunes` (`id_album`);

ALTER TABLE `usuario` ADD FOREIGN KEY (`id_user`) REFERENCES `playlist` (`id`);

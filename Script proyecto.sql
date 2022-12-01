-- -----------------------------------------------------
-- Creación de la BD
-- Equipo conformado por:
-- Aldana Sierra Mariel Aislin
-- Perez Hernandez Ariadna
-- Morales Garcia Johan
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS das_proyecto;
USE das_proyecto;

-- -----------------------------------------------------
-- Creación de la tabla usuario
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS usuario (
  usu_cve_usuario 		VARCHAR(8)		NOT NULL,
  usu_nombre 			VARCHAR(30) 	NOT NULL,
  usu_ape_paterno 		VARCHAR(30) 	NOT NULL,
  usu_ape_materno 		VARCHAR(30) 	NOT NULL,
  usu_fecha_nac 		DATE 			NOT NULL,
  usu_usuario			VARCHAR(20) 	NOT NULL,
  usu_contrasena		VARCHAR(30) 	NOT NULL,
  usu_carrera 			ENUM("Ing. Diseño Industrial", "Ing. Civil", "Ing. Eléctrica", "Ing. Industrial", "Ing. Mecánica",
						"Ing. Química", "Ing. Sistemas Computacionales", "Ing. ITIC’s", "Ing. Gestión Empresarial", 
						"Lic. Arquitectura", "Lic. Administración")		NOT NULL,
  PRIMARY KEY (usu_cve_usuario)
);
-- -----------------------------------------------------
-- Inserción de datos en la tabla usuario
-- -----------------------------------------------------
INSERT INTO usuario VALUES ('18200744', 'Mariel Aislin', 'Aldana', 'Sierra', '2000-10-18', 'anathema', '123456', 'Ing. Sistemas Computacionales');
INSERT INTO usuario VALUES ('18200782 ', 'Ariadna', 'Perez', 'Hernandez', '2000-11-04', 'arihdez', '123456', 'Ing. Sistemas Computacionales');
INSERT INTO usuario VALUES ('18200775', 'Johan', 'Morales', 'Garcia', '2000-02-21', 'gohan', '123456', 'Ing. Sistemas Computacionales');
select * from usuario;

-- -----------------------------------------------------
-- Creación de la tabla item
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS item (
  ite_cve_item	 	INT 								NOT NULL 	AUTO_INCREMENT,
  ite_descripcion 	VARCHAR(100) 						NOT NULL,
  ite_tipo			ENUM("Digital", "Físico", "Hardware") NOT NULL,
  ite_estado 		ENUM("Disponible", "No disponible")	NOT NULL,
  ite_categoria		ENUM("Electrónica", "Ciencias", "Química", "Matemáticas", "Código", "Documentación")	NOT NULL,
  usu_cve_usuario 		VARCHAR(8)		NOT NULL,
  FOREIGN KEY(usu_cve_usuario) REFERENCES usuario(usu_cve_usuario),
  PRIMARY KEY (ite_cve_item)
);
-- -----------------------------------------------------
-- Inserción de datos en la tabla item
-- -----------------------------------------------------
INSERT INTO item (ite_descripcion, ite_tipo,ite_estado,ite_categoria,usu_cve_usuario) VALUES ('3.6 Señales IR en IoT', 'Digital', 'Disponible','Documentación','18200744');
INSERT INTO item (ite_descripcion, ite_tipo,ite_estado,ite_categoria,usu_cve_usuario) VALUES ('Sistema Experto Difuso', 'Digital', 'Disponible', 'Código','18200782');
INSERT INTO item (ite_descripcion, ite_tipo,ite_estado,ite_categoria,usu_cve_usuario) VALUES ('Arduino UNO', 'Hardware', 'Disponible','Electrónica','18200775');
select * from item;

-- -----------------------------------------------------
-- Creación de la tabla prestamo
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS prestamo (
  pre_cve_prestamo			INT 		NOT NULL	AUTO_INCREMENT,
  usu_cve_usuario_prestamista 	VARCHAR(8)	NOT NULL,
  ite_cve_item 					INT 		NOT NULL,
  usu_cve_usuario_solicitante	VARCHAR(8) 	NOT NULL,
  pre_inicio_prestamo			DATE 		NOT NULL,
  pre_fin_prestamo 				DATE 		NULL,
  pre_lugar 					ENUM("Huevodromo", "Biblioteca", "Entrada", "Estacionamiento") NULL,
  pre_hora 						TIME 		NULL,
  pre_estado					ENUM("En prestamo", "Devuelto") NULL,
  PRIMARY KEY (pre_cve_prestamo),
  FOREIGN KEY(usu_cve_usuario_prestamista) REFERENCES usuario(usu_cve_usuario),
  FOREIGN KEY(usu_cve_usuario_solicitante) REFERENCES usuario(usu_cve_usuario),
  FOREIGN KEY(ite_cve_item) REFERENCES item(ite_cve_item)
);
-- -----------------------------------------------------
-- Inserción de datos en prestamo
-- -----------------------------------------------------
INSERT INTO prestamo (pre_cve_prestamo, usu_cve_usuario_prestamista, ite_cve_item, usu_cve_usuario_solicitante, pre_inicio_prestamo, pre_estado) VALUES (NULL, '18200744', '1', '18200775', '2022-11-20','En prestamo');
INSERT INTO prestamo (pre_cve_prestamo, usu_cve_usuario_prestamista, ite_cve_item, usu_cve_usuario_solicitante, pre_inicio_prestamo, pre_fin_prestamo, pre_lugar, pre_hora, pre_estado) VALUES (NULL, '18200782', '3', '18200744', '2022-11-20', '2022-11-30', 'Huevodromo', '10:00:00','En prestamo');
INSERT INTO prestamo (pre_cve_prestamo, usu_cve_usuario_prestamista, ite_cve_item, usu_cve_usuario_solicitante, pre_inicio_prestamo, pre_estado) VALUES (NULL, '18200775', '2', '18200782', '2022-11-22','En prestamo');
select * from prestamo;

-- -----------------------------------------------------
-- Creación del procedimiento de registro de usuario
-- -----------------------------------------------------
-- REGLAS: 
-- 1. No se puede registrar un usuario exactamente con el mismo nombre, paterno y materno
-- 2. No se puede registrar un usuario que ya exista
-- 3. No se puede registrar un usuario con una clave registrada anteriormente

delimiter $$
CREATE PROCEDURE spInsUsuario
(
  IN clave 			VARCHAR(8),
  IN nombre 		VARCHAR(30),
  IN paterno 		VARCHAR(30),
  IN materno 		VARCHAR(30),
  IN fecha_nac 		DATE,
  IN usuario		VARCHAR(20),
  IN contrasena		VARCHAR(30),
  IN carrera 		ENUM("Ing. Diseño Industrial", "Ing. Civil", "Ing. Eléctrica", "Ing. Industrial", "Ing. Mecánica",
					"Ing. Química", "Ing. Sistemas Computacionales", "Ing. ITIC’s", "Ing. Gestión Empresarial", 
                    "Lic. Arquitectura", "Lic. Administración")
)
BEGIN
	-- 1ER VALIDACION
    IF NOT EXISTS(SELECT usu_cve_usuario FROM usuario WHERE usu_nombre = nombre AND usu_ape_paterno = paterno AND usu_ape_materno = materno ) THEN
		-- 2DA VALIDACION
		IF NOT EXISTS(SELECT usu_cve_usuario FROM usuario WHERE usu_usuario = usuario ) THEN
			-- 3ERA VALIDACION
			IF NOT EXISTS(SELECT usu_cve_usuario FROM usuario WHERE usu_cve_usuario = clave ) THEN
				INSERT INTO usuario VALUES (clave, nombre, paterno, materno, fecha_nac, usuario, contrasena, carrera);
				SELECT '0';
            ELSE
				SELECT '1';
                -- La clave ya está registrada
			END IF;
        ELSE
			SELECT '2';
            -- El usuario ya está registrado
		END IF;
	ELSE
		SELECT '3'; 
        -- El nombre ya está registrado
	END IF;
END $$
delimiter ;
-- -----------------------------------------------------
-- Ejecución del procedimiento 
-- -----------------------------------------------------
-- Se inserta: 0
call spInsUsuario ( '18200765','Nancy', 'Hernandez', 'Sanchez', '2000-09-08', 'nanhdz', '123456', 'Ing. Sistemas Computacionales'); 
-- La clave ya está registrada: 1
call spInsUsuario ( '18200744','Mario', 'Gomez', 'Monrroy', '2000-10-28', 'mariomon', '123456', 'Ing. Civil'); 
-- El usuario ya está registrado: 2
call spInsUsuario ( '20200755','Nancy', 'Hernandez', 'Gomez', '2002-03-24', 'nanhdz', '123456', 'Ing. Diseño Industrial'); 
-- El nombre ya está registrado: 3
call spInsUsuario ( '19200999','Mariel Aislin', 'Aldana', 'Sierra', '2002-03-24', 'aisanath', '123456', 'Ing. Diseño Industrial'); 
select * from usuario;

-- -----------------------------------------------------
-- Creación del procedimiento de registro de item
-- -----------------------------------------------------
-- Reglas:
-- 1. El usuario exista
delimiter $$
CREATE PROCEDURE spInsItem
(
  IN descripcion 	VARCHAR(100),
  IN tipo			ENUM("Digital", "Fisico", "Hardware"),
  IN estado 		ENUM("Disponible", "No disponible"),
  IN categoria		ENUM("Electronica", "Ciencias", "Quimica", "Matematicas", "Codigo", "Documentacion"),
  IN cve_usuario 	VARCHAR(8)
)
BEGIN
    -- 1ER VALIDACION
    IF EXISTS(SELECT usu_cve_usuario FROM usuario WHERE usu_cve_usuario = cve_usuario) THEN
		INSERT INTO item VALUES (null, descripcion, tipo, estado,categoria,cve_usuario);
		select '0';
    ELSE
		select '1';
        -- No existe el usuario
	END IF;
END $$
delimiter ;
-- -----------------------------------------------------
-- Ejecución del procedimiento 
-- -----------------------------------------------------
-- Se registra: 0
call spInsItem ('Ejercicio de Predicción en WEKA','Digital','Disponible','Documentación','18200744');
call spInsItem ('Los avances en telecomunicaciones','Digital','Disponible','Documentación','18200782');
call spInsItem ('Características de Los Blade Center','Digital','Disponible','Documentación','18200775');
-- No existe el usuario
call spInsItem ('Características de Los Blade Center','Digital','Disponible','Documentación','775');

-- -----------------------------------------------------
-- Creación del procedimiento de registro de prestamo
-- -----------------------------------------------------
-- REGLAS: 
-- 1. No se puede registrar un prestamo si el  prestamista no existe
-- 2. No se puede registrar un prestamo si el  solicitante no existe
-- 3. No se puede registrar un prestamo si el  item no existe
-- 4. No se puede registrar un prestamo si el item No esta disponible 
-- 5. No hacer cambio en el estatus en caso de que sea del tipo digital

delimiter $$
CREATE PROCEDURE spInsprestamo
(
	IN prestamista 		VARCHAR(8),
	IN cve_item 		INT,
	IN solicitante		VARCHAR(8),
	IN inicio			DATE,
	IN fin 				DATE,
	IN lugar 			ENUM("Huevodromo", "Biblioteca", "Entrada", "Estacionamiento"),
	IN hora 			TIME,
    IN estado			ENUM("En prestamo", "Devuelto")
)
BEGIN
	-- 1ER VALIDACION
    IF EXISTS(SELECT usu_cve_usuario FROM usuario WHERE usu_cve_usuario = prestamista) THEN
		-- 2DA VALIDACION
		IF EXISTS(SELECT usu_cve_usuario FROM usuario WHERE usu_cve_usuario = solicitante) THEN
			-- 3ERA VALIDACION
			IF EXISTS(SELECT ite_cve_item FROM item WHERE ite_cve_item = cve_item ) THEN
				-- 4TA VALIDACION
				IF (SELECT ite_estado FROM item WHERE ite_cve_item = cve_item ) like'Disponible' THEN
					INSERT INTO prestamo VALUES (NULL,prestamista, cve_item, solicitante, inicio, fin, lugar, hora,estado);
					SELECT '0';
                    IF (SELECT ite_tipo FROM item WHERE ite_cve_item = cve_item ) like'Físico' THEN
						UPDATE item SET ite_estado = 'No disponible' WHERE (ite_cve_item = cve_item);
					ELSE
						IF (SELECT ite_tipo FROM item WHERE ite_cve_item = cve_item ) like'Hardware' THEN
							UPDATE item SET ite_estado = 'No disponible' WHERE (ite_cve_item = cve_item);
						END IF;
					END IF;
				ELSE
					SELECT '1';
					-- El item no esta disponible
				END IF;
            ELSE
				SELECT '2';
                -- El item no existe
			END IF;
        ELSE
			SELECT '3';
            -- El solicitante no existe
		END IF;
	ELSE
		SELECT '4'; 
        -- El prestamista no existe
	END IF;
END $$
delimiter ;

-- -----------------------------------------------------
-- Ejecución del procedimiento 
-- -----------------------------------------------------
-- Se inserta: 0
call spInsprestamo ('18200765','3', '18200744', '2022-11-08', '2022-11-12', 'Huevodromo', '12:00:00','En prestamo'); 
call spInsprestamo ('18200765','4', '18200744', '2022-11-08', null, 'Huevodromo', '12:00:00','En prestamo'); 
-- El item no esta disponible: 1
call spInsprestamo ('18200765','3', '18200744', '2022-11-08', '2022-11-12', 'Huevodromo', '12:00:00','En prestamo'); 
-- El item no existe: 2
call spInsprestamo ('18200765','166', '18200744', '2022-11-08', '2022-11-12', 'Huevodromo', '12:00:00','En prestamo'); 
-- El solicitante no existe: 3
call spInsprestamo ('18200765','1', '184', '2022-11-08', '2022-11-12', 'Huevodromo', '12:00:00','En prestamo'); 
-- El prestamista no existe: 4
call spInsprestamo ('18765','1', '18200744', '2022-11-08', '2022-11-12', 'Huevodromo', '12:00:00','En prestamo'); 
select * from prestamo;

-- -----------------------------------------------------
-- Creación del procedimiento de modificación de item
-- -----------------------------------------------------
delimiter $$
CREATE PROCEDURE spUpdItem
(
  IN cve_item		INT,
  IN descripcion 	VARCHAR(100),
  IN tipo			ENUM("Digital", "Físico", "Hardware"),
  IN estado 		ENUM("Disponible", "No disponible"),
  IN categoria		ENUM("Electrónica", "Ciencias", "Química", "Matemáticas", "Código", "Documentación"),
  IN cve_usuario 	VARCHAR(8)
)
BEGIN
	
	 -- 1ER VALIDACION
    IF EXISTS(SELECT usu_cve_usuario FROM usuario WHERE usu_cve_usuario = cve_usuario) THEN
		UPDATE item SET ite_descripcion=descripcion, ite_tipo=tipo, 
		   ite_estado=estado,ite_categoria=categoria, usu_cve_usuario=cve_usuario
		   WHERE ite_cve_item=cve_item;
		select '0';
    ELSE
		select '1';
        -- No existe el usuario
	END IF;
END $$
delimiter ;
-- -----------------------------------------------------
-- Ejecución del procedimiento 
-- -----------------------------------------------------
call spUpdItem ('4','Ejercicio de Predicción en WEKA simulacion','Digital','Disponible','Documentación','18200744');
call spUpdItem ('5','Los avances en telecomunicaciones 2022','Digital','Disponible','Documentación','18200782');
call spUpdItem ('6','Características de Los Blade Center Redes','Digital','Disponible','Documentación','18200775');
-- El usuario no existe
call spUpdItem ('6','Características de Los Blade Center Redes','Digital','Disponible','Documentación','18275');
select * from item;


-- -----------------------------------------------------
-- Creación del procedimiento de ingreso
-- -----------------------------------------------------
-- Reglas: 
-- 1. Exista el usuario
-- 2. La contraseña sea correcta
delimiter $$
CREATE PROCEDURE spValidarIngreso
(
  IN usu		VARCHAR(20),
  IN contrasena		VARCHAR(30)
)
BEGIN
	
	 -- 1ER VALIDACION
    IF EXISTS(SELECT usu_usuario FROM usuario WHERE usu_usuario = usu) THEN
		-- 2DA VALIDACIÓN
		IF (SELECT usu_contrasena FROM usuario WHERE usu_usuario = usu ) like contrasena THEN
			SELECT '0' AS usu_bandera,  usu_cve_usuario AS Clave, usu_nombre AS Nombre, usu_ape_paterno AS Parterno,
				usu_ape_materno AS Materno, usu_usuario AS Usuario 	
			FROM usuario
            WHERE  usu_usuario = usu;
		ELSE
			SELECT '1';
			-- La contraseña es incorrecta
		END IF;
    ELSE
		select '2';
        -- No existe el usuario 
	END IF;
END $$
delimiter ;
-- -----------------------------------------------------
-- Ejecución del procedimiento 
-- -----------------------------------------------------
-- Ingresa a sistema: 0 
call spValidarIngreso ('anathema','123456');
-- Contraseña incorrecta: 1
call spValidarIngreso ('anathema','1456');
-- No existe usuario: 2
call spValidarIngreso ('anama','123456');


-- -----------------------------------------------------
-- Creación del procedimiento de devolucion
-- -----------------------------------------------------
-- Reglas: 
-- 1. Exista el prestamo
delimiter $$
CREATE PROCEDURE spDevolucion
(
  IN cve_prestamo	INT
)
BEGIN
	
	 -- 1ER VALIDACION
    IF EXISTS(SELECT pre_cve_prestamo FROM prestamo WHERE pre_cve_prestamo=cve_prestamo) THEN
		UPDATE prestamo SET pre_fin_prestamo = CAST(CURRENT_TIMESTAMP as DATE), pre_estado = 'Devuelto' WHERE pre_cve_prestamo=cve_prestamo;
		UPDATE item SET ite_estado = 'Disponible' WHERE (ite_cve_item=(SELECT ite_cve_item FROM prestamo WHERE pre_cve_prestamo=cve_prestamo));
        select '0';
    ELSE
		select '1';
        -- No existe el prestamo
	END IF;
END $$
delimiter ;
-- -----------------------------------------------------
-- Ejecución del procedimiento 
-- -----------------------------------------------------
-- Ingresa devuelve el prestamo: 0 
call spDevolucion ('2');
-- No existe el prestamo: 1
call spDevolucion ('555');


-- -----------------------------------------------------
-- Creación del listado de Items Propios
-- -----------------------------------------------------
delimiter $$
CREATE PROCEDURE listItemsPropios
(
  IN  cve_usuario	INT
)
BEGIN
	-- 1ER VALIDACION
	IF EXISTS(SELECT ite_cve_item FROM item WHERE usu_cve_usuario=cve_usuario) THEN
		SELECT i.ite_cve_item as Clave, i.ite_descripcion  As Descricion, i.ite_tipo As Tipo,
				i.ite_estado As Estado, i.ite_categoria As Categoria,   
				concat(i.usu_cve_usuario, " - ", u.usu_nombre, " ", u.usu_ape_paterno,
                " ",u.usu_ape_materno) AS Usuario
		from item i, usuario u
		where (i.usu_cve_usuario=cve_usuario) and (u.usu_cve_usuario = cve_usuario);
	ELSE
		select '1';
		-- No existen items
	END IF;
END $$
delimiter ;
-- -----------------------------------------------------
-- Ejecución del listado de Items Propios 
-- -----------------------------------------------------
-- Muestra items: 0 
call listItemsPropios ('18200744');


-- -----------------------------------------------------
-- Creación del listado de Items Prestados
-- -----------------------------------------------------
delimiter $$
CREATE PROCEDURE listItemsPrestados
(
  IN  cve_usuario	INT
)
BEGIN
	-- 1ER VALIDACION
	IF EXISTS(SELECT pre_cve_prestamo FROM prestamo WHERE usu_cve_usuario_solicitante=cve_usuario) THEN
		SELECT p.pre_cve_prestamo as Clave, (select concat(usu_nombre,' ', usu_ape_paterno,' ', usu_ape_materno) as nombre from usuario where usu_cve_usuario = p.usu_cve_usuario_prestamista) AS 'Usuario Pestamista',
        (SELECT ite_descripcion FROM item where ite_cve_item = p.ite_cve_item)  As 'Item',
        concat(u.usu_nombre, " ", u.usu_ape_paterno,
                " ",u.usu_ape_materno) AS 'Usuario Solicitante',
        p.pre_inicio_prestamo As 'Inicio del prestamo', p.pre_fin_prestamo As 'Fin del prestamo',
		p.pre_lugar AS Lugar, p.pre_hora AS Hora, p.pre_estado AS 'Estado del prestamo'
		from prestamo p, usuario u
		where (p.usu_cve_usuario_solicitante=cve_usuario) and (u.usu_cve_usuario = cve_usuario);
	ELSE
		select '1';
		-- No existen items
	END IF;
END $$
delimiter ;
-- -----------------------------------------------------
-- Ejecución del listado de Items Prestados 
-- -----------------------------------------------------
-- Muestra items: 0 
call listItemsPrestados ('18200744');


-- -----------------------------------------------------
-- Creación del vwItemsDisponibles
-- -----------------------------------------------------
delimiter $$
CREATE VIEW vw_ItemsDisponibles
AS
	SELECT i.ite_cve_item AS Clave, i.ite_descripcion AS Descripcion,
			i.ite_tipo AS Tipo, i.ite_estado AS Estado, i.ite_categoria AS Categoria, 
            i.usu_cve_usuario AS 'Clave Dueño',
			concat((u.usu_nombre ),
			" ", (u.usu_ape_paterno),
			" ", (u.usu_ape_materno)) AS 'Dueño'
	from item i, usuario u
	where (i.ite_estado='Disponible' AND  u.usu_cve_usuario=i.usu_cve_usuario)$$
delimiter ;

-- -----------------------------------------------------
-- Ejecución del vwItemsDisponibles
-- -----------------------------------------------------
-- Muestra items: 0 
select * from vw_ItemsDisponibles;

select Descripcion from vw_ItemsDisponibles where Clave = 3;


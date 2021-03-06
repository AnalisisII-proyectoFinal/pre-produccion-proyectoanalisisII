USE [dbmuestras]
GO
/****** Object:  StoredProcedure [dbo].[actualizardatossalud]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[actualizardatossalud]
	@dep varchar(100),
	@mun varchar(100),
	@aresal varchar(50),
	@sersal varchar(50),
	@dissal varchar(50),
	@dirsal varchar(100),
	@resp varchar(100),
	@carg varchar(100),
	@imgs varchar(200),
	@imgsiv varchar(200)
AS
	UPDATE dbo.tbl_datos_centro_salud SET departamento=@dep,municipio=@mun,area_salud=@aresal,servicio_salud=@sersal,distrito_salud=@dissal,director_salud=@dirsal,responsable=@resp,cargo1=@carg,uri_logo_salud=@imgs,uri_logo_siv=@imgsiv,fecha_modificacion=SYSDATETIME() WHERE id=1; 
GO
/****** Object:  StoredProcedure [dbo].[actualizarlogosalud]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[actualizarlogosalud]
	@logosal varchar(200)
AS
	UPDATE dbo.tbl_datos_centro_salud SET uri_logo_salud=@logosal, fecha_modificacion=SYSDATETIME() WHERE id=1; 
GO
/****** Object:  StoredProcedure [dbo].[actualizarlogosiv]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[actualizarlogosiv]
	@logosiv varchar(200)
AS
	UPDATE dbo.tbl_datos_centro_salud SET uri_logo_siv=@logosiv, fecha_modificacion=SYSDATETIME() WHERE id=1; 
GO
/****** Object:  StoredProcedure [dbo].[appobtnermuestrascompletadas]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[appobtnermuestrascompletadas]
AS
	DECLARE @idhilo INT;
	SELECT @idhilo = IDENT_CURRENT('dbo.tbl_hilo');
	SELECT dm.id, t.nombre AS tanq,tm.tipo_muestra AS tm,dm.ph,dm.cloro_residual AS cl,dm.punto_muestra AS pm FROM dbo.tbl_detalle_muestra dm INNER JOIN dbo.tbl_tanque t ON(dm.id_tanque=t.id)
	INNER JOIN dbo.tbl_tipo_muestra tm ON(dm.id_tipo_muestra= tm.id)
	WHERE dm.id_hilo=@idhilo AND dm.estado=1;
GO
/****** Object:  StoredProcedure [dbo].[obtenerdatosusuario]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[obtenerdatosusuario]
	@idu int
AS
	SELECT CONCAT(CONCAT(e.primer_apellido,' '),e.primer_nombre) AS nombre,
	e.uri_avatar AS avatar FROM dbo.tbl_usuario u INNER JOIN dbo.tbl_empleado e ON(e.id=u.id_empleado) WHERE u.id=@idu;
GO
/****** Object:  StoredProcedure [dbo].[obtenermuestrasincompletoapp]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[obtenermuestrasincompletoapp]
	@idt int
AS
	DECLARE @idhilo INT;
	SELECT @idhilo = IDENT_CURRENT('dbo.tbl_hilo');
	SELECT dm.id,tm.tipo_muestra AS idm FROM dbo.tbl_detalle_muestra dm	INNER JOIN dbo.tbl_tipo_muestra tm ON(dm.id_tipo_muestra=tm.id) WHERE dm.id_hilo=@idhilo AND dm.id_tanque=@idt AND dm.estado=0;
GO
/****** Object:  StoredProcedure [dbo].[pr_obtnerempleado_usuario]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pr_obtnerempleado_usuario]  
    @primernombre nvarchar(50)   
AS   
    SET NOCOUNT ON;  
    SELECT primer_nombre,primer_apellido,cargo  
    FROM dbo.tbl_empleado  
    WHERE primer_nombre = @primernombre;
GO
/****** Object:  StoredProcedure [dbo].[tbl_obtenerdatosusuarioedit]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[tbl_obtenerdatosusuarioedit]
	@id int
AS
	select u.usuario,e.uri_avatar as avatar,CONCAT(CONCAT(e.primer_apellido,' '),e.primer_nombre) as nombre,
	u.pin_app as pin,e.telefono,e.direccion,e.correo_electronico as email
	from dbo.tbl_usuario u INNER JOIN dbo.tbl_empleado e ON(e.id=u.id_empleado) WHERE u.id=@id;
GO
/****** Object:  StoredProcedure [dbo].[uspactualizarcontrasena]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[uspactualizarcontrasena]
@id int,
@pass varchar(200)
AS
	UPDATE dbo.tbl_usuario SET contrasena=@pass WHERE id=@id;
GO
/****** Object:  StoredProcedure [dbo].[uspactualizardatosinstitucion]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspactualizardatosinstitucion]
	@ent varchar(100),
	@dep varchar(100),
	@app varchar(200),
	@logo varchar(200)
AS
	IF (@logo = '')
	BEGIN
		UPDATE dbo.tbl_institucion SET entidad=@ent,dependencia=@dep,nombre_aplicacion=@app, fecha_modificacion=SYSDATETIME() WHERE id=1;
	END
	ELSE BEGIN
	UPDATE dbo.tbl_institucion SET entidad=@ent,dependencia=@dep,nombre_aplicacion=@app,uri_logotipo=@logo, fecha_modificacion=SYSDATETIME() WHERE id=1;
	END
GO
/****** Object:  StoredProcedure [dbo].[uspactualizardatosusuarioperfil]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspactualizardatosusuarioperfil]
@id int,
@avatar varchar(200),
@tel varchar(100),
@dir varchar(200),
@em varchar(100)
AS
	declare @idu int;
	select @idu=id_empleado from dbo.tbl_usuario where id=@id;
	UPDATE dbo.tbl_empleado SET telefono=@tel,direccion=@dir,correo_electronico=@em,uri_avatar=@avatar WHERE id=@idu;
GO
/****** Object:  StoredProcedure [dbo].[uspactualizarempleado]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspactualizarempleado]
@ide int,
@pn varchar (100),
@sn varchar (100),
@pa varchar (100),
@sa varchar (100),
@dpi varchar (100),
@sex varchar (50),
@tel varchar (100),
@corr varchar (100),
@dir varchar (200),
@carg varchar (100),
@fnaci Date

AS
UPDATE dbo.tbl_empleado SET primer_nombre=@pn,
                           segundo_nombre=@sn,
                           primer_apellido=@pa,
						   segundo_apellido=@sa,
						   dpi=@dpi,
						   sexo=@sex,
						   telefono=@tel,
						   correo_electronico=@corr,
						   direccion=@dir,
						   cargo=@carg,
							fecha_nacimiento=@fnaci
						   WHERE id=@ide;
GO
/****** Object:  StoredProcedure [dbo].[uspactualizarmantenimientom]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspactualizarmantenimientom]
@idm INT,
@titulo VARCHAR(100),
@descripcion TEXT,
@img VARCHAR(200),
@fecha DATE
AS
	UPDATE dbo.tbl_mantenimiento SET titulo=@titulo,descripcion=@descripcion,
	uri_img=@img,fecha=@fecha WHERE id=@idm;
GO
/****** Object:  StoredProcedure [dbo].[uspactualizarmetodocl]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspactualizarmetodocl]
@idmc INT,
@tratamiento VARCHAR(100),
@descripcion VARCHAR(200)
AS
	UPDATE dbo.tbl_metodo_cloracion SET tratamiento=@tratamiento,descripcion=@descripcion WHERE id=@idmc;
GO
/****** Object:  StoredProcedure [dbo].[uspactualizarmision]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspactualizarmision]
	@mision text,
	@imgm varchar(200)
AS
	IF (@imgm = '')
	BEGIN
		UPDATE dbo.tbl_institucion SET mision=@mision,fecha_modificacion=SYSDATETIME() WHERE id=1;
	END
	ELSE
	BEGIN
		UPDATE dbo.tbl_institucion SET mision=@mision,uri_img_mision=@imgm,fecha_modificacion=SYSDATETIME() WHERE id=1;
	END
GO
/****** Object:  StoredProcedure [dbo].[uspactualizarmuestra]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[uspactualizarmuestra]
@id INT,
@pmuestra VARCHAR(100),
@ph VARCHAR(50),
@cl VARCHAR(50)
AS
	UPDATE dbo.tbl_detalle_muestra SET punto_muestra=@pmuestra,ph=@ph,cloro_residual=@cl WHERE id=@id;
GO
/****** Object:  StoredProcedure [dbo].[uspactualizarpin]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspactualizarpin]
@id int,
@pin int
AS
	UPDATE dbo.tbl_usuario SET pin_app=@pin where id=@id;
GO
/****** Object:  StoredProcedure [dbo].[uspactualizarpublicacion]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspactualizarpublicacion]
	@id INT,
	@desc Text,
	@img VARCHAR(200)
AS
	UPDATE dbo.tbl_publicacion SET descripcion=@desc, uri_img=@img WHERE id = @id;
GO
/****** Object:  StoredProcedure [dbo].[uspactualizartanquet]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspactualizartanquet]
@idt INT,
@nombre VARCHAR(100),
@numero INT,
@ubicacion VARCHAR(300),
@fechaf DATE,
@largo VARCHAR(50),
@ancho VARCHAR(50),
@altura VARCHAR(50),
@img VARCHAR(200),
@mcl INT
AS
	UPDATE dbo.tbl_tanque 
	SET nombre=@nombre,numero=@numero,ubicacion=@ubicacion,largo=@largo,ancho=@ancho,alto=@altura,fecha_inicio=@fechaf,
	uri_img=@img,id_cloracion=@mcl WHERE id=@idt;
GO
/****** Object:  StoredProcedure [dbo].[uspactualizartipomuestra]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspactualizartipomuestra]
@idtm INT,
@tipo VARCHAR(100),
@descripcion VARCHAR(200)
AS
	UPDATE dbo.tbl_tipo_muestra SET tipo_muestra=@tipo,descripcion=@descripcion WHERE id=@idtm;
GO
/****** Object:  StoredProcedure [dbo].[uspactualizarvision]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspactualizarvision]
	@vision text,
	@imgv varchar(200)
AS
	IF (@imgv = '')
	BEGIN
		UPDATE dbo.tbl_institucion SET vision=@vision, fecha_modificacion=SYSDATETIME() WHERE id=1;
	END
	ELSE
	BEGIN
		UPDATE dbo.tbl_institucion SET vision=@vision,uri_img_vision=@imgv, fecha_modificacion=SYSDATETIME() WHERE id=1;
	END
GO
/****** Object:  StoredProcedure [dbo].[uspagregartanquehilo]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspagregartanquehilo]
	@idtanque int
AS
	DECLARE @idhilo int;
	DECLARE @cuntm int;
	DECLARE @numtm int;
	DECLARE @itp int;
	DECLARE @idtm int
	SET @cuntm = 0;
	SELECT @idhilo = IDENT_CURRENT('dbo.tbl_hilo');
	INSERT INTO dbo.tbl_asignacion_tanque_hilo(id_tanque,id_hilo,estado) VALUES(@idtanque,@idhilo,1);
	SELECT  @numtm=COUNT(id) from dbo.tbl_tipo_muestra WHERE estado=1;
	WHILE (@cuntm < @numtm) BEGIN
			SELECT TOP(1) @itp=id from dbo.tbl_tipo_muestra WHERE estado=1 AND id>@idtm;
			INSERT INTO dbo.tbl_detalle_muestra(id_tanque,id_tipo_muestra,punto_muestra,ph,cloro_residual,fecha,hora,id_usuario,id_hilo,cliente,estado)
			VALUES(@idtanque,@itp,'default','none','none',SYSDATETIME(),SYSDATETIME(),0,@idhilo,0,0)
			SET @cuntm = @cuntm + 1;
			SET @idtm = @itp;
		END
GO
/****** Object:  StoredProcedure [dbo].[uspagregartanqueshilo]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspagregartanqueshilo]
AS
	DECLARE @cnt int;
	DECLARE @idhilo int;
	DECLARE @numt int;
	DECLARE @numtm int;
	DECLARE @idt int;
	DECLARE @i int;
	DECLARE @idtm int;
	DECLARE @itp int;
	DECLARE @cuntm int;
	SET @cuntm = 0;
	SET  @cnt = 1;
	SET @idt = 0;
	SET @idtm=0;
	SELECT  @numt=COUNT(id) from dbo.tbl_tanque WHERE estado=1;
	SELECT  @numtm=COUNT(id) from dbo.tbl_tipo_muestra WHERE estado=1;
	SELECT @idhilo = IDENT_CURRENT('dbo.tbl_hilo');
	WHILE @cnt <= @numt BEGIN
		select top(1) @i=id from dbo.tbl_tanque WHERE estado=1 AND id>@idt;
		INSERT INTO dbo.tbl_asignacion_tanque_hilo(id_tanque,id_hilo,estado) VALUES(@i,@idhilo,1);
		WHILE (@cuntm < 3) BEGIN
			SELECT TOP(1) @itp=id from dbo.tbl_tipo_muestra WHERE estado=1 AND id>@idtm;
			INSERT INTO dbo.tbl_detalle_muestra(id_tanque,id_tipo_muestra,punto_muestra,ph,cloro_residual,fecha,hora,id_usuario,id_hilo,cliente,estado)
			VALUES(@i,@itp,'sin punto muestra','0 ml','0 ml',SYSDATETIME(),SYSDATETIME(),0,@idhilo,0,0)
			SET @cuntm = @cuntm + 1;
			SET @idtm = @itp;
		END
		SET @idtm=0;
		SET @cuntm=0;
		SET @cnt= @cnt + 1;
		SET @idt=@i;
	END
GO
/****** Object:  StoredProcedure [dbo].[uspautenticarusuarioapp]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspautenticarusuarioapp]
 @usuario varchar(100)
AS
	SELECT u.id, u.usuario, u.contrasena AS pass,u.pin_app AS pin,ua.estado FROM dbo.tbl_usuario u INNER JOIN dbo.tbl_usuario_appmovil ua 
	ON (u.id = ua.id_usuario) WHERE u.usuario = @usuario AND ua.estado_acceso=1; 
GO
/****** Object:  StoredProcedure [dbo].[uspcambiarestadousuariomovil]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspcambiarestadousuariomovil]
	@idu INT,
	@acceso INT
AS
	UPDATE dbo.tbl_usuario_appmovil SET estado_acceso=@acceso WHERE id=@idu;
GO
/****** Object:  StoredProcedure [dbo].[uspcrearmantenimientom]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspcrearmantenimientom]
@titulo VARCHAR(100),
@descripcion TEXT,
@img VARCHAR(200),
@fecha DATE,
@idt INT,
@idu INT
AS
	INSERT INTO dbo.tbl_mantenimiento(titulo,descripcion,uri_img,fecha,id_tanque,id_usuario,estado) VALUES
	(@titulo,@descripcion,@img,@fecha,@idt,@idu,1)
GO
/****** Object:  StoredProcedure [dbo].[uspcrearmetodocl]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspcrearmetodocl]
@tratamiento VARCHAR(100),
@descripcion VARCHAR(200)
AS
	INSERT INTO dbo.tbl_metodo_cloracion(tratamiento,descripcion,id_usuario,estado) VALUES(@tratamiento,@descripcion,1,1)
GO
/****** Object:  StoredProcedure [dbo].[uspcrearnuevohilo]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspcrearnuevohilo]
	@fechaf date,
	@desc varchar(200),
	@idus int
AS
	INSERT INTO dbo.tbl_hilo(fecha_inicio,fecha_fin,descripcion,id_usuario,estado,porcentaje) 
	VALUES(SYSDATETIME(),@fechaf,@desc,@idus,1,0);
GO
/****** Object:  StoredProcedure [dbo].[uspcreartanquet]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspcreartanquet]
@nombre VARCHAR(100),
@numero INT,
@ubicacion VARCHAR(300),
@fechaf DATE,
@largo VARCHAR(50),
@ancho VARCHAR(50),
@altura VARCHAR(50),
@img VARCHAR(200),
@mcl INT,
@idu INT
AS
	INSERT INTO dbo.tbl_tanque(nombre,numero,ubicacion,largo,ancho,alto,fecha_inicio,uri_img,estado,id_usuario,id_cloracion)
	VALUES(@nombre,@numero,@ubicacion,@largo,@ancho,@altura,@fechaf,@img,1,@idu,@mcl);
GO
/****** Object:  StoredProcedure [dbo].[uspeliminarempleado]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspeliminarempleado]
@ide int
AS
UPDATE dbo.tbl_empleado SET estado=0
                       WHERE id=@ide
GO
/****** Object:  StoredProcedure [dbo].[uspeliminarmantenimientom]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspeliminarmantenimientom]
@idm INT
AS
	UPDATE dbo.tbl_mantenimiento SET estado=0 WHERE id=@idm;
GO
/****** Object:  StoredProcedure [dbo].[uspeliminarmetodocl]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspeliminarmetodocl]
@idmc INT
AS
	UPDATE dbo.tbl_metodo_cloracion SET estado=0 WHERE id=@idmc;
GO
/****** Object:  StoredProcedure [dbo].[uspeliminarmuestra]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspeliminarmuestra]
	@idm int
AS
	UPDATE dbo.tbl_detalle_muestra SET estado=0 WHERE id=@idm;
GO
/****** Object:  StoredProcedure [dbo].[uspeliminarpublicacion]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspeliminarpublicacion]
	@id INT
AS
	UPDATE dbo.tbl_publicacion SET estado=0 WHERE id=@id;
GO
/****** Object:  StoredProcedure [dbo].[uspeliminartanquet]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspeliminartanquet]
@idt INT
AS
	UPDATE dbo.tbl_tanque SET estado=0 WHERE id=@idt;
GO
/****** Object:  StoredProcedure [dbo].[uspeliminartipomuestra]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspeliminartipomuestra]
	@idtm int
AS
	UPDATE dbo.tbl_tipo_muestra SET estado=0 WHERE id=@idtm
GO
/****** Object:  StoredProcedure [dbo].[uspeliminarusuariomovil]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspeliminarusuariomovil]
	@idus INT
AS
	UPDATE dbo.tbl_usuario_appmovil SET estado=0,estado_acceso=0 WHERE id=@idus;
GO
/****** Object:  StoredProcedure [dbo].[uspempleadousuario]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspempleadousuario]
@pn varchar(100),
@sn varchar(100),
@pa varchar(100),
@sa varchar(100),
@dpi varchar(100),
@sex varchar(50),
@dir varchar(100),
@carg varchar(100),
@tel varchar(100),
@corr varchar(100),
@fnaci date,
@uria varchar(200),
@usuario varchar(100),
@pass varchar(100),
@perm int
AS
	DECLARE @ide INT;
	INSERT INTO dbo.tbl_empleado(primer_nombre,segundo_nombre,primer_apellido,segundo_apellido,dpi,sexo,direccion,cargo,telefono,correo_electronico,fecha_nacimiento,fecha_creacion,uri_avatar,estado)
	VALUES(@pn,@sn,@pa,@sa,@dpi,@sex,@dir,@carg,@tel,@corr,@fnaci,SYSDATETIME(),@uria,1);
	SELECT @ide = IDENT_CURRENT('dbo.tbl_empleado'); 
	INSERT INTO dbo.tbl_usuario(usuario,contrasena,id_permiso,estado,id_empleado,pin_app) values(@usuario,@pass,@perm,1,@ide,1223);
GO
/****** Object:  StoredProcedure [dbo].[uspinformexhilo]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspinformexhilo]
@idh int
AS
	SELECT t.nombre AS nom,t.ubicacion AS ubic,CONCAT(CONCAT(tm.tipo_muestra,':'),dm.punto_muestra) AS punto,
	CONVERT(varchar,dm.fecha,1) AS fecha,CONVERT(varchar,dm.hora,108) AS hora,dm.ph,dm.cloro_residual AS cl
	FROM dbo.tbl_detalle_muestra dm INNER JOIN dbo.tbl_tanque t ON(t.id=dm.id_tanque) 
	INNER JOIN dbo.tbl_tipo_muestra tm ON(tm.id=dm.id_tipo_muestra)
	WHERE id_hilo=@idh;
GO
/****** Object:  StoredProcedure [dbo].[uspmuestrasxhilo]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspmuestrasxhilo]
@idh int
AS
	SELECT dm.id, t.nombre AS tanq ,tm.tipo_muestra AS tmuestra,dm.punto_muestra AS pmuestra,dm.ph,dm.cloro_residual AS cl,
		CONVERT(varchar,dm.fecha,1) AS fecha,CONVERT(varchar,dm.hora,108) AS hora,u.usuario,dm.cliente FROM dbo.tbl_detalle_muestra dm INNER JOIN dbo.tbl_tanque t ON(dm.id_tanque=t.id) INNER JOIN dbo.tbl_tipo_muestra tm
		ON(dm.id_tipo_muestra=tm.id) INNER JOIN dbo.tbl_usuario u ON(dm.id_usuario=u.id) WHERE dm.id_hilo=@idh AND dm.estado=1
GO
/****** Object:  StoredProcedure [dbo].[uspnuevamestraapp]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspnuevamestraapp]
	@idm int,
	@punto varchar(200),
	@ph varchar(50),
	@cl varchar(50),
	@idu int
AS
	DECLARE @esM INT;
	DECLARE @countM INT;
	DECLARE @por FLOAT;
	DECLARE @pora FLOAT;
	DECLARE @idh INT;
	SELECT @idh = IDENT_CURRENT('dbo.tbl_hilo');
	SELECT @countM=COUNT(id) FROM dbo.tbl_detalle_muestra WHERE id_hilo=@idh;
	SELECT @esM=estado FROM dbo.tbl_detalle_muestra WHERE id=@idm;
	SELECT @pora = porcentaje FROM dbo.tbl_hilo WHERE id=@idh;
	IF @esM < 1 BEGIN
		UPDATE dbo.tbl_detalle_muestra SET punto_muestra=@punto,ph=@ph,cloro_residual=@cl,
		fecha=SYSDATETIME(),hora=SYSDATETIME(),cliente=2,id_usuario=@idu,estado=1 WHERE id=@idm AND estado=0;
		SET @por = @pora + ((100/@countM)+1);
		IF @por>98 BEGIN
			UPDATE dbo.tbl_hilo SET porcentaje=100 WHERE id=@idh;
		END
		ELSE BEGIN
			UPDATE dbo.tbl_hilo SET porcentaje=@por WHERE id=@idh;
		END
	END
GO
/****** Object:  StoredProcedure [dbo].[uspnuevamuestra]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspnuevamuestra]
	@idm int,
	@punto varchar(200),
	@ph varchar(50),
	@cl varchar(50),
	@idu int,
	@idh int
AS
	DECLARE @esM INT;
	DECLARE @countM INT;
	DECLARE @por FLOAT;
	DECLARE @pora FLOAT;
	--DECLARE @idh INT;
	SELECT @esM=estado FROM dbo.tbl_detalle_muestra WHERE id=@idm;
	IF @esM < 1 BEGIN
		SELECT @countM=COUNT(id) FROM dbo.tbl_detalle_muestra WHERE id_hilo=@idh;
		--select @idh = IDENT_CURRENT('dbo.tbl_hilo');
		SELECT @pora = porcentaje FROM dbo.tbl_hilo WHERE id=@idh;
		UPDATE dbo.tbl_detalle_muestra SET ph=@ph,cloro_residual=@cl,punto_muestra=@punto,fecha=SYSDATETIME(),
		hora=SYSDATETIME(),estado=1,cliente=1,id_usuario=@idu WHERE  id=@idm AND estado=0;
		SET @por = @pora + ((100/@countM)+1);
		IF @por > 98 BEGIN
			UPDATE dbo.tbl_hilo SET porcentaje=100 WHERE id=@idh;
		END
		ELSE BEGIN
			UPDATE dbo.tbl_hilo SET porcentaje=@por WHERE id=@idh;
		END
	END
GO
/****** Object:  StoredProcedure [dbo].[uspnuevapublicacion]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspnuevapublicacion]
	@titulo varchar(100),
	@fecha date,
	@descripcion Text,
	@img varchar(200)
AS
	Insert into dbo.tbl_publicacion(titulo,fecha,descripcion,uri_img,estado_public,estado)values(@titulo,@fecha,@descripcion,@img,1,1);
GO
/****** Object:  StoredProcedure [dbo].[uspnuevohilo]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[uspnuevohilo]
	@fechafinv date,
	@idusuario int,
	@idtanque int
as
	declare @cantidadt int;
	declare @idhilo int;
	select @cantidadt=COUNT(estado) from dbo.tbl_tanque;
	if @cantidadt > 0 begin
		insert into dbo.tbl_hilo(fecha_inicio,fecha_fin,descripcion,id_usuario,estado)
		values(SYSDATETIME(),@fechafinv,'prueba',@idusuario,1)
		insert into dbo.tbl_muestra(id_punto_muestra,lugar,ph,cloro_residual,fecha,hora,id_usuario,id_hilo,id_tanque,estado)
		values(1,'cabecera',0,0,SYSDATETIME(),SYSDATETIME(),@idusuario,1,1,1)
	end
GO
/****** Object:  StoredProcedure [dbo].[uspnuevotipomuestra]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspnuevotipomuestra]
	@tipo varchar(100),
	@desc varchar(200)
AS
	INSERT INTO dbo.tbl_tipo_muestra(tipo_muestra,descripcion,estado) VALUES(@tipo,@desc,1)
GO
/****** Object:  StoredProcedure [dbo].[uspnuevousuarioapp]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspnuevousuarioapp]
	@usuario varchar(50),
	@result  INT OUTPUT
AS
	DECLARE @etblusuario AS INT;
	DECLARE @etblapp AS INT;
	DECLARE @idus AS INT;
	SELECT @etblusuario=COUNT(u.usuario),@etblapp=COUNT(ap.id_usuario) FROM dbo.tbl_usuario u LEFT JOIN dbo.tbl_usuario_appmovil ap ON(u.id=ap.id_usuario AND ap.estado=1) WHERE u.usuario=@usuario AND u.estado=1;
	IF(@etblusuario = 1 AND @etblapp = 0)BEGIN
		SELECT @idus=u.id FROM dbo.tbl_usuario u WHERE u.usuario=@usuario;
		INSERT INTO dbo.tbl_usuario_appmovil(fecha,id_usuario,estado_acceso,estado) VALUES(SYSDATETIME(),@idus,1,1);
		SET @result=1;
	END
	ELSE BEGIN
		SET @result=0;
	END
	RETURN @result;
GO
/****** Object:  StoredProcedure [dbo].[uspobtenerdatoshiloactual]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspobtenerdatoshiloactual]
AS
	DECLARE @idhilo INT; 
	SELECT @idhilo = IDENT_CURRENT('dbo.tbl_hilo');
	select t.nombre AS tanque,dm.ph, dm.cloro_residual AS cl, tm.tipo_muestra AS muestra,dm.estado 
from dbo.tbl_detalle_muestra dm INNER JOIN dbo.tbl_tanque t ON(t.id=dm.id_tanque)
INNER JOIN dbo.tbl_tipo_muestra tm ON(tm.id = dm.id_tipo_muestra) WHERE id_hilo=@idhilo ORDER BY id_tanque,id_tipo_muestra; 

GO
/****** Object:  StoredProcedure [dbo].[uspobtenerdatoshiloactualinicio]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspobtenerdatoshiloactualinicio]
AS
	DECLARE @idhilo INT; 
	SELECT @idhilo = IDENT_CURRENT('dbo.tbl_hilo');
	select t.nombre AS tanque,t.uri_img AS imgt,t.ubicacion, tm.tipo_muestra AS muestra,dm.estado 
	from dbo.tbl_detalle_muestra dm INNER JOIN dbo.tbl_tanque t ON(t.id=dm.id_tanque)
	INNER JOIN dbo.tbl_tipo_muestra tm ON(tm.id = dm.id_tipo_muestra) WHERE id_hilo=@idhilo ORDER BY id_tanque,id_tipo_muestra; 
GO
/****** Object:  StoredProcedure [dbo].[uspobtenerdatosinforcs]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspobtenerdatosinforcs]
AS
	SELECT departamento AS d,municipio AS m,area_salud AS asl,servicio_salud AS ss,distrito_salud AS ds,director_salud AS ds,
	responsable AS res,cargo1 AS c1,uri_logo_salud AS ls,uri_logo_siv AS lsiv FROM dbo.tbl_datos_centro_salud;
GO
/****** Object:  StoredProcedure [dbo].[uspobtenerempleado]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspobtenerempleado]
@ide int
AS 
SELECT id, primer_nombre AS pn,segundo_nombre AS sn,primer_apellido AS pa,segundo_apellido AS sa,fecha_nacimiento AS fn,dpi,
sexo AS ge,telefono AS te,correo_electronico AS ce,direccion AS di,cargo AS ca,uri_avatar AS av FROM dbo.tbl_empleado WHERE id=@ide;
GO
/****** Object:  StoredProcedure [dbo].[uspobtenerempleados]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspobtenerempleados]
AS
SELECT id, CONCAT(CONCAT(primer_apellido,' '),primer_nombre)AS nombre,
dpi,direccion,cargo FROM dbo.tbl_empleado WHERE estado=1;
GO
/****** Object:  StoredProcedure [dbo].[uspobtenerhiloactual]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspobtenerhiloactual]
AS
	DECLARE @idhilo INT;
	SELECT @idhilo = IDENT_CURRENT('dbo.tbl_hilo');
	SELECT id,CONVERT(varchar,fecha_inicio,1) AS fecha1,CONVERT(varchar,fecha_fin,1) AS fecha2,porcentaje FROM dbo.tbl_hilo Where id=@idhilo;
GO
/****** Object:  StoredProcedure [dbo].[uspobtenerhiloactualapp]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspobtenerhiloactualapp]
AS
	DECLARE @idhilo INT;
	SELECT @idhilo = IDENT_CURRENT('dbo.tbl_hilo');
	SELECT id,CONVERT(varchar,fecha_inicio,1) AS fecha1,CONVERT(varchar,fecha_fin,1) AS fecha2,porcentaje FROM dbo.tbl_hilo Where id=@idhilo;
GO
/****** Object:  StoredProcedure [dbo].[uspobtenerhilos]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspobtenerhilos]
@year int,
@month int
AS
	select id,CONVERT(varchar,fecha_inicio,1) AS fecha1,CONVERT(varchar,fecha_fin,1) AS fecha2,descripcion,porcentaje AS por,estado
	from dbo.tbl_hilo WHERE YEAR(fecha_inicio)=@year AND MONTH(fecha_inicio)=@month;
GO
/****** Object:  StoredProcedure [dbo].[uspobtenermantenimiento]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspobtenermantenimiento]
@idt INT
AS
	select titulo,descripcion,uri_img as mimg,CONVERT(varchar,fecha,1) AS mfecha from dbo.tbl_mantenimiento WHERE id_tanque=@idt;
GO
/****** Object:  StoredProcedure [dbo].[uspobtenermantenimientom]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspobtenermantenimientom]
@idm int
AS
	SELECT m.id AS idm,m.titulo,m.descripcion,CONVERT(varchar,m.fecha,1) AS fecha,t.nombre AS tanque,m.uri_img AS img 
	FROM dbo.tbl_mantenimiento m INNER JOIN dbo.tbl_tanque t ON(t.id=m.id_tanque) WHERE m.id=@idm;
GO
/****** Object:  StoredProcedure [dbo].[uspobtenermantenimientosm]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspobtenermantenimientosm]
AS
	SELECT TOP(10) m.id AS idm,m.titulo,m.descripcion,CONVERT(varchar,m.fecha,1) AS fecha,t.nombre AS tanque 
	FROM dbo.tbl_mantenimiento m INNER JOIN dbo.tbl_tanque t ON(t.id=m.id_tanque) WHERE m.estado=1 ORDER BY m.id DESC; 
GO
/****** Object:  StoredProcedure [dbo].[uspobtenermetodocl]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspobtenermetodocl]
@idmc INT
AS
	SELECT	id,tratamiento,descripcion FROM dbo.tbl_metodo_cloracion WHERE id=@idmc;
GO
/****** Object:  StoredProcedure [dbo].[uspobtenermetodoscl]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspobtenermetodoscl]
AS
	SELECT	id,tratamiento,descripcion FROM dbo.tbl_metodo_cloracion WHERE estado=1;
GO
/****** Object:  StoredProcedure [dbo].[uspobtenermisionvision]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspobtenermisionvision]
AS
	SELECT mision,uri_img_mision as imgm,vision,uri_img_vision as imgv FROM dbo.tbl_institucion WHERE id=1;
GO
/****** Object:  StoredProcedure [dbo].[uspobtenermuestra]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspobtenermuestra]
@idm INT
AS
	SELECT dm.id,t.nombre AS tanque,tm.tipo_muestra AS tmuestra, dm.punto_muestra AS pmuestra,dm.ph,dm.cloro_residual AS cl FROM dbo.tbl_detalle_muestra dm INNER JOIN dbo.tbl_tanque t ON(t.id=dm.id_tanque) 
	INNER JOIN dbo.tbl_tipo_muestra tm ON(tm.id=dm.id_tipo_muestra) WHERE dm.id = @idm;
GO
/****** Object:  StoredProcedure [dbo].[uspobtenermuestras]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspobtenermuestras]
	@ig int,
	@fil int
AS
	DECLARE @idh int
	SELECT @idh = IDENT_CURRENT('dbo.tbl_hilo');
	IF (@ig=0 AND @fil=0)BEGIN
		SELECT TOP(10) dm.id, t.nombre AS tanq ,tm.tipo_muestra AS tmuestra,dm.punto_muestra AS pmuestra,dm.ph,dm.cloro_residual AS cl,
		CONVERT(varchar,dm.fecha,1) AS fecha,CONVERT(varchar,dm.hora,108) AS hora,u.usuario,dm.cliente FROM dbo.tbl_detalle_muestra dm INNER JOIN dbo.tbl_tanque t ON(dm.id_tanque=t.id) INNER JOIN dbo.tbl_tipo_muestra tm
		ON(dm.id_tipo_muestra=tm.id) INNER JOIN dbo.tbl_usuario u ON(dm.id_usuario=u.id) WHERE dm.id_hilo=@idh AND dm.estado=1
	END
	ELSE BEGIN
		SELECT dm.id, t.nombre AS tanq ,tm.tipo_muestra AS tmuestra,dm.punto_muestra AS pmuestra,dm.ph,dm.cloro_residual AS cl,
		CONVERT(varchar,dm.fecha,1) AS fecha,CONVERT(varchar,dm.hora,108) AS hora,u.usuario,dm.cliente FROM dbo.tbl_detalle_muestra dm INNER JOIN dbo.tbl_tanque t ON(dm.id_tanque=t.id) INNER JOIN dbo.tbl_tipo_muestra tm
		ON(dm.id_tipo_muestra=tm.id) INNER JOIN dbo.tbl_usuario u ON(dm.id_usuario=u.id) WHERE dm.id_hilo=@idh AND dm.estado=1 order by id
		OFFSET @ig ROWS FETCH NEXT @fil ROWS ONLY;
	END
GO
/****** Object:  StoredProcedure [dbo].[uspobtenerpermisos]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspobtenerpermisos]
AS
select id,tipo,descripcion  from dbo.tbl_permisos;
GO
/****** Object:  StoredProcedure [dbo].[uspobtenerpublicaciones]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspobtenerpublicaciones]
AS
	SELECT id AS idp,titulo,CONVERT(varchar,fecha,1) AS fecha,descripcion,uri_img AS img,estado_public AS estadop FROM dbo.tbl_publicacion WHERE estado=1;
GO
/****** Object:  StoredProcedure [dbo].[uspobtenertanquerep]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspobtenertanquerep]
@idt int
AS
	SELECT t.id AS idt,t.nombre AS tanq,t.numero AS num,t.ubicacion AS ubic,
	CONVERT(varchar,t.fecha_inicio,1) AS ffuncion,t.largo,t.ancho,t.alto AS altura,mc.tratamiento AS tpcloro  
	FROM dbo.tbl_tanque t INNER JOIN dbo.tbl_metodo_cloracion mc ON(mc.id=t.id_cloracion) WHERE t.id=@idt;
GO
/****** Object:  StoredProcedure [dbo].[uspobtenertanquesapp]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspobtenertanquesapp]
AS
	SELECT id,nombre,numero,ubicacion FROM dbo.tbl_tanque where estado=1;
GO
/****** Object:  StoredProcedure [dbo].[uspobtenertanquesrep]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspobtenertanquesrep]
AS
	SELECT t.id AS idt,t.nombre AS tanq,t.numero AS num,t.ubicacion AS ubic,
	CONVERT(varchar,t.fecha_inicio,1) AS ffuncion,t.largo,t.ancho,t.alto AS altura,mc.tratamiento AS tpcloro  
	FROM dbo.tbl_tanque t INNER JOIN dbo.tbl_metodo_cloracion mc ON(mc.id=t.id_cloracion) WHERE t.estado=1;
GO
/****** Object:  StoredProcedure [dbo].[uspobtenertanquest]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspobtenertanquest]
AS
	SELECT t.id, t.nombre AS tanq, t.numero AS num, t.ubicacion AS ubic,CONVERT(varchar,t.fecha_inicio,1) AS ffuncion,
	t.largo,t.ancho,t.alto AS altura,mc.tratamiento AS tpcloro
	FROM dbo.tbl_tanque t INNER JOIN dbo.tbl_metodo_cloracion mc ON(mc.id=t.id_cloracion) WHERE t.estado=1;
GO
/****** Object:  StoredProcedure [dbo].[uspobtenertanquet]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspobtenertanquet]
@idt INT
AS
	SELECT id,nombre,numero,ubicacion,CONVERT(varchar,fecha_inicio,1) AS fechaf,
	largo,ancho,alto,uri_img AS img
	FROM dbo.tbl_tanque WHERE id=@idt
GO
/****** Object:  StoredProcedure [dbo].[uspobtenertipomuestra1]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspobtenertipomuestra1]
@idtm INT
AS
	SELECT id,tipo_muestra AS tipo,descripcion FROM dbo.tbl_tipo_muestra WHERE id=@idtm;
GO
/****** Object:  StoredProcedure [dbo].[uspobtenertipomuestraapp]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspobtenertipomuestraapp]
AS
	SELECT id,tipo_muestra AS tipo FROM dbo.tbl_tipo_muestra WHERE estado=1;
GO
/****** Object:  StoredProcedure [dbo].[uspobtenerultimoshilos]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspobtenerultimoshilos]
AS
	SELECT TOP(3) id,CONVERT(varchar,fecha_inicio,1) AS fecha1,CONVERT(varchar,fecha_fin,1) AS fecha2,descripcion,porcentaje AS por FROM dbo.tbl_hilo WHERE estado=1 ORDER BY id Desc;
GO
/****** Object:  StoredProcedure [dbo].[uspobtenerusuario]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspobtenerusuario]
	@usuario varchar(100)
AS
	select id,usuario,contrasena,id_permiso AS per from dbo.tbl_usuario WHERE usuario=@usuario AND estado=1;
GO
/****** Object:  StoredProcedure [dbo].[uspobtenerusuarios]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspobtenerusuarios]
AS
	SELECT CONCAT(CONCAT(primer_apellido,' '),primer_nombre) AS nombre,dpi,direccion,cargo,estado,id FROM dbo.tbl_empleado;
GO
/****** Object:  StoredProcedure [dbo].[uspobtenervision]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspobtenervision]
AS
	SELECT vision, uri_img_vision as logov,CONVERT(varchar,fecha_modificacion,1) AS fecha FROM dbo.tbl_institucion WHERE id=1;
GO
/****** Object:  StoredProcedure [dbo].[uspobtnerdatoscentrosalud]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspobtnerdatoscentrosalud]
AS
	SELECT departamento,municipio,area_salud as arsal,servicio_salud as sersal,
	distrito_salud as dissal,director_salud as dirsal,responsable as resp,cargo1 as carg,uri_logo_salud AS lsal,uri_logo_siv AS lsiv,CONVERT(varchar,fecha_modificacion,1) AS fecha FROM dbo.tbl_datos_centro_salud WHERE id=1;
GO
/****** Object:  StoredProcedure [dbo].[uspobtnerdatosinstitucion]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspobtnerdatosinstitucion]
AS
	SELECT entidad,dependencia,nombre_aplicacion AS app,uri_logotipo AS logo,CONVERT(varchar,fecha_modificacion,1) AS fecha FROM dbo.tbl_institucion WHERE id=1;
GO
/****** Object:  StoredProcedure [dbo].[uspobtnerhilo]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspobtnerhilo]
	@idhilo int
AS
	SELECT porcentaje,fecha_inicio AS facha1,fecha_fin AS fecha2,descripcion,id_usuario FROM dbo.tbl_hilo Where id=@idhilo;
GO
/****** Object:  StoredProcedure [dbo].[uspobtnerhiloactual]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspobtnerhiloactual]
AS
	Declare @idhilo int;
	SELECT @idhilo = IDENT_CURRENT('dbo.tbl_hilo');
	SELECT id, CONVERT(varchar,fecha_inicio,1)AS inicio,CONVERT(varchar,fecha_fin,1) AS fin,descripcion FROM dbo.tbl_hilo Where id=@idhilo;
GO
/****** Object:  StoredProcedure [dbo].[uspobtnerhilos]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspobtnerhilos]
AS
	SELECT id,CONVERT(varchar,fecha_inicio,1) as fecha1,CONVERT(varchar,fecha_fin,1) as fecha2,descripcion
	AS descripcion,porcentaje AS por,estado FROM dbo.tbl_hilo;
GO
/****** Object:  StoredProcedure [dbo].[uspobtnermision]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspobtnermision]
AS
	SELECT mision, uri_img_mision AS logom,CONVERT(varchar,fecha_modificacion,1) AS fecha FROM dbo.tbl_institucion WHERE id=1;
GO
/****** Object:  StoredProcedure [dbo].[uspobtnertipomuestra]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspobtnertipomuestra]
AS
	SELECT id,tipo_muestra AS tipo,descripcion AS descr FROM dbo.tbl_tipo_muestra WHERE estado=1;
GO
/****** Object:  StoredProcedure [dbo].[uspobtnerusuariosappmovil]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspobtnerusuariosappmovil]
AS
	SELECT u.usuario AS usuario,CONCAT(CONCAT(e.primer_apellido,' '),e.primer_nombre) AS empleado,e.cargo,CONVERT(varchar,ap.fecha,1) AS fecha,ap.estado_acceso AS acceso, 
	ap.id as idu FROM dbo.tbl_usuario_appmovil ap JOIN dbo.tbl_usuario u ON(ap.id_usuario=u.id) JOIN dbo.tbl_empleado e ON(u.id_empleado=e.id) WHERE ap.estado=1;
GO
/****** Object:  StoredProcedure [dbo].[uspobtnetanquesopc]    Script Date: 10/11/2021 18:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[uspobtnetanquesopc]
AS
	SELECT id,nombre,numero,ubicacion FROM dbo.tbl_tanque WHERE estado=1;
GO

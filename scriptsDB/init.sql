
INSERT INTO dbo.tbl_institucion(id,entidad,dependencia,nombre_aplicacion,mision,vision,uri_logotipo,uri_img_mision,uri_img_vision,fecha_modificacion)values
(1,'default','default','default','default','default','https://res.cloudinary.com/municipalidad-san-jose-chacaya/image/upload/v1633997164/bdvxoupuo0twmsmla6hu.png','https://res.cloudinary.com/municipalidad-san-jose-chacaya/image/upload/v1633995835/mqst04ky4kvfh2jdywgu.jpg','https://res.cloudinary.com/municipalidad-san-jose-chacaya/image/upload/v1633995835/mqst04ky4kvfh2jdywgu.jpg',SYSDATETIME())
INSERT INTO dbo.tbl_datos_centro_salud(id,departamento,municipio,area_salud,servicio_salud,distrito_salud,director_salud,uri_logo_salud,
uri_logo_siv,fecha_modificacion,responsable,cargo1) values(1,'default','default','default','default','default','default',
'https://res.cloudinary.com/municipalidad-san-jose-chacaya/image/upload/v1633997164/bdvxoupuo0twmsmla6hu.png',
'https://res.cloudinary.com/municipalidad-san-jose-chacaya/image/upload/v1633997164/bdvxoupuo0twmsmla6hu.png',SYSDATETIME(),'default','default')

SELECT * FROM dbo.tbl_empleado;
INSERT INTO dbo.tbl_empleado(primer_nombre,segundo_nombre,primer_apellido,segundo_apellido,dpi,sexo,direccion,cargo,telefono,correo_electronico,fecha_nacimiento,fecha_creacion,uri_avatar,estado)
values('admin','default','app','default','default','default','default','default','default','default',SYSDATETIME(),SYSDATETIME(),'https://res.cloudinary.com/municipalidad-san-jose-chacaya/image/upload/v1633997164/bdvxoupuo0twmsmla6hu.png',1)
select * from dbo.tbl_permisos;
INSERT INTO dbo.tbl_permisos(tipo,descripcion)values('invitado','No tiene acceso al sistema')
INSERT INTO dbo.tbl_permisos(tipo,descripcion)values('moderador','Acceso limitado')
INSERT INTO dbo.tbl_permisos(tipo,descripcion)values('administrador','Acceso total')

select * from dbo.tbl_usuario;
INSERT INTO dbo.tbl_usuario(usuario,contrasena,id_permiso,estado,id_empleado,pin_app)values('admin','$2a$10$qT/ESE6HOCPo4T9lS1fgOuFCQGgu3rFNOslkm3a4mRy3gigcyo502',3,1,1,1234)

select * from dbo.tbl_tipo_muestra;
INSERT INTO dbo.tbl_tipo_muestra(tipo_muestra,descripcion,estado)values('tanque','Muestra tomada del tanque',1)
INSERT INTO dbo.tbl_tipo_muestra(tipo_muestra,descripcion,estado)values('casa1','Hogar mas cercano',1)
INSERT INTO dbo.tbl_tipo_muestra(tipo_muestra,descripcion,estado)values('casa2','Hogar mas lejano',1)

INSERT INTO dbo.tbl_usuario(usuario,contrasena,id_permiso,estado,id_empleado,pin_app)values('ejulajuj','$2a$10$qT/ESE6HOCPo4T9lS1fgOuFCQGgu3rFNOslkm3a4mRy3gigcyo502',3,1,1,1234)
INSERT INTO dbo.tbl_usuario(usuario,contrasena,id_permiso,estado,id_empleado,pin_app)values('gchiroy','$2a$10$qT/ESE6HOCPo4T9lS1fgOuFCQGgu3rFNOslkm3a4mRy3gigcyo502',3,1,1,1234)
INSERT INTO dbo.tbl_usuario(usuario,contrasena,id_permiso,estado,id_empleado,pin_app)values('wcuxulic','$2a$10$qT/ESE6HOCPo4T9lS1fgOuFCQGgu3rFNOslkm3a4mRy3gigcyo502',3,1,1,1234)
INSERT INTO dbo.tbl_usuario(usuario,contrasena,id_permiso,estado,id_empleado,pin_app)values('jyac','$2a$10$qT/ESE6HOCPo4T9lS1fgOuFCQGgu3rFNOslkm3a4mRy3gigcyo502',3,1,1,1234)

select * from dbo.tbl_institucion
select * from dbo.tbl_hilo
insert into dbo.tbl_hilo(fecha_inicio,fecha_fin,descripcion,id_usuario,estado,porcentaje)VALUES(SYSDATETIME(),SYSDATETIME(),'primerhilo',1,1,100)
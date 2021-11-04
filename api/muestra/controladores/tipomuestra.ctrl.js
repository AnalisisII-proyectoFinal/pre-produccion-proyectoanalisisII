const {getConexion,sql}=require('../../../sqlserver/sqlserverconexion.js');
const respuesta = require('../../../respuesta/respuesta.js');

async function nuevoTipoMuestra(req,res) {
    const {tipo,desc}=req.body;
    try {
        const pool = await getConexion();
        await pool.request()
        .input('tipo',sql.VarChar(100),tipo)
        .input('desc',sql.VarChar(200),desc)
        .execute('dbo.uspnuevotipomuestra')
        respuesta.exito(req,res,{msg:'Tipo de muestra creado'},200);
    } catch (error) {
        respuesta.error(req,res,error.message,500);
    }
}

async function obtenerTipoMuestras(req,res) {
    try {
        const pool = await getConexion();
        const result = await pool.request().execute('dbo.uspobtnertipomuestra')
        respuesta.exito(req,res,result.recordset,200);
    } catch (error) {
        respuesta.error(req,res,error.message,500);
    }
    
}

async function obtenerTipoMuestra(req,res) {
    const id = req.params.id;
    console.log(req.params)
    try {
        const pool = await getConexion();
        const result = await pool.request()
        .input('idtm',sql.Int,id)
        .execute('dbo.uspobtenertipomuestra1')
        respuesta.exito(req,res,result.recordset,200);
    } catch (error) {
        respuesta.error(req,res,error.message,500);
    } 
}


async function actualizarTipoMuestra(req,res) {
    const {id,tipo,desc}=req.body;
    try {
        const pool = await getConexion();
        await pool.request()
        .input('idtm',sql.Int,id)
        .input('tipo',sql.VarChar(100),tipo)
        .input('descripcion',sql.VarChar(200),desc)
        .execute('dbo.uspactualizartipomuestra')
        respuesta.exito(req,res,{msg:'Tipo muestra Actualizado'},200);
    } catch (error) {
        respuesta.error(req,res,error,500);
    }
    
}

/* async function eliminarTipoMuestra(req,res) {
    const {id}=req.body;
    try {
        const pool = await getConexion();
        await pool.request()
        .input('idtm',sql.Int,id)
        .execute('dbo.uspeliminartipomuestra')
        respuesta.exito(req,res,{msg:'Tipo de muestra eliminado'},200);
    } catch (error) {
        respuesta.error(req,res,error,500);
    }
    
} */


module.exports={
    nuevoTipoMuestra,
    obtenerTipoMuestras,
    obtenerTipoMuestra,
    actualizarTipoMuestra
}
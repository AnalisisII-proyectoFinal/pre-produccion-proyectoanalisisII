const {getConexion,sql}=require('../../../sqlserver/sqlserverconexion.js');
const respuesta = require('../../../respuesta/respuesta.js');
async function obtenerMuestras(req,res) {
        
    try {
        const $pool = await getConexion();
        const result=  await $pool.request().execute('dbo.appobtnermuestrascompletadas');
        respuesta.exito(req,res,result.recordset,200);
    } catch (error) {
        respuesta.error(req,res,error,500)
    }
    
}

async function obtnerMuestrasCompletas(req,res) {
    try {
        const pool = await getConexion();
        const result = await pool.request()
        .execute('dbo.appobtnermuestrascompletadas');
        respuesta.exito(req,res,result.recordset,200)

    } catch (error) {
        respuesta.error(req,res,error,500)
    }
    
}

async function obtenerMuestrasIncompletas(req,res) {
    const idtanque=req.params.id;
    try {
        const pool = await getConexion();
        const resut = await pool.request()
        .input('idt',sql.Int,idtanque)
        .execute('dbo.obtenermuestrasincompletoapp');
        respuesta.exito(req,res,resut.recordset,200)
    } catch (error) {
        respuesta.error(req,res,error,500)
    }
    
}

async function nuevaMuestraApp(req,res) {
    const{idm,punto,ph,cl,idu}=req.body;
    try {
        
        const pool = await getConexion();
        await pool.request()
        .input('idm',sql.Int,idm)
        .input('punto',sql.VarChar(200),punto)
	    .input('ph',sql.VarChar(50),ph)
        .input('cl',sql.VarChar(50),cl)
	    .input('idu',sql.Int,idu)
        .execute('dbo.uspnuevamestraapp');
        respuesta.exito(req,res,{msg:'Muestra Ingresada'},200)
    } catch (error) {
        respuesta.error(req,res,error,500)
    }


    
}

async function obtenerMuestra(req,res){
    const idm=req.params.id;
    try {
        
        const pool = await getConexion();
        const result = await pool.request()
        .input('idm',sql.Int,idm)
        .execute('dbo.uspobtenermuestra')
        respuesta.exito(req,res,result.recordset,200)
    } catch (error) {
        respuesta.error(req,res,error,500)
    }

}

async function actualizarMuestra(req,res){
    const {id,pmuestra,ph,cl}=req.body;
    try {
        const pool = await getConexion();
        await pool.request()
        .input('id',sql.Int,id)
        .input('pmuestra',sql.VarChar(100),pmuestra)
        .input('ph',sql.VarChar(50),ph)
        .input('cl',sql.VarChar(50),cl)
        .execute('dbo.uspactualizarmuestra')
        respuesta.exito(req,res,{msg:'Muestra actualizado'},200);
    } catch (error) {
        respuesta.error(req,res,error.message,500);
    }
}



module.exports={
    obtenerMuestras,
    obtnerMuestrasCompletas,
    obtenerMuestrasIncompletas,
    nuevaMuestraApp,
    obtenerMuestra,
    actualizarMuestra
}
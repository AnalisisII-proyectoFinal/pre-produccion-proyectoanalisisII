const {getConexion,sql} = require('../../../sqlserver/sqlserverconexion.js')
const respuesta = require('../../../respuesta/respuesta.js');
class DetalleTanque{
    constructor(){
        this.tanque='',
        this.numero=0,
        this.ubicacion = '',
        this.ffecha='',
        this.largo='',
        this.ancho='',
        this.alto='',
        this.mcloro='',
        this.mants=[]
    }

    agregarDetalles(detalles){
        this.tanque=detalles.tanq
        this.numero=detalles.num
        this.ubicacion=detalles.ubic
        this.ffecha=detalles.ffuncion
        this.largo=detalles.largo
        this.ancho=detalles.ancho
        this.alto=detalles.altura
        this.mcloro=detalles.tpcloro
    }
    agregarMantenimiento(mant){
        this.mants.push(mant)
    }
}




async function obtenerTanques(req,res) {
    try {
        const pool = await getConexion();
        const result = await pool.request().execute('dbo.uspobtenertanquesrep');
        respuesta.exito(req,res,result.recordset,200)
    } catch (error) {
        console.log(error)
        respuesta.error(req,res,error,500)
    }
}

async function obtenerDetalleTanque(req,res) {
    const idt=req.params.id;
    const datat=[];
    try {
        const pool = await getConexion();
        const result = await pool.request().input('idt',sql.Int,idt).execute('dbo.uspobtenertanquerep');
        const resultM = await pool.request().input('idt',sql.Int,idt).execute('dbo.uspobtenermantenimiento');
        let dTanque = new DetalleTanque();
         if (result.recordset.length !== 0) {
            dTanque.agregarDetalles(result.recordset[0])
            if (resultM.recordset.length!==0) {
                for (let i = 0; i < resultM.recordset.length; i++) {
                    let mant={
                        titulo:resultM.recordset[i].titulo,
                        descripcion:resultM.recordset[i].descripcion,
                        mimg:resultM.recordset[i].mimg,
                        mfecha:resultM.recordset[i].mfecha
                    }
                    dTanque.agregarMantenimiento(mant)
                } 
            }else{
                let mantt={
                    titulo:'',
                    descripcion:'',
                    mimg:'',
                    mfecha:''
                }
                dTanque.agregarMantenimiento(mantt)
            }
            
            datat.push(dTanque)
        }
        respuesta.exito(req,res,datat,200)
        
    } catch (error) {
       
        console.log(error)
        respuesta.error(req,res,error,500)
    }
    
}

module.exports={
    obtenerTanques,
    obtenerDetalleTanque
}
const respuesta = require('./respuesta.js');

function errors(err,req,res) {
    console.log('[error]',err)
    const mensaje = err.mensaje || 'Error Interno';
    const status = err.codEstado || 500;
    respuesta.error(req,res,mensaje,status)
}

module.exports = errors;
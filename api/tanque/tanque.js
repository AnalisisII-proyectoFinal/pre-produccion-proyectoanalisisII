const express = require('express');
const ctrl = require('./controladores')
const router = express.Router();

// rutas nuevo tanque

router.get('/tanques',ctrl.tanque.obtenerTanques);
router.get('/tanques/:id',ctrl.tanque.obtenerTanque);
router.post('/tanque',ctrl.tanque.nuevoTanque);
router.put('/tanque',ctrl.tanque.actualizarTanque);
router.delete('/tanque/:id',ctrl.tanque.eliminarTanque);

// mantenimiento
 
router.get('/mantenimiento',ctrl.mantenimiento.obtenerMantenimientos);
router.get('/manttanques',ctrl.mantenimiento.obtnerTanques);
router.get('/mantenimiento/:id',ctrl.mantenimiento.obtenerMantenimiento);
router.post('/mantenimiento',ctrl.mantenimiento.crearMantenimiento);
router.put('/mantenimiento',ctrl.mantenimiento.actualizarMantenimiento);
router.delete('/mantenimiento/:id',ctrl.mantenimiento.eliminarMantenimiento);

//metodo cloracion
router.get('/metodocl',ctrl.metodocl.obtenerMetodosCloracion);
router.get('/metodocl/:id',ctrl.metodocl.obtenerMetodoCloracion);
router.post('/metodocl',ctrl.metodocl.crearMetodoCloracion);
router.put('/metodocl',ctrl.metodocl.actualizarMetodoCloracion);
router.delete('/metodocl/:id',ctrl.metodocl.eliminarMetodoCloracion);

module.exports = router;

"use strict";
//@ts-check
/**
 * Opciones del modulo Tanque
 * @module OpcTanque - opciones
 * @author autor 
 * @copyright - ksksue
 * @version 1.0
 */
/**
 * importacion de modulos
 * @requires componente:funciones - mostrar, ocultar y resaltar componentes.
 */
import {mostrarComponente} from '../utilidades/MostrarComponente.js';
import UiMantenimiento from './ui/Mantenimiento.ui.js';
import UiMetodoCloracion from './ui/MetodoCloracion.ui.js';
import UiNuevoTanque from './ui/NuevoTanque.ui.js';
/**
 * @type {string} - id de paginas
 */

const BTN_1 = 'btn-1';

/**
 * Construye el  componente de opciones del modulo de muestras
 * @returns {HTMLDivElement} 
 */
export function OpcTanque(){
    const $opctanque = document.createElement('div');
        $opctanque.classList.add("menu-lateral");
        $opctanque.innerHTML=`
          <div><img src="./assets/img/tanque.svg" alt="img"></div>
          <button id="btn-1" class="btn-modulo">Nuevo</button>
          <button id="btn-2" class="btn-modulo">Mantenimiento</button>
          <button id="btn-3" class="btn-modulo">Metodo Cloracion</button>
        `;
        /**
         * inicio de funcionalidades
         */
    function iniTanque(){
      const tanq=new UiNuevoTanque();
      const mtc = new UiMetodoCloracion();
      const mant = new UiMantenimiento();
      const opcModulo = document.querySelector('.menu-lateral');
        opcModulo.addEventListener('click',(e)=>{
          if(e.target && e.target.tagName === 'BUTTON'){
            mostrarComponente(e.target.id);
            if (e.target.id === 'btn-1') {
              tanq.obtenerMetodoClorificacion(0);
              tanq.obtenerTanques();
            }else if (e.target.id === 'btn-2') {
              mant.obtnerMantenimientos();
              mant.obtenerTanques();
            }else if (e.target.id === 'btn-3') {
              mtc.obtenerMetodosCloracion();
            }
            
          }
        })     
      mostrarComponente(BTN_1);
      tanq.obtenerMetodoClorificacion(0);
      tanq.obtenerTanques();
    }
    /**
    * Temporizador para inicio de funcionalidades
    */
    setTimeout(()=>iniTanque(),100);
    return $opctanque;
}
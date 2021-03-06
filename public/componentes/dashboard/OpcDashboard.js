"use strict";
//@ts-check
/**
 * Opciones del modulo Dashboard
 * @module OpcDashboard - opciones
 * @author autor 
 * @copyright - ksksue
 * @version 1.0
 */
/**
 * importacion de modulos
 * @requires componente:funciones - mostrar, ocultar y resaltar componentes.
 */
import {mostrarComponente} from '../utilidades/MostrarComponente.js';
import UiHiloActual from './ui/HiloActual.ui.js';
/**
 * @type {string} - id de paginas
 */

const BTN_1 = 'btn-1';

/**
 * Construye el  componente de opciones del modulo de muestras
 * @returns {HTMLDivElement} 
 */
export function OpcDashboard(){
  const $opcdashboard = document.createElement('div');
  $opcdashboard.classList.add("menu-lateral");
  $opcdashboard.innerHTML=`
        <div><img src="./assets/img/progress.svg" alt="img"></div>
        <button id="btn-1" class="btn-modulo">HILO ACTUAL</button>
  `;
        /**
         * inicio de funcionalidades
         * @returns {void} - funcionalidades de navegacion entre componentes
         */
        function iniDashboard(){
          const opcModulo = document.querySelector('.menu-lateral');
          opcModulo.addEventListener('click',(e)=>{
            if(e.target && e.target.tagName === 'BUTTON'){
              mostrarComponente(e.target.id);
              if (e.target.id==='btn-1') {
                const progActual = new UiHiloActual();
                progActual.obtnerMuestras();
                
              }
            }
          })     
         mostrarComponente(BTN_1);
         const pro = new UiHiloActual();
         pro.obtnerMuestras();
         
        }
        setTimeout(()=>iniDashboard(),100);
        return $opcdashboard;
}
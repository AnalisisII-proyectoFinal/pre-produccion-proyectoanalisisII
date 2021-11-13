"use strict";
//@ts-check
/**
 * Importacion de componentes para el modulo
 * @requires componente: opcPanel  para las opciones del modulo
 */
import {OpcAyuda} from './OpcAyuda.js'
import { Tutoriales} from './paginas/Tutoriales.js';
import { Manuales } from './paginas/Manuales.js';

/**
 * Unificacion de componentes del modulo
 * @returns {void} modulo de panel y funcionalidades
 */
export function Ayuda() {
    /**panel contenedor del modulo */
    const $ayuda=document.createElement('section');
    $ayuda.classList.add('contenedor-modulo');
    $ayuda.appendChild(OpcAyuda());
    /**paginas contenedor de paginas */
    const $paginas = document.createElement('div');
    $paginas.classList.add("contenido-pagina")
    $paginas.appendChild(Tutoriales());
    $paginas.appendChild(Manuales());    
    $ayuda.appendChild($paginas);
    return $ayuda;
}
"use strict";
//@ts-check
/**
 * @requires componente: encabezado logotipo, titulo de la aplicacion y boton login
 * @requires componente: Cuerpo modulo seleccionado
 * @requires componente: router encargado mostrar el modulo seleccionado
 */
import {Encabezado}from './componentes/aplicacion/paginas/Encabezado.js';
import {Cuerpo} from './componentes/aplicacion/layouts/Cuerpo.js';
import {Router} from './componentes/Router.js';


export function Init() {
    const $encabezado= document.getElementById('encabezado');
    $encabezado.appendChild(Encabezado());
    App();   
}
/**
 * App unificacion de componentes
 */
export function App(){
    const $root = document.getElementById('root');
        $root.innerHTML = null;
        $root.appendChild(Cuerpo());
    Router();
}
"use strict";
//@ts-check
/**
 * creacion de las opciones que tendra el modulo usuario
 * @returns {void} historial del modulo y funcionalidades
 */
export function Manuales(){
    const $manual = document.createElement('div');
        $manual.classList.add("pagina");
        $manual.setAttribute('id',"pg2");
        $manual.setAttribute('style',"display:none;")
        $manual.innerHTML=`
        <div class="contenedor-ayuda">
        <h2><div class="heading">Manual de uso Sistema Web</div></h2>
        <hr>
            <div class="contenedor-manuales">
                <div class="contenedor-manual">
                    <h3>Manual de Usuario</h3>
                <div class="manual-img">
                    <img src="./assets/img/m1.jpg" alt="">
                </div>
                    <p>Manual para la operación y manejo de aplicación web</p>
                    <button class="tercer-btn"><a href="https://1drv.ms/b/s!AjdogLJVeS76bLAPoG8sy-CNaww?e=mD3KlB" target="_blank">Ver Manual</a></button>
                </div>
                <div class="contenedor-manual">
                    <h3>Manual de Usuario APP movil</h3>
                <div class="manual-img">
                    <img src="./assets/img/m2.jpg" alt="">
                </div>
                    <p>Manual para la operacion y manejo de aplicación movil</p>
                    <button class="tercer-btn"><a href="https://1drv.ms/b/s!AjdogLJVeS76a6qy1_MzTTbkmqo?e=XYn7vW" target="_blank">Ver Manual</a></button>
                </div> 
                <div class="contenedor-manual">
                    <h3>Manual de Tecnico</h3>
                <div class="manual-img">
                    <img src="./assets/img/m3.jpg" alt="">
                </div>
                    <p>Manual para la instalacion del sistema.</p>
                    <button class="tercer-btn"><a href="https://1drv.ms/b/s!AjdogLJVeS76as1vL5MzZvY3p2Q?e=7S4znp" target="_blank">Ver Manual</a></button>
                </div>  
            </div>`;
        return $manual;
}
"use strict";
//@ts-check
import{validarInput}from '../../utilidades/ValidarFormulario.js';
import UiMetodoCloracion from '../ui/MetodoCloracion.ui.js';
import {notificarToast} from '../../utilidades/Notificacion.js';
/**
 * creacion de las opciones que tendra el modulo dashboard
 * @returns {void} historial del modulo y funcionalidades
 */
export function MetodoCloracion(){
    const $metodocloracion = document.createElement('div');
        $metodocloracion.classList.add("pagina");
        $metodocloracion.setAttribute('id',"pg3");
        $metodocloracion.setAttribute('style',"display:none;")
        $metodocloracion.innerHTML=`
        <section class="contenedor-tanques">
          <h2>Metodo de cloracion</h2>
          <hr>
          <form action="" class="form-cloracion">
            <p><label for="" class="input-label">Tratamiento:</label>
            <input type="text" class="input-dato" id="m-metodo" placeholder="metodo" required=""/></p>
            <p><label for="" class="input-label">Descripcion:</label>
            <input type="text" class="input-dato" id="m-desc" placeholder="descripcion" required=""/></p>
            <p><label for="" class="input-label"></label>
            <button class="primer-btn" id="btn-mt-g">Guardar</button></P>
          </form>
            <h2>Metodos registrados</h2>
            <hr>
          <div class="tabla-lista">
          <table>
          <thead>
            <tr>
              <th>No.</th>
              <th>tratamiento</th>
              <th>Descripción</th>
              <th>Editar</th>
              <th>Eliminar</th>
            </tr>
          </thead>
          <tfoot>
            <tr>
              <th colspan='7'>metodos de cloracion</th>
            </tr>
          </tfoot>
          <tbody id="lista-metodos"> 
          </tbody>
          </table>
        </div>        
      </section>`;
        function initEditarMetodoCloracion(){
          const uiMetCl = new UiMetodoCloracion();
          const servNoti = new ServicioNotificacion();
          document.getElementById('lista-metodos').addEventListener('click',(e)=>{
            if (e.target.classList.contains('editar')) {
              const idmcl = e.target.getAttribute('_id');
              console.log(idmcl)
              uiMetCl.obtenerMetodoCloracion(idmcl);
            }else if (e.target.classList.contains('eliminar')){
              const idmc = e.target.getAttribute('_id');
              let rConf = confirm("¿Desea eliminar el Metodo de cloracion?");
              rConf ? uiMetCl.eliminarMetodoCloracion(idmc):notificarToast("info","Cancelado");
            }
          })
          const form = document.querySelector ('.form-cloracion');
          form.addEventListener('keydown',(e)=>{
            let tipo = e.target.name;
            let id = e.target.id; 
            let valor = e.target.value;
            validarInput(tipo,id,valor);
          })

          const btnGuardar=document.getElementById('btn-mt-g');
          btnGuardar.addEventListener('click',(e)=>{
            e.preventDefault();            
            const metodo=document.getElementById('m-metodo').value;
            const desc=document.getElementById('m-desc').value;
            if (metodo !=='' || desc!=='') {
              let metodoD ={
                tratamiento:metodo,
                descripcion:desc
              }
              uiMetCl.nuevoMetodoCloracion(metodoD);
            }else{
              notificarToast("error","Llene todos los campos");
            }
          })
        }
        setTimeout(()=>initEditarMetodoCloracion(),100);
        return $metodocloracion;
}
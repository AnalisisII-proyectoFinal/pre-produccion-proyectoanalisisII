"use strict";
import{validarInput}from '../../utilidades/ValidarFormulario.js'

import UiTipoMuestra from '../ui/TipoMuestra.ui.js';
import {notificarToast} from '../../utilidades/Notificacion.js';

/**
 * creacion de las opciones que tendra el modulo dashboard
 * @returns {void} historial del modulo y funcionalidades
 */
export function TipoMuestra(){
    const $tipomuestra = document.createElement('div');
        $tipomuestra.classList.add("pagina");
        $tipomuestra.setAttribute('id',"pg4");
        $tipomuestra.setAttribute('style',"display:none;")
        $tipomuestra.innerHTML=`
        <section class="contenedor-muestras">
        <div>
          <h2>Tipo de muestras</h2>
          <hr>
          <form action="" class="nuevo-tipo-muestra">
            <span id="id-tm" hidden></span>
            <p><label for="" class="input-label">Nombre:</label>
              <input type="text" class="input-dato"  id="t-muestra" placeholder="tipo" required=""/></p>
            <p><label for="" class="input-label">Descripcion:</label>
              <input type="text" class="input-dato"  id="t-desc" placeholder="descripcion" required=""/></p>
              <p>
              <p><label for="" class="input-label"></label>
              <button id="t-btn-g" class="primer-btn">Actualizar</button></p>
          </form>
        </div>
        <div>
          <h2>Tipos de muestras</h2>
          <hr>
          <div class="tabla-lista">
            <table>
              <thead>
                <tr>
                  <th>No.</th>
                  <th>Tipo Muestra</th>
                  <th>Descripcion</th>
                  <th>Opciones</th>
                </tr>
              <tbody id="lista-tipo-muestra">
            </tbody>
        </table>
        </div>
      </div>
    </section>
        `;
        function initTipoMuestra(){
        
          document.getElementById('t-btn-g').addEventListener('click',(e)=>{
            e.preventDefault()
            const $idtm = document.getElementById('id-tm').innerHTML;
            const $tipoM= document.getElementById('t-muestra').value;
            const $descTM= document.getElementById('t-desc').value;
            
            if($idtm===''||$tipoM===''||$descTM===''){
              notificarToast('error',"Llene todos los datos");
            }else{
              let datosTM={
                id:$idtm,
                tipo:$tipoM,
                desc:$descTM
              }
              const nuevoTipoMuestra= new UiTipoMuestra();
              nuevoTipoMuestra.actualizarTipoMuestra(datosTM);

            }
          })

          document.getElementById('lista-tipo-muestra').addEventListener('click',(e)=>{
            if (e.target.classList.contains("editar")) {
                let idtm= e.target.getAttribute('_id');
                const editarTm = new UiTipoMuestra();
                editarTm.obtenerTipoMuestra(idtm)              
            }
          })
        }
        setTimeout(()=>initTipoMuestra(),100);
        return $tipomuestra;
}

/**
 const form = document.querySelector ('.form-nuevo-tipo-muestra');
          form.addEventListener('keydown',(e)=>{
            let tipo = e.target.name;
            let id = e.target.id;
            let valor = e.target.value;
            validarInput(tipo,id,valor);
          })
 * 
 */
"use strict";
//@ts-check
/**
 * creacion de las opciones que tendra el modulo usuario
 * @returns {void} historial del modulo y funcionalidades
 */
 
 import UiListarUsuario from '../ui/ListarUsuarios.ui.js';
 import {notificarToast} from '../../utilidades/Notificacion.js';

export function ListaUsuarios(){
    const $listausuarios = document.createElement('div');
        $listausuarios.classList.add("pagina");
        $listausuarios.setAttribute('id',"pg1");
        $listausuarios.setAttribute('style',"display:block;")
        $listausuarios.innerHTML=`
        <section class="contenedor-usuario">
          <h2>Empleados registrados</h2>
          <hr>
          <br>
          <div class="tabla-lista">
          <table>
              <thead>
                <tr>
                  <th>No.</th>
                  <th>Nombre Empleado</th>
                  <th>Dpi</th>
                  <th>Dirección</th>
                  <th>Cargo</th>
                  <th>Detalles</th>
                  <th>Opciones</th>
                </tr>
                </thead>
                <tbody id="lista-usuarios">
                </tbody>
          </table>          
        </div>
    </section>   
        `;
        function initListaUsuarios() {
          const uiListUsuario = new UiListarUsuario();
          uiListUsuario.obtenerDatosUsuarios();
          
          document.getElementById('lista-usuarios').addEventListener('click',(e)=>{
            if (e.target.classList.contains('editar')){
              const eid=e.target.getAttribute('_id')
              uiListUsuario.obtenerDatosUsuario(eid,1)
            }
            if (e.target.classList.contains('detalle')){
              const did=e.target.getAttribute('_id')
              uiListUsuario.obtenerDatosUsuario(did,0)

            }
            if(e.target.classList.contains('eliminar')){
              const elid=e.target.getAttribute('_id')
              let resConf=confirm("¿Quiere eliminar el usuario?");
              if (resConf) {
                uiListUsuario.eliminarUsuario(elid)
              }else{
                notificarToast("info","Operacion Cancelado")
              } 
            }
          })
          
        }
        setTimeout(()=>initListaUsuarios(),100)
        return $listausuarios;
}
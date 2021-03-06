import ServicioUsuario from '../servicio/Usuario.ser.js';
import {notificarToast} from "../../utilidades/Notificacion.js";
import {ventanModal} from "../../utilidades/VentanaModal.js";
import {VerDetalles} from "../paginas/VerDetalles.js";
import {EditarUsuario} from "../paginas/EditarUsuario.js";
const servUsuario = new ServicioUsuario();

class UiListarUsuario{
    obtenerDatosUsuarios(){
        servUsuario.hacerPeticion('/usuarios',{},'GET').then(datos=>{
            this.mostrarUsuarios(datos.body)
        }).catch(error=>{
            console.log(error)
            notificarToast("error","Al cargar los datos")
        })
    }
    obtenerDatosUsuario(idu,edit){
        servUsuario.hacerPeticion(`/usuario/${idu}`,{},'GET').then(dato=>{
            if (edit < 1) {
                this.verDetallesUsuario(dato.body[0])
            }else{
                this.editarUsuario(dato.body[0])
            }
            
        }).catch(err=>{
            console.log(err)
            notificarToast("error","Al cargar datos")
        })
    }
    mostrarUsuarios(usuarios){
        const $lista = document.getElementById('lista-usuarios');
        $lista.innerHTML='';
        const $fragment = document.createDocumentFragment();
        let $no = 1;
        usuarios.forEach(el => {
            if (el.dpi !== 'default' ) {
                const $fila = document.createElement('tr');
                $fila.innerHTML=`
                <td>${$no}</td>
                <td>${el.nombre}</td>
                <td>${el.dpi}</td>
                <td>${el.direccion}</td>
                <td>${el.cargo}</td>
                <td>
                <button class="detalle" _id="${el.id}">📇​</button>
                </td>
                <td class="opciones-tbl">
                <button class="editar" _id="${el.id}">✏️</button>
                <button class="eliminar" _id="${el.id}">🗑️</button>
                </td>
                `;
                $fragment.appendChild($fila)
                $no++;  
            }
           
        });
        $lista.appendChild($fragment)
    }
    editarUsuario(empleado){
        ventanModal(EditarUsuario(empleado))
    }
    eliminarUsuario(idu){
       servUsuario.hacerPeticion(`/usuario/${idu}`,{},'DELETE').then(r=>{
           this.obtenerDatosUsuarios();
           notificarToast("success",r.body.msg)
       }).catch(err=>{
           console.log(err)
           notificarToast("error","Al cargar datos");
       }) 

    }
    verDetallesUsuario(empleado){
        ventanModal(VerDetalles(empleado))   
    }
    actualizarEmpleado(empleado){
        servUsuario.hacerPeticion('/usuario',empleado,'PUT').then(r=>{
            this.quitarModal();
            this.obtenerDatosUsuarios();
            notificarToast('success',r.body.msg)
        }).catch(err=>{
            console.log(err)
            notificarToast('error','Al actualizar el registro')
        })
    }
    quitarModal(){
        const modal = document.querySelector('.modal-contenedor');
        document.body.removeChild(modal)
    }

}
export default UiListarUsuario;
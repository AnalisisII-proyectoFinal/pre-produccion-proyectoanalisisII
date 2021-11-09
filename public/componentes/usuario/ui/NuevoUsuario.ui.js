import ServicioUsuario from "../servicio/Usuario.ser.js";
import {notificarToast} from "../../utilidades/Notificacion.js";
const serUsuario = new ServicioUsuario();


class UiUsuario{
    nuevoUsuario(usuario){
        serUsuario.hacerPeticion('/nuevousuario',usuario,'POST').then(r=>{
            notificarToast("success",r.body.msg)
        }).catch(err=>{
            console.log(err)
            notificarToast("error","Al actualizar usuario");
        })
    }

    limpiarFormulario(){
        document.querySelector('.f-datos-usuario').reset();
    }

}

export default UiUsuario;
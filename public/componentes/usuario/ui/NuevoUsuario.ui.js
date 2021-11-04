import ServicioUsuario from "../servicio/Usuario.ser.js";
import ServicioNotificacion from "../../utilidades/Notificacion.js";
const serUsuario = new ServicioUsuario();
const servNoti = new ServicioNotificacion();

class UiUsuario{
    nuevoUsuario(usuario){
        serUsuario.hacerPeticion('/nuevousuario',usuario,'POST').then(r=>{
            servNoti.notificarToast("success",r.body.msg)
        }).catch(err=>{
            console.log(err)
            servNoti.notificarToast("error","no se puede crear usuario");
        })
    }

    limpiarFormulario(){
        document.querySelector('.f-datos-usuario').reset();
    }

}

export default UiUsuario;
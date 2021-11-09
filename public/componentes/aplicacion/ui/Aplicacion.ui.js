import ServicioAplicacion from "../servicio/Aplicacion.ser.js"
import {notificarToast} from '../../utilidades/Notificacion.js';
import {ventanModal} from '../../utilidades/VentanaModal.js';
import ServicioAuth from "../servicio/Auth.ser.js";
import { EditarPerfil } from "../paginas/Perfil.js";
const servAplicacion = new ServicioAplicacion();
const servAuth = new ServicioAuth();

class UiAplicacion{
    obtenerDatosEncabezado(){
        const $log = document.getElementById('logo-inst');
        const $tituloEl = document.createElement('h1');
        servAplicacion.hacerPeticion('/datosinstitucion',{},'GET').then(datos =>{
            $tituloEl.innerHTML=`${datos.body[0].entidad}<br>${datos.body[0].dependencia}<br>${datos.body[0].app}`;
            $log.src=datos.body[0].logo;
        }).then(()=>{
            const content = document.getElementById('encabezado-datos');
            content.innerHTML='';
            content.appendChild($tituloEl);
        })
    }

    autenticarUsuario(datosUsuario){
        servAuth.hacerPeticion('/autenticarusuario',datosUsuario,'POST').then(res=>{
            if (res.body.t === 0) {
                notificarToast("error",res.body.msg)
            }else{
              this.ingresarSistema(res.body)
              notificarToast('success',"Bienvenido");
            }              
          }).catch(err=>{
            console.log(err)
            notificarToast('warning',"Al cargar los datos");
          })
    }

    ingresarSistema(datosUs){
        const $avatar = document.getElementById('avatar-us');
        const idu=datosUs.id;
        localStorage.setItem('dataUser',JSON.stringify(datosUs));
        location.href= '#/app/dashboard';
        this.obtenerDatosUsuario(idu)
        $avatar.style.visibility = 'visible';  
    }

    obtenerDatosUsuario(idu){
        servAplicacion.hacerPeticion(`/infousuario/${idu}`,{},'GET').then( datos=>{
            localStorage.setItem('nombre',datos.body[0].nombre);
            localStorage.setItem('avatar',datos.body[0].avatar);
            notificarToast("success","Se cargaron datos")
         }).catch(err=>{
            console.log(err)
            notificarToast('warning',"Al cargar los datos")
         })
         this.actualizarPerfil();
    }
    
    editarPerfil(idu){
        servAplicacion.hacerPeticion(`/obtenerdatosusuario/${idu}`,{},'GET').then(datos=>{
            ventanModal(EditarPerfil(datos.body))
        }).catch(err=>{
            console.log(err)
            notificarToast("error","No se pudo cargar los datos")
        })

    }
    actualizarPerfil(){
        document.getElementById('avatar-us').src=localStorage.getItem('avatar');
        document.getElementById('nombre-u').innerHTML=localStorage.getItem('nombre');
    }

    mostrarPerfil(){
        document.getElementById('perfil-usuario').style.visibility="visible";
        document.getElementById('btn-irlogin').style.visibility="hidden";    
    }
    ocultarPerfil(){
        document.getElementById('perfil-usuario').style.visibility="hidden";
        document.getElementById('btn-irlogin').style.visibility="visible";
    }
    
    cambiarContrasena(pass){
        const datosUs = localStorage.getItem('dataUser');
        const idu=JSON.parse(datosUs).id;
        servAplicacion.hacerPeticion('/actualizarcontrasena',{id:idu,pass:pass},'PUT').then(r=>{
            notificarToast('success',r.body.msg)
        }).catch(err=>{
            console.log(err)
            notificarToast('error','No se pudo actualizar');
        })
    }
    cambiarPin(pin){
        const datosUs = localStorage.getItem('dataUser');
        const idu=JSON.parse(datosUs).id;
        servAplicacion.hacerPeticion(`/actualizarpin/${idu}`,{pin:pin},'PUT').then(r=>{
            notificarToast('success',r.body.msg)
        }).catch(err=>{
            console.log(err)
            notificarToast('error','No se pudo actualizar');
        })
    }
    actualizarDatosUsuario(datos){
        const datosUs = localStorage.getItem('dataUser');
        const idu=JSON.parse(datosUs).id;
        servAplicacion.hacerPeticion(`/actualizardatosusuario/${idu}`,datos,'PUT').then(r=>{
            this.quitarModal();
            notificarToast('success',r.body.msg)
        }).catch(err=>{
            console.log(err)
            notificarToast('error','No se pudo actualizar');
        })
    }
    quitarModal(){
        const modal = document.querySelector('.modal-contenedor');
        document.body.removeChild(modal)
    }
}
export default UiAplicacion;
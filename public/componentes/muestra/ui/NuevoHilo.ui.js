import ServicioMuestra from '../servicio/Muestra.ser.js';
import {notificarToast} from "../../utilidades/Notificacion.js";
const serNuevoHilo = new ServicioMuestra();

class UiNuevoHilo{
    nuevoHilo(datosnhilo){
        serNuevoHilo.hacerPeticion('/nuevohilo',datosnhilo,'POST').then(r=>{
            this.asignarTanquesOpc();
            notificarToast("success",r.body.msg)
        }).catch(err=>{
            console.log(err)
            notificarToast("error","Al crear Hilo")
        })
    }

    obtnerHilo(){
        serNuevoHilo.hacerPeticion('/hiloactual',{},'GET').then(datos=>{
            this.agregarHilo(datos.body);
        }).catch(err=>{
            console.log(err)
            notificarToast("error","Al cargar Datos")
        })
    }

    agregarHilo(hilo){
        let fI=this.formatearFecha(hilo[0].fecha1);
        let fF = this.formatearFecha(hilo[0].fecha2);
        const $h = document.getElementById('n-i-m-hilo');
         $h.innerHTML= `Hilo actual De: ${fI} AL: ${fF} [${hilo[0].porcentaje}%]`;
         document.getElementById('n-p-hilo-i').setAttribute('value',hilo[0].porcentaje);
     }
     formatearFecha(fecha){
        const f = new Date(fecha);
        const mes = f.getMonth() + 1; 
        const dia = f.getDate();
        return `${(dia < 10 ? '0' : '').concat(dia)}-${(mes < 10 ? '0' : '').concat(mes)}-${f.getFullYear()}`;
    }

    asignarTanquesOpc(){
        serNuevoHilo.hacerPeticion('/tanquesopc',{},'GET').then(datos=>{
            this.mostrarTanques(datos.body)
            this.dibujarTanques(datos.body)
        }).catch(err=>{
            console.log(err)
            notificarToast("error","Al cargar Datos")
        })
    }

    
    mostrarTanques(tanques){
        const $selectT =document.getElementById('nh-opc-t')
        $selectT.innerHTML='';
            let $fragment= document.createDocumentFragment();
            let $opc2=`<option value="0"> todos </option>`;
            tanques.forEach(el=>{
              let $fila = document.createElement('option');
              $fila.setAttribute('value',el.id)
                $fila.innerHTML=`
                  ${el.nombre}`;
                $fragment.appendChild($fila)
            })
              
            $selectT.appendChild($fragment);
            $selectT.innerHTML += $opc2;
    }

    asignarTanque(idt){
        serNuevoHilo.hacerPeticion('/agregartanque',{idtanque:idt},'POST').then(r=>{
            this.activarTanque(idt)
            notificarToast("success",r.body.msg)
            serNotificacionNH.agregarNotificacion('exito',r.body.msg)
        }).catch(err=>{
            console.log(err)
            notificarToast("error","Al cargar Datos")
        })
    }
    asignarTanques(){
        serNuevoHilo.hacerPeticion('/agregartanques',{},'POST').then(r=>{
            this.activarTanques()
            notificarToast("success",r.body.msg)
        }).catch(err=>{
            console.log(err)
            notificarToast("error","Al cargar Datos")
        })
    }

    dibujarTanques(tanques){
        const $proAsign = document.getElementById('progreso-asignacion');
        let $fragment= document.createDocumentFragment();
        $proAsign.innerHTML='';
        tanques.forEach(el=>{
            let $fila = document.createElement('li');
            $fila.setAttribute('id','t'+el.id)
              $fila.innerHTML=`
                ${el.nombre}`;
              $fragment.appendChild($fila)
          })      
        $proAsign.appendChild($fragment);
    }

    activarTanque(idt){
        document.getElementById(`t${idt}`).classList.add('listo');
        serNotificacionNH.agregarNotificacion('exito','se agregaron tanques al hilo')
    }
    activarTanques(){
        document.querySelectorAll('li').forEach(el=>{
            el.classList.add('listo');
        })
    }

    limipiarFormulario(){
        document.querySelector('.form-nuevo-hilo').reset();
    }
}
export default UiNuevoHilo;
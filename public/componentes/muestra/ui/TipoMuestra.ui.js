import ServicioMuestra from '../servicio/Muestra.ser.js';
import Notificacion from '../../utilidades/Notificacion.js';
const serTipoMuestra = new ServicioMuestra();
const servNoti=new Notificacion();

class UiTipoMuestra{
    obtnerTipoMuestras(){
        serTipoMuestra.hacerPeticion('/tipomuestra',{},'GET').then(datos=>{
            this.listarTipoMuestra(datos.body)
        }).catch(err=>{
            console.log(err)
            servNoti.notificarToast('error','Al  cargar datos')
        })
    }

    listarTipoMuestra(tipomuestras){
        const $tablatipom = document.getElementById('lista-tipo-muestra');
        $tablatipom.innerHTML='';
            let $fragment= document.createDocumentFragment();
            let $n=1;
            tipomuestras.forEach(el=>{
              let $fila = document.createElement('tr');
                $fila.innerHTML=`
                <td>${$n}</td>
                <td>${el.tipo}</td>
                  <td>${el.descr}</td>
                  <td>
                  <button _id="${el.id}" class="editar">✏️</button>
                  </td>`;
                $fragment.appendChild($fila)
                $n++;
            })  
        $tablatipom.appendChild($fragment);
    }

    obtenerTipoMuestra(idtm){
        serTipoMuestra.hacerPeticion(`/tipomuestra/${idtm}`,{},'GET').then(dato=>{
            this.editarTipoMuestra(dato.body[0])
        }).catch(err=>{
            console.log(err)
            servNoti.notificarToast('error','Al  cargar datos')
        })
    }
    editarTipoMuestra(tipomuestra){
        const $idtm = document.getElementById('id-tm');
        const $tipo= document.getElementById('t-muestra');
        const $desc= document.getElementById('t-desc');
        $idtm.innerHTML=tipomuestra.id;
        $tipo.value=tipomuestra.tipo;
        $desc.value=tipomuestra.descripcion;
    }

    actualizarTipoMuestra(tipomuestra){
        serTipoMuestra.hacerPeticion('/tipomuestra',tipomuestra,'PUT').then(res=>{
            this.obtnerTipoMuestras();
            servNoti.notificarToast('success',res.body.msg)
        }).catch(err=>{
            console.log(err)
            servNoti.notificarToast('error','Al  actulizar datos')
        })
    }
   /*  nuevoTipoMuestra(tipomuestra){
        serTipoMuestra.hacerPeticion('/tipomuestra',tipomuestra,'POST').then(r=>{
            serNotificacionTM.agregarNotificacion('exito',r.body.msg);
        }).catch(err=>{
            console.log(err)
            serNotificacionTM.agregarNotificacion('error','ocurrio un error');
        })
    }
 */
    /* eliminarTipoMuestra(idtm){
        serTipoMuestra.hacerPeticion('/tipomuestra',{id:idtm},'PUT').then(r=>{
            this.obtnerTipoMuestra();
            serNotificacionTM.notificarToast("success",r.body.msg);   
        }).catch(err=>{
            console.log(err)
            serNotificacionTM.agregarNotificacion('error','ocurrio un error');
        })
    } */

}
export default UiTipoMuestra;
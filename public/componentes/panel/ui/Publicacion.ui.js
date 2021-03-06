import {ventanModal} from '../../utilidades/VentanaModal.js';
import{EditarPublicacion} from '../paginas/EditarPublicacion.js';
import ServicioPanel from '../servicio/Panel.ser.js';
import {notificarToast} from '../../utilidades/Notificacion.js';
const servPublicacion = new ServicioPanel();



class UiPublicacion {
    obtnerPublicaciones(){
        servPublicacion.hacerPeticion('/publicacion',{},'GET').then(datos=>{
            this.mostrarPublicaciones(datos.body)
          }).catch(err=>{
              notificarToast("error","Al cargar Datos!")
              console.log(err)
          })
    }

    mostrarPublicaciones(publicaciones){
        const $listaPublic=document.getElementById('lista-publicacion');
            $listaPublic.innerHTML='';
            let $fragment= document.createDocumentFragment();
            let $n=1;
            publicaciones.forEach(el=>{
              let check=(el.estadop > 0)?'':'checked=""';
              let $fila = document.createElement('tr');
              $fila.innerHTML=`
              <td>${$n}</td>
              <td>${el.titulo}</td>
              <td>${el.fecha}</td>
              <td>
              <input type="checkbox" class="estado" _id="${el.idp}" ${check}>
              </td>
              <td>
              <button class="editar" _id="${el.idp}" t="${el.titulo}" d="${el.descripcion}" im="${el.img}">✏️</button>
              </td>
              <td>
              <button class="eliminar" _id="${el.idp}">🗑️</button>
              </td>`;
              $fragment.appendChild($fila)
              $n++;
          })  
          $listaPublic.appendChild($fragment);
    }


    nuevaPublicacion(datosPublic){
        servPublicacion.hacerPeticion('/publicacion',datosPublic,'POST').then( r=>{
            this.obtnerPublicaciones();
            notificarToast("success",r.body.msg);
        }).catch(err=>{
            notificarToast("error","Al crear publicación");
            console.log(err)
        })
    }

    editarPublicacion(t,d,idp,im){
        ventanModal(EditarPublicacion(t,d,idp,im))
    }

    actualizarPublicacion(datosPublic){
        servPublicacion.hacerPeticion('/actpublicacion',datosPublic,'PUT').then(r=>{
            this.obtnerPublicaciones();
            notificarToast("success",r.body.msg)
        }).catch(err=>{
            console.log(err)
            notificarToast("error","Al actualizar Datos !")
        })

    }

    eliminarPublicacion(idpub){
        const res = confirm("Quieres eliminar la publicacion ?")

        if (res) {
            servPublicacion.hacerPeticion('/eliminarpublic',{id:idpub},'PUT').then(r=>{
                this.obtnerPublicaciones();
                notificarToast("success",r.body.msg)
                }).catch(err=>{
                console.log(err)
                notificarToast("error","Al eliminar registro.!")
            })  
        }else{
            notificarToast("info","Eliminacion cancelado")
        }  
    }

    
}

export default UiPublicacion;
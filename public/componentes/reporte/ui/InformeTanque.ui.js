import ServicioReportes from "../servicios/Reporte.serv.js";
import {notificarToast}from "../../utilidades/Notificacion.js";
import {ventanModal} from "../../utilidades/VentanaModal.js";
import {InformeTanque}from "../paginas/InformeTanque.js";
const servRep = new ServicioReportes();


class UiInformeTanque{
    obtenerTanques(){
        servRep.hacerPeticion('/tanques',{},'GET').then(datos=>{
            this.mostrarTanques(datos.body)
        }).catch(err=>{
            console.log(err)
            notificarToast("error","Al cargar los datos")
        })
    }
    obtenerTanque(idt){
        servRep.hacerPeticion(`/tanque/${idt}`,{},'GET').then(dato=>{
            console.log(dato.body[0])
            this.informeTanque(dato.body[0])
        }).catch(err=>{
            console.log(err)
            notificarToast("error","Al cargar los datos")
        })
    }
    mostrarTanques(tanques){
        const $tablaTanques = document.getElementById('lista-tanques-inf');
        $tablaTanques.innerHTML='';
        if (tanques.length > 0) {
            let $fragment= document.createDocumentFragment();
            let $n=1;
            tanques.forEach(el=>{
              let $fila = document.createElement('tr');
                $fila.innerHTML=`
                <td>${$n}</td>
                <td>${el.tanq}</td>
                <td>${el.num}</td>
                <td>${el.ubic}</td>
                <td>${el.ffuncion}</td>
                <td>${el.largo}</td>
                <td>${el.ancho}</td>
                <td>${el.altura}</td>
                <td>${el.tpcloro}</td>
                <td>
                  <button _id="${el.idt}" class="inf">📇 informe</button>
                </td>`;
                $fragment.appendChild($fila)
                $n++;
            })  
            $tablaTanques.appendChild($fragment);   
        }else{
            let $filaf = document.createElement('tr');
            $filaf.innerHTML=`No hay datos encontrados`;
            $tablaTanques.appendChild($filaf)
        }

    }
    informeTanque(tanque){
        console.log(tanque)
        let mante=tanque.mants; 
        /*if (tanque.mants.length===0) {
            mante=0;
        }else{
            mante=tanque.mants;
        } */
       ventanModal(InformeTanque(tanque,mante)) 
    }
}
export default UiInformeTanque;
import {notificarToast} from '../../utilidades/Notificacion.js';
import UiIngMuestra from '../ui/IngresoMuestra.ui.js';
export function EditarIngresoMuestra(mta) {
  console.log(mta)
    const $editaringresomuestra = document.createElement('div');
    $editaringresomuestra.classList.add('edit-muestra')
    $editaringresomuestra.innerHTML=`
          <h3>Editar Muestra</h3>
          <hr>
          <form action="" class="form-ingreso-muestra">
          <span id="e-idm" hidden>${mta.id}</span>
          <div><label for="" class="input-label">Tanque:</label>
            <input type="text" class="input-dato" disabled value="${mta.tanque}"/></div>
            </div>
          <div><label for="" class="input-label">Tipo:</label>
          <input type="text" class="input-dato" disabled value="${mta.tmuestra}"/></div>
            </div>
          <div>
          <label for="" class="input-label">Punto de muestra:</label>
            <input type="text" class="input-dato" id="e-p-mta" placeholder="punto muestra" required="" value="${mta.pmuestra}"/></div>
          <div><label for="" class="input-label">PH:</label>
            <input type="text" class="input-dato" id="e-ph-mta" placeholder="ph" required=""value="${mta.ph}"/></div>
          <div><label for="" class="input-label">Cloro recidual:</label>
            <input type="text" class="input-dato" id="e-cl-mta" placeholder="cloro" required=""value="${mta.cl}"/></div>
          </form>
          <br>
          <div class="btn-ingreso-muestra">
          <button id="e-btn-act" class="tercer-btn">Actualizar</button>
          </div>
    `;

      function initEditMuestra() {
        const btnActualizar = document.getElementById("e-btn-act");
        btnActualizar.addEventListener('click',(e)=>{
          const idm = document.getElementById('e-idm').innerHTML;
          const pMuestra = document.getElementById('e-p-mta').value;
          const ph= document.getElementById('e-ph-mta').value;
          const cl = document.getElementById('e-cl-mta').value;
          if(pMuestra===''||ph===''|| cl===''){
            notificarToast("error","Complete todos los campos")
          }else{
            let muestra={
              id:idm,
              pmuestra:pMuestra,
              ph:ph,
              cl:cl
            }
            const uiIngMuestra = new UiIngMuestra();
            uiIngMuestra.actualizarMuestra(muestra)
          }
        })
      }
      setTimeout(()=>initEditMuestra(),100)
    return $editaringresomuestra;
}
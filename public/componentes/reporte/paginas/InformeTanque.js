function formatearFecha(fecha){
    const f = new Date(fecha);
    const mes = f.getMonth() + 1; 
    const dia = f.getDate();
    return `${(dia < 10 ? '0' : '').concat(dia)}-${(mes < 10 ? '0' : '').concat(mes)}-${f.getFullYear()}`;
}
export function InformeTanque(mant,mante) {
    console.log(mant)
    const $contenedorInforme = document.createElement('div');
    $contenedorInforme.classList.add('contenedor-informe');
    const $informet=document.createElement('div');
    $informet.classList.add('informe-tanque');
    $informet.setAttribute('id','inf-tanque');
    const $cabeceraDetall = document.createElement('div');
    $cabeceraDetall.classList.add('inf-t-cabecera');
    $cabeceraDetall.innerHTML=`
        <div>
            <img src="https://res.cloudinary.com/municipalidad-san-jose-chacaya/image/upload/v1633991805/yrzok1aak9dd1z8dyc8q.png" alt="">
        </div>
        <div>
            <h2>Municipalidad de San Jose Chacayá</h2>
            <h2>Dirección de agua y saneamiento</h2>
            <hr>
        </div>
        <div>
        </div>`;
    const $detallesT=document.createElement('div');
    $detallesT.classList.add('inf-t-cuerpo');
    $detallesT.innerHTML=`
    <h2>Detalles del tanque de agua</h2>
    <hr>
    <div class="datos-tanque">
        <div class="img-tanque">
            <img src="https://res.cloudinary.com/municipalidad-san-jose-chacaya/image/upload/v1633998233/is1fpgomh83hvunecsu6.jpg" alt="">
        <span>${mant.tanque}</span>
        </div>
    <div class="detalles-tanq">
        <ol>Nombre del sistema: <span>${mant.tanque}</span></ol>
        <ol>Numero del sistema: <span>${mant.numero}</span></ol>
        <ol>Ubicacion del sistema: <span>${mant.ubicacion}</span></ol>
        <ol>Fecha de inicio funcionamiento: <span>${formatearFecha(mant.ffecha)}</span></ol>
        <ol>Largo: <span>${mant.largo}</span></ol>
        <ol>Ancho: <span>${mant.ancho}</span></ol>
        <ol>Alto: <span>${mant.alto}</span></ol>
        <ol>Metodo Cloracion: <span>${mant.mcloro}</span></ol>
    </div>
    <br>
    <br>
    <br>
    `;



    const $divMant = document.createElement('div');
    $divMant.classList.add('tabla-muestras');
    const $tblMantenimiento=document.createElement('table');
    const $tblHead = document.createElement('thead');
    $tblHead.innerHTML=`
        <tr>
            <th class="fila-dato-inf">No.</th>
            <th class="fila-dato-inf">Mantenimiento</th>
            <th class="fila-dato-inf">Descripcion</th>
            <th class="fila-dato-inf">Fecha de Mantenimiento</th>
            <th class="fila-dato-inf">Fotografia</th>
        </tr>
    `;
    $tblMantenimiento.appendChild($tblHead);
    const $tblbody=document.createElement('tbody');
    const $frag = document.createDocumentFragment();
    let $no=1
    if (mante!==0) {
        for (let i = 0; i < mante.length; i++) {
            const $fila = document.createElement('tr');
            $fila.innerHTML=`
                <td class="fila-dato-inf">${$no}</td>
                <td class="fila-dato-inf">${mante[i].titulo}</td>
                <td class="fila-dato-inf">${mante[i].descripcion}</td>
                <td class="fila-dato-inf">${formatearFecha(mante[i].mfecha)}</td>
                <td class="fila-dato-inf">
                    <img width="50px" height="50px" src="${mante[i].mimg}" alt="img">
                </td>
            `;
            $frag.appendChild($fila);
            $no++;
        }
    }else{
        const $fila2 = document.createElement('tr');
            $fila.innerHTML=`
                <td class="fila-dato-inf">No Hay mantenimientos</td>
            `;
            $frag.appendChild($fila2);
    }
    
    $tblbody.appendChild($frag);
    
    $tblMantenimiento.appendChild($tblHead);
    $tblMantenimiento.appendChild($tblbody);
    $divMant.appendChild($tblMantenimiento);
    $informet.appendChild($cabeceraDetall);
    $informet.appendChild($detallesT);
    $informet.appendChild($divMant);
    
    const $pieInforme=document.createElement('div');
    $pieInforme.classList.add('botones-institucion');
    $pieInforme.innerHTML=`
              <p><button class="tercer-btn" id="inf-t-pdf">Exportar PDF</button></p>
    `;
    $contenedorInforme.appendChild($informet);
    $contenedorInforme.appendChild($pieInforme);

    function initInformT() {
        const btnPdf=document.getElementById('inf-t-pdf');
      btnPdf.addEventListener('click',(e)=>{
        const doc = document.getElementById('inf-tanque');
        var opt = {
          margin:1,
          filename:`informe_${mant.tanque}.pdf`,
          image: { type: 'png', quality: 0.98 },
          html2canvas: { dpi:192,letterRendering:true, scale: 2, useCORS:true },
          jsPDF: { unit: 'in', format: 'letter', orientation: 'portrait' }
        };
        html2pdf().set(opt).from(doc).save().catch(err=>console.log(err));
      });
        
    }
    setTimeout(()=>initInformT(),100)
    return $contenedorInforme;
}
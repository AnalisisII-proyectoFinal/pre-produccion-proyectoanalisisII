import UiInicio from './ui/Inicio.ui.js';

export function Inicio() {
    const $Inicio = document.createElement('div');
    $Inicio.classList.add('inicio')
    $Inicio.innerHTML=`
    <section class="contenedor-progreso">
        <h2>PROGRESO DE TOMA DE MUESTRA</h2>
        <h3 id="hilo-actual-i"></h3>
      <div class="contenedor-grafica" id="contenedor-progreso-ini"></div>
    </section>
    <section  class="contenedor-vision-mision">
        <h2>Quienes somos</h2>
        <div id="mision-vision"></div>
    </section>
    <section id="#/publicacion" class="contenedor-publicaciones">
        <h2>Mejoras y mantenimientos</h2>
        <div class="publicaciones" id="publicaciones-i"></div>
    </section>
    <br>
    <footer>
      <div class="footer-datos">
        <div>
          <h3 >Institucion</h3>
          <a href="">Municipalidad San Jose Chacayá</a>
          <h3>Direccion</h3>
          <a href="">Dirección Municipal de Agua y Sanemiento</a>
        </div>
        <div>
          <h3>Somos</h3>
          <a href="" >Mision</a><br>
          <a href="">Vision</a><br>
          <a href="" >labores</a>
        </div>
        <div>
          <h3>Contacto</h3>
          <a href="">PBX: 7762-3023</a><br>
          <a href="">Correo: munichacaya@gmail.com</a><br>
          <a href="https://sanjosechacaya.gob.gt/">Pagina Web:sanjosechacaya.gob.gt</a>
        </div>
      </div>
        <hr>
      <div class="footer-dato-fin">
          <h3>Sistema de Vigilancia Calidad Agua</h3>
          <p> Direccion Municipal de Agua y Saneamiento | Municipalidad de San Jose Chacayá.</p>
          <p>&#169; Municipalidad de San José Chacayá todos los derechos reservados.<br>Politica de Privacidad</p>
      </div>
    </footer>
</section>
        `;

    function iniInicio() {
      const iniDatos = new UiInicio();
      iniDatos.obtenerHiloActual();
      iniDatos.obtnerDatosProgresoMuestras();
      iniDatos.obtenerPublicaciones();
      iniDatos.obtnerMisionVision();
    }
    setTimeout(()=>iniInicio(),100);
    return $Inicio; 
}


        
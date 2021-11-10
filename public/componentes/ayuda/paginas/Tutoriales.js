"use strict";
//@ts-check
/**
 * creacion de las opciones que tendra el modulo usuario
 * @returns {void} historial del modulo y funcionalidades
 */
export function Tutoriales(){
    const $tutoriales = document.createElement('div');
        $tutoriales.classList.add("pagina");
        $tutoriales.setAttribute('id',"pg1");
        $tutoriales.setAttribute('style',"display:block;")
        $tutoriales.innerHTML=`
        <section class="contenedor-ayuda">
            <h2>Videos tutoriales</h2>
            <hr>
            <div class="contendedor-video">
            <div>
                <iframe id="video-player" width="100%" height="500px" src="https://www.youtube.com/embed/TUVcZfQe-Kw" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
            </div>
            <div class="tabla-lista" id="list-videos">
              <table>
                <thead>
                    <tr>
                        <th>No.</th>
                        <th>Tutorial</th>
                        <th>Opcion</th>
                    </tr>
                </thead>
                <tfoot>
                <tr>
                    <th colspan='3'>Tutoriales  de aplicacion</th>
                </tr>
                </tfoot>
                <tbody>
                  <tr>
                    <td>1</td>
                    <td>Introduccion</td>
                    <td>
                      <button data="https://www.youtube.com/embed/TUVcZfQe-Kw" class="play"> ▶️ </button>
                    </td>
                  </tr>
                  <tr>
                    <td>2</td>
                    <td>Modulo Tanque</td>
                    <td>
                      <button data="https://www.youtube.com/embed/0cJA_xdoCxs" class="play"> ▶️ </button>
                    </td>
                  </tr>
                  <tr>
                    <td>3</td>
                    <td>Modulo Muestra</td>
                    <td>
                      <button data="https://www.youtube.com/embed/ss354662niA" class="play"> ▶️ </button>
                    </td>
                  </tr>
                  <tr>
                    <td>4</td>
                    <td>Modulo de reporte</td>
                    <td>
                      <button data="https://www.youtube.com/embed/-UgtNxSUqpo"" class="play"> ▶️ </button>
                    </td>
                  </tr>
                  <tr>
                    <td>5</td>
                    <td>Modulo de Panel</td>
                    <td>
                      <button data="https://www.youtube.com/embed/Kmzpui62b1k" class="play"> ▶️ </button>
                    </td>
                  </tr>
                  <tr>
                    <td>6</td>
                    <td>Modulo de Usuario</td>
                    <td>
                      <button data="https://www.youtube.com/embed/-UgtNxSUqpo" class="play"> ▶️ </button>
                    </td>
                  </tr>
                  <tr>
                  <td>7</td>
                  <td>Otro video</td>
                  <td>
                    <button data="https://www.youtube.com/embed/-UgtNxSUqpo" class="play"> ▶️ </button>
                  </td>
                </tr>
                </tbody>
              </table>
              </div>
            </section>`;
            function initTutoriales() {
              const videoPlay = document.getElementById('video-player');
              const lista = document.getElementById("list-videos");

              function cambiarVideo(link) {
                videoPlay.setAttribute('src',link)
              }
              lista.addEventListener('click',(e)=>{
                if (e.target.classList.contains('play')) {
                  console.log("presionando")
                  cambiarVideo(e.target.getAttribute('data'))
                }
              })
            }
            setTimeout(()=>initTutoriales(),100)
        return $tutoriales;
}

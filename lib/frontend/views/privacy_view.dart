import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import 'package:google_fonts/google_fonts.dart';

class PrivacyView extends StatelessWidget {
  const PrivacyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Política de tratamiento de datos:",
                style: GoogleFonts.montserrat(
                    fontSize: 50, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  HtmlWidget(khtml),
                ],
              ),
            ),
          ],
        ));
  }
}

const khtml = """
<p><strong>POL&Iacute;TICA DE PRIVACIDAD DE EXPOSE</strong></p>
<p>Esta Pol&iacute;tica de privacidad describe c&oacute;mo se recopila, utiliza y comparte su informaci&oacute;n personal cuando hacer uso de nuestro sistema web para la gesti&oacute;n de iniciativas en la Universidad Pontificia Bolivariana.</p>
<ul>
<li><strong>&iquest;QU&Eacute; INFORMACI&Oacute;N PERSONAL RECOPILAMOS?</strong></li>
</ul>
<p>Para hacer uso de Expose recopilamos la siguiente informaci&oacute;n:</p>
<ul>
<li>Direcci&oacute;n de correo electr&oacute;nico.</li>
<li>Nombres y apellidos.</li>
<li>Fecha de nacimiento.</li>
<li>N&uacute;mero de documento.</li>
<li>Promedio ponderado (Universidad).</li>
</ul>
<p>Adem&aacute;s, a medida que navega por el Sitio o aplicaci&oacute;n m&oacute;vil, recopilamos informaci&oacute;n en formularios individuales que depender&aacute;n de las funciones de Expose que utilice.</p>
<ul>
<li><strong>&iquest;CON QU&Eacute; FINALIDAD SE TRATAN TUS DATOS?</strong></li>
</ul>
<ul>
<li>Usamos la Informaci&oacute;n suministrada a trav&eacute;s de nuestros formularios de creaci&oacute;n de cuenta para su autenticaci&oacute;n en la plataforma e identificarlo como usuario &uacute;nico en sus interacciones con otros usuarios en el sitio web, entendi&eacute;ndose como interacciones, la evaluaci&oacute;n de presentaciones, comentarios y dem&aacute;s funciones que la aplicaci&oacute;n Expose permita realizar.</li>
<li>Usamos la informaci&oacute;n personal como nombres y apellidos con el prop&oacute;sito de que pueda ser reconocido por las dem&aacute;s personas que utilizan el aplicativo y adem&aacute;s buscan contactarlo.</li>
<li>La informaci&oacute;n registrada en los diferentes formularios a los que accede como se usa para mostrarlo a usted y los usuarios que consultan los diferentes funciones que Expose ofrece.</li>
</ul>
<ul>
<li><strong>&iquest;C&Oacute;MO PROTEGEMOS TU INFORMACI&Oacute;N?</strong></li>
</ul>
<p>Utilizamos medidas t&eacute;cnicas para proteger la informaci&oacute;n que almacenamos.  Si bien implementamos salvaguardas dise&ntilde;adas para proteger su informaci&oacute;n, ning&uacute;n sistema de seguridad es impenetrable y debido a la naturaleza inherente de Internet, no podemos garantizar que la informaci&oacute;n, durante la transmisi&oacute;n a trav&eacute;s de Internet o mientras est&aacute; almacenada en nuestros sistemas o de otra manera bajo nuestro cuidado, sea absolutamente a salvo de la intrusi&oacute;n de otros.</p>
<ul>
<li><strong>HABEAS DATA</strong></li>
</ul>
<p>Si usted es un residente colombiano, se encuentra bajo los lineamientos especificados por la ley 1581 de 2012 y sobre la cual se basa el Habeas Data cuyo objetivo es proteger la intimidad personal y familiar y el buen nombre del individuo, para el principio de finalidad, usted tiene derecho a acceder a la informaci&oacute;n personal que tenemos sobre usted y solicitar que su informaci&oacute;n personal sea corregida, actualizada o eliminada. Si desea ejercer este derecho, comun&iacute;quese con nosotros a trav&eacute;s de la informaci&oacute;n de contacto que se encuentra a continuaci&oacute;n.</p>
<ul>
<li><strong>RETENCI&Oacute;N DE DATOS</strong></li>
</ul>
<p>Cuando utiliza un comentario, evaluaci&oacute;n u otra funci&oacute;n permitida por Expose, mantendremos su Informaci&oacute;n para nuestros registros a menos que y hasta que nos pida que eliminemos esta informaci&oacute;n.</p>
<ul>
<li><strong>MENORES</strong></li>
</ul>
<p>El sitio puede ser usado por personas menores de edad.</p>
<ul>
<li><strong>CONT&Aacute;CTENOS</strong></li>
</ul>
<p>Para obtener m&aacute;s informaci&oacute;n sobre nuestras pr&aacute;cticas de privacidad, si tiene alguna pregunta o si desea presentar una queja, cont&aacute;ctenos por correo electr&oacute;nico a expose.info@gmail.com</p>
""";

import 'package:expose_master/backend/classes/leaders.dart';
import 'package:expose_master/backend/providers/leaders_provider.dart';
import 'package:expose_master/backend/services/js_alert.dart';
import 'package:expose_master/frontend/shared/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LeadersView extends StatelessWidget {
  final Leader leader;
  final bool isAccepting;

  const LeadersView({Key? key, required this.leader, required this.isAccepting})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final leaders = Provider.of<LeadersProvider>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Card(
          margin: const EdgeInsets.all(15),
          color: const Color(0xffF6F6F6),
          elevation: 5,
          child: ListTile(
            leading: Image.network(
                "https://ui-avatars.com/api/?rounded=true&name=${leader.peNombres}"),
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${leader.peNombres!} ${leader.peApellidoPaterno!} ${leader.peApellidoMaterno!}",
                  style: const TextStyle(
                    fontFamily: "MontserratAlternates",
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Id estudiante: ${leader.idEstudiante}",
                  style: const TextStyle(
                    fontFamily: "MontserratAlternates",
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Correo: ${leader.idUsuarioCorreo}",
                  style: const TextStyle(
                    fontFamily: "MontserratAlternates",
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Facultad: ${leader.facNombreFacultad}",
                  style: const TextStyle(
                    fontFamily: "MontserratAlternates",
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Semestre: #${leader.semNumeroSemestre}",
                  style: const TextStyle(
                    fontFamily: "MontserratAlternates",
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
            subtitle: Padding(
              padding: const EdgeInsets.all(5),
              child: Text(
                "Promedio ponderado: ${leader.estPromedioPonderado}",
                style: const TextStyle(
                    fontFamily: "MontserratAlternates", fontSize: 15),
              ),
            ),
          ),
        ),
        const SizedBox(height: 50),
        CustomButton(
            text: isAccepting ? "Aceptar Líder" : "Rechazar Líder",
            onPressed: () {
              leaders
                  .updateLeader(leader.idEstudiante!, isAccepting ? 1 : 0)
                  .then((value) {
                if (isAccepting || value) {
                  return jsAlert("Usuario promovido exitosamente");
                }
                jsAlert("Ha ocurrido un error al promover hacia lider");
              });
            })
      ],
    );
  }
}

import 'package:expose_master/backend/classes/iniciativa.dart';
import 'package:expose_master/backend/providers/proposals_provider.dart';
import 'package:expose_master/backend/services/js_alert.dart';
import 'package:expose_master/frontend/shared/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ProposalsView extends StatelessWidget {
  final Initiative initiative;
  final bool isAccepting;

  const ProposalsView(
      {Key? key, required this.initiative, required this.isAccepting})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final proposals = Provider.of<ProposalsProvider>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Card(
          color: const Color(0xffF6F6F6),
          margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          elevation: 5,
          shadowColor: Colors.black,
          child: ListTile(
            title: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    initiative.iniNombre!,
                    style: const TextStyle(
                      fontFamily: "MontserratAlternates",
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    initiative.iniDescripcion!,
                    style: const TextStyle(
                      fontFamily: "MontserratAlternates",
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  InkWell(
                    child: Row(
                      children: const [
                        Icon(
                          Icons.link_outlined,
                          color: Colors.black,
                        ),
                        Text(
                          "Link del video: Mi Asombroso video",
                          style: TextStyle(
                            fontFamily: "MontserratAlternates",
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    onTap: () => launchUrl(Uri.parse(initiative.iniVideo!)),
                  ),
                  InkWell(
                    child: Row(
                      children: const [
                        Icon(
                          Icons.link_outlined,
                          color: Colors.black,
                        ),
                        Text(
                          "Link de las diapositivas: Mi Asombrosa presentación",
                          style: TextStyle(
                            fontFamily: "MontserratAlternates",
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    onTap: () =>
                        launchUrl(Uri.parse(initiative.iniDiapositiva!)),
                  ),
                ],
              ),
            ),
            subtitle: Text(
              "Grupo: ${initiative.gruNombre!}",
              style: const TextStyle(
                fontFamily: "MontserratAlternates",
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        const SizedBox(height: 50),
        CustomButton(
          text: isAccepting ? "Aceptar Iniciativa" : "Rechazar Iniciativa",
          onPressed: () {
            proposals
                .updateIniciative(initiative.idIniciativa!, isAccepting ? 1 : 3)
                .then((value) {
              if (value) {
                return jsAlert(isAccepting
                    ? "Iniciativa Aceptada"
                    : "Iniciativa Rechazada");
              }
              jsAlert("Ha ocurrido un error");
            });
          },
        ),
      ],
    );
  }
}

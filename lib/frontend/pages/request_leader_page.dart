// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;
import 'package:expose/backend/providers/groups_provider.dart';
import 'package:expose/backend/providers/system.dart';
import 'package:expose/frontend/shared/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RequestLeaderPage extends StatelessWidget {
  const RequestLeaderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final groupsProvider = Provider.of<GroupsProvider>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Para poder crear un grupo debes ser lider de equipo",
          style:
              GoogleFonts.montserrat(fontSize: 50, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 50),
        CustomButton(
            text: "Solicitar liderazgo",
            onPressed: () {
              switch (SystemData.studentData?.estEsLider) {
                case null:
                  js.context.callMethod(
                      "alert", ["Primero debes registrarte como estudiante"]);
                  return;
                case 0:
                  {
                    groupsProvider.requestLeader().then((v) {
                      if (v) {
                        js.context.callMethod(
                            "alert", ["Solicitud de liderazgo en progreso"]);
                        return;
                      }
                      js.context.callMethod("alert",
                          ["Ha ocurrido un error al solicitar liderazgo"]);
                    });
                  }
                  return;
                case 2:
                  js.context.callMethod("alert",
                      ["Ya tienes una solicitud de liderazgo en progreso"]);
                  return;
              }
            }),
      ],
    );
  }
}

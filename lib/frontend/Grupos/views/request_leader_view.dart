import 'package:expose_master/backend/providers/groups_provider.dart';
import 'package:expose_master/backend/services/js_alert.dart';
import 'package:expose_master/backend/services/system.dart';
import 'package:expose_master/frontend/shared/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RequestLeaderView extends StatelessWidget {
  const RequestLeaderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final groups = Provider.of<GroupsProvider>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Para poder crear un grupo debes ser lider de equipo",
          style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.w600,
              fontFamily: "MontserratAlternates"),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 50),
        CustomButton(
          text: "Solicitar liderazgo",
          onPressed: () {
            switch (SystemData.studentData!.estEsLider) {
              case 0:
                {
                  groups.requestLeader().then((v) {
                    if (v) {
                      jsAlert("Solicitud de Liderazgo en progreso");
                      return;
                    }
                    jsAlert("Ha ocurrido un error, intentalo de nuevo");
                  });
                }
                return;
              case 2:
                jsAlert("Ya tienes una solicitud de liderazgo en progreso");
                return;
            }
          },
        ),
      ],
    );
  }
}

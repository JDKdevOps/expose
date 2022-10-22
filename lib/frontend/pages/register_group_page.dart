// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;
import 'package:expose/backend/classes/groups.dart';
import 'package:expose/backend/providers/auth_provider.dart';
import 'package:expose/backend/providers/groups_provider.dart';
import 'package:expose/backend/providers/system.dart';
import 'package:expose/frontend/shared/custom_button.dart';
import 'package:expose/frontend/shared/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterGroupPage extends StatelessWidget {
  const RegisterGroupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final groupsProvider = Provider.of<GroupsProvider>(context);

    return SizedBox(
      width: 500,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CustomInput(
              onChanged: (p0) => groupsProvider.groupName = p0,
              hint: "Mi grupo asombroso",
              label: "Nombre del grupo",
              icon: Icons.group_add_outlined),
          CustomButton(
            text: "Registrarme grupo",
            onPressed: () async {
              await groupsProvider.registerGroup().then(
                (value) {
                  if (value) {
                    js.context
                        .callMethod("alert", ["Grupo creado exitosamente"]);
                    Navigator.pop(context);
                    return;
                  } else {
                    js.context.callMethod(
                        "alert", ["Hubo un error al crear un nuevo grupo"]);
                    return;
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

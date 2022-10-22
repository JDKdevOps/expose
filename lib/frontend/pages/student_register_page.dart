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

class StudentRegisterPage extends StatelessWidget {
  const StudentRegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final groupsProvider = Provider.of<GroupsProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);

    return SizedBox(
      width: 500,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CustomInput(
              onChanged: (p0) => groupsProvider.studentId = p0,
              hint: "000000000",
              label: "Id de estudiante",
              icon: Icons.numbers_outlined),
          CustomInput(
              onChanged: (p0) =>
                  groupsProvider.studentPromedio = double.tryParse(p0) ?? 0,
              maxLength: 255,
              hint: "4.5",
              label: "Promedio ponderado",
              icon: Icons.grade_outlined),
          CustomInput(
              onChanged: (p0) =>
                  groupsProvider.studentFacultad = int.tryParse(p0) ?? 0,
              hint: "Ing de sistemas e informática",
              label: "Facultad",
              icon: Icons.apartment_outlined),
          CustomInput(
            onChanged: (p0) =>
                groupsProvider.studentSemestre = int.tryParse(p0) ?? 0,
            hint: "Primer semestre",
            label: "Semestre",
            icon: Icons.present_to_all_outlined,
          ),
          CustomButton(
              text: "Registrarme como estudiante",
              onPressed: () {
                groupsProvider.registerSutent().then((value) async {
                  if (value) {
                    Navigator.pop(context);
                    await authProvider.login(
                        SystemData.userData!.idUsuarioCorreo!,
                        SystemData.userData!.usuContrasenia!);
                  } else {
                    js.context.callMethod("alert", [
                      "Hubo un error al registrarte como estudiante, intentalo de nuevo o contacta al soporte"
                    ]);
                    return;
                  }
                });
                js.context.callMethod("alert",
                    ["Fuiste registrado como estudiante exitosamente"]);
              }),
        ],
      ),
    );
  }
}

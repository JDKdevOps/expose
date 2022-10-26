import 'package:expose_master/backend/providers/auth_provider.dart';
import 'package:expose_master/backend/services/form_validators.dart';
import 'package:expose_master/backend/services/js_alert.dart';
import 'package:expose_master/frontend/shared/custom_button.dart';
import 'package:expose_master/frontend/shared/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterStudentView extends StatelessWidget {
  const RegisterStudentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    return SizedBox(
      width: 500,
      child: Form(
        key: auth.studentForm,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CustomInput(
              onChanged: (p0) => auth.studentId = p0,
              hint: "000000000",
              label: "Id de estudiante",
              icon: Icons.numbers_outlined,
              validator: FormValidators.defaultValidator,
            ),
            CustomInput(
              onChanged: (p0) =>
                  auth.studentPromedio = double.tryParse(p0) ?? 0,
              maxLength: 255,
              hint: "4.5",
              label: "Promedio ponderado",
              icon: Icons.grade_outlined,
              validator: FormValidators.defaultValidator,
            ),
            CustomInput(
              onChanged: (p0) => auth.studentFacultad = int.tryParse(p0) ?? 0,
              hint: "Ing de sistemas e informática",
              label: "Facultad",
              icon: Icons.apartment_outlined,
              validator: FormValidators.defaultValidator,
              actionButton: const Tooltip(
                textStyle: TextStyle(
                    fontFamily: "MontserratAlternates",
                    fontSize: 15,
                    color: Colors.white),
                message: """
[Escribe el numero que corresponde a tu facultad]

[1] Ingeniería de Sistemas
[2] Ingeniería Ambiental
[3] Ingeniería Civil
[4] Ingeniería Industrial
[5] Ingeniería Electrónica
[6] Ingeniería Eléctrica
[7] Ingeniería Mecánica
[8] Administración de Empresas
[9] Administración de negocios internacionales
[10] Ciencias Políticas y Gobierno
[11] Comunicación Social
[12] Derecho
[13] Diseño Gráfico
[14] Psicología

""",
                child: Icon(
                  Icons.info_outline,
                  color: Colors.black,
                ),
              ),
            ),
            CustomInput(
              onChanged: (p0) => auth.studentSemestre = int.tryParse(p0) ?? 0,
              hint: "Primer semestre",
              label: "Semestre",
              icon: Icons.present_to_all_outlined,
              validator: FormValidators.defaultValidator,
            ),
            CustomButton(
              text: "Registrarme como estudiante",
              onPressed: () {
                if (auth.studentForm.currentState?.validate() ?? false) {
                  auth.registerSutent().then(
                    (value) {
                      if (value) {
                        jsAlert(
                            "Fuiste registrado como estudiante exitosamente, vuelve a iniciar sesión para aplicar los cambios");
                        auth.logout();
                      } else {
                        return jsAlert(
                            "Hubo un error al registrarte como estudiante, intentalo de nuevo o contacta al soporte");
                      }
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

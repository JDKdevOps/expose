import 'package:expose_master/backend/providers/auth_provider.dart';
import 'package:expose_master/backend/providers/users_providers.dart';
import 'package:expose_master/backend/services/form_validators.dart';
import 'package:expose_master/backend/services/js_alert.dart';
import 'package:expose_master/backend/services/system.dart';
import 'package:expose_master/frontend/shared/custom_button.dart';
import 'package:expose_master/frontend/shared/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final users = Provider.of<UsersProvider>(context);
    final auth = Provider.of<AuthProvider>(context);
    final name =
        "${SystemData.userData!.peNombres!} ${SystemData.userData!.peApellidoPaterno!} ${SystemData.userData!.peApellidoMaterno!}";

    return Container(
      margin: const EdgeInsets.all(20),
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Perfil:",
                style: TextStyle(
                    fontFamily: "MontserratAlternates",
                    fontSize: 50,
                    fontWeight: FontWeight.bold),
              ),
              CustomButton(
                  text: "Actualizar perfil",
                  onPressed: () async {
                    if (users.editForm.currentState?.validate() ?? false) {
                      await users.updateUserData().then((value) {
                        if (value) {
                          jsAlert(
                              "Perfil actualizado, para ver los cambios vuelve a iniciar sesión");
                          return auth.logout();
                        }
                        return jsAlert("El perfil no pudo ser actualizado");
                      });
                    }
                  }),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Image.network(
                "https://ui-avatars.com/api/?rounded=true&name=$name&size=400",
                width: 150,
                height: 150,
                fit: BoxFit.contain,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name,
                        style: const TextStyle(
                            fontFamily: "MontserratAlternates",
                            fontSize: 50,
                            fontWeight: FontWeight.bold)),
                    Text(
                      "${SystemData.userData!.tipTipoUsuario!} Universidad Pontificia Bolivariana",
                      style: const TextStyle(
                          fontFamily: "MontserratAlternates",
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 50),
          Form(
            key: users.editForm,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //DATOS USUARIOS
                SizedBox(
                  width: 250,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "Datos usuario",
                        style: TextStyle(
                          fontFamily: "MontserratAlternates",
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      CustomInput(
                          readOnly: true,
                          initialValue: SystemData.userData!.idUsuarioCorreo,
                          hint: 'example@email.com',
                          label: 'Correo',
                          icon: Icons.mail_outline),
                      const SizedBox(height: 20),
                      CustomInput(
                        hint: '*****',
                        label: 'Contraseña',
                        icon: Icons.lock_outline,
                        onChanged: (p0) => users.edgClave = p0,
                        validator: FormValidators.passwordValidator,
                      ),
                      const SizedBox(height: 20),
                      CustomInput(
                        hint: '*****',
                        label: 'Confirmar contraseña',
                        icon: Icons.lock_outline,
                        onChanged: (p0) => users.edgClaveRepeat = p0,
                        validator: FormValidators.passwordValidator,
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                //DATOS PERSONALES
                SizedBox(
                  width: 250,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "Datos personales",
                        style: TextStyle(
                          fontFamily: "MontserratAlternates",
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      CustomInput(
                        initialValue: SystemData.userData!.peNombres,
                        hint: "Mi nombre",
                        label: "Nombre",
                        icon: Icons.account_box_outlined,
                        onChanged: (p0) => users.edNombre = p0,
                        validator: FormValidators.defaultValidator,
                      ),
                      const SizedBox(height: 20),
                      CustomInput(
                        initialValue: SystemData.userData!.peApellidoPaterno,
                        hint: "Mi apellido",
                        label: "Apellido paterno",
                        icon: Icons.account_box_outlined,
                        onChanged: (p0) => users.edApellidoPaterno = p0,
                        validator: FormValidators.defaultValidator,
                      ),
                      const SizedBox(height: 20),
                      CustomInput(
                        initialValue: SystemData.userData!.peApellidoMaterno,
                        hint: "Mi apellido",
                        label: "Apellido materno",
                        icon: Icons.account_box_outlined,
                        onChanged: (p0) => users.edApellidoMaterno = p0,
                        validator: FormValidators.defaultValidator,
                      ),
                      const SizedBox(height: 20),
                      CustomInput(
                        initialValue: SystemData.userData!.peFechaNacimiento,
                        hint: 'YYYY-MM-DD',
                        label: 'Fecha de nacimiento',
                        icon: Icons.date_range_outlined,
                        onChanged: (p0) => users.edFechaNacimiento = p0,
                        validator: FormValidators.dateValidator,
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                //Datos ESTUDIANTE
                SizedBox(
                  width: 250,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "Datos estudiante",
                        style: TextStyle(
                          fontFamily: "MontserratAlternates",
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      CustomInput(
                          readOnly: true,
                          initialValue:
                              SystemData.studentData?.idEstudiante.toString() ??
                                  "No registrado",
                          hint: "000000000",
                          label: "Id de estudiante",
                          icon: Icons.numbers_outlined),
                      const SizedBox(height: 20),
                      CustomInput(
                        initialValue: SystemData
                                .studentData?.estPromedioPonderado
                                .toString() ??
                            "No registrado",
                        hint: "4.5",
                        label: "Promedio ponderado",
                        icon: Icons.grade_outlined,
                        onChanged: (p0) => users.edPromedio = p0,
                        validator: FormValidators.defaultValidator,
                      ),
                      const SizedBox(height: 20),
                      CustomInput(
                        initialValue:
                            SystemData.studentData?.facNombreFacultad ??
                                "No registrado",
                        hint: "Ing de sistemas e informática",
                        label: "Facultad",
                        icon: Icons.apartment_outlined,
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
                        onChanged: (p0) => users.edFacultad = p0,
                        validator: FormValidators.defaultValidator,
                      ),
                      const SizedBox(height: 20),
                      CustomInput(
                        initialValue: SystemData.studentData?.semNumeroSemestre
                                .toString() ??
                            "No registrado",
                        hint: "Primer semestre",
                        label: "Semestre",
                        icon: Icons.present_to_all_outlined,
                        onChanged: (p0) => users.edSemestre = p0,
                        validator: FormValidators.defaultValidator,
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

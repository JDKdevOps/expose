import 'package:expose_master/backend/services/system.dart';
import 'package:expose_master/frontend/shared/custom_button.dart';
import 'package:expose_master/frontend/shared/custom_dialog.dart';
import 'package:expose_master/frontend/shared/custom_input.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                onPressed: () => showDialog(
                  context: context,
                  barrierColor: Colors.black.withOpacity(0.2),
                  builder: (_) {
                    return const CustomDialog(
                      title: "Registrarme como Estudiante",
                      content: Text("Perfil actualizado"),
                    );
                  },
                ),
              ),
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
          Row(
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
                        initialValue: SystemData.userData!.usuContrasenia,
                        hint: '*****',
                        label: 'Contraseña',
                        icon: Icons.lock_outline),
                    const SizedBox(height: 20),
                    CustomInput(
                        initialValue: SystemData.userData!.peApellidoMaterno,
                        hint: '*****',
                        label: 'Confirmar contraseña',
                        icon: Icons.lock_outline),
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
                        icon: Icons.account_box_outlined),
                    const SizedBox(height: 20),
                    CustomInput(
                        initialValue: SystemData.userData!.peApellidoPaterno,
                        hint: "Mi apellido",
                        label: "Apellido paterno",
                        icon: Icons.account_box_outlined),
                    const SizedBox(height: 20),
                    CustomInput(
                        initialValue: SystemData.userData!.peApellidoMaterno,
                        hint: "Mi apellido",
                        label: "Apellido materno",
                        icon: Icons.account_box_outlined),
                    const SizedBox(height: 20),
                    CustomInput(
                        initialValue: SystemData.userData!.peFechaNacimiento,
                        hint: 'YYYY-MM-DD',
                        label: 'Fecha de nacimiento',
                        icon: Icons.date_range_outlined),
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
                        icon: Icons.grade_outlined),
                    const SizedBox(height: 20),
                    CustomInput(
                        initialValue:
                            SystemData.studentData?.facNombreFacultad ??
                                "No registrado",
                        hint: "Ing de sistemas e informática",
                        label: "Facultad",
                        icon: Icons.apartment_outlined),
                    const SizedBox(height: 20),
                    CustomInput(
                        initialValue: SystemData.studentData?.semNumeroSemestre
                                .toString() ??
                            "No registrado",
                        hint: "Primer semestre",
                        label: "Semestre",
                        icon: Icons.present_to_all_outlined),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:expose_master/backend/classes/users.dart';
import 'package:expose_master/backend/providers/users_providers.dart';
import 'package:expose_master/backend/services/form_validators.dart';
import 'package:expose_master/backend/services/js_alert.dart';
import 'package:expose_master/frontend/shared/custom_button.dart';
import 'package:expose_master/frontend/shared/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsersInfoView extends StatelessWidget {
  final Users? user;
  final bool isEditing;

  const UsersInfoView({Key? key, this.user, required this.isEditing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final users = Provider.of<UsersProvider>(context);

    return isEditing
        ? _IsEditing(users: users, user: user!)
        : _IsRegister(users: users);
  }
}

class _IsRegister extends StatelessWidget {
  const _IsRegister({
    Key? key,
    required this.users,
  }) : super(key: key);

  final UsersProvider users;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: users.regForm,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              //DATOS USUARIOS
              SizedBox(
                width: 500,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      "Datos usuario",
                      style: TextStyle(
                        fontFamily: "MontserratAlternates",
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    CustomInput(
                      onChanged: (p0) => users.regCorreo = p0,
                      hint: 'example@email.com',
                      label: 'Correo',
                      icon: Icons.mail_outline,
                      validator: FormValidators.emailValidator,
                    ),
                    const SizedBox(height: 20),
                    CustomInput(
                      onChanged: (p0) => users.regClave = p0,
                      hint: '*****',
                      label: 'Contraseña',
                      icon: Icons.lock_outline,
                      validator: FormValidators.passwordValidator,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              //DATOS PERSONALES
              SizedBox(
                width: 500,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      "Datos personales",
                      style: TextStyle(
                        fontFamily: "MontserratAlternates",
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    CustomInput(
                      onChanged: (p0) => users.regNombre = p0,
                      hint: "Mi nombre",
                      label: "Nombre",
                      icon: Icons.account_box_outlined,
                      validator: FormValidators.defaultValidator,
                    ),
                    const SizedBox(height: 20),
                    CustomInput(
                      onChanged: (p0) => users.regApellidoPaterno = p0,
                      hint: "Mi apellido",
                      label: "Apellido paterno",
                      icon: Icons.account_box_outlined,
                      validator: FormValidators.defaultValidator,
                    ),
                    const SizedBox(height: 20),
                    CustomInput(
                      onChanged: (p0) => users.regApellidoMaterno = p0,
                      hint: "Mi apellido",
                      label: "Apellido materno",
                      icon: Icons.account_box_outlined,
                      validator: FormValidators.defaultValidator,
                    ),
                    const SizedBox(height: 20),
                    CustomInput(
                      onChanged: (p0) => users.regFechaNacimiento = p0,
                      hint: 'YYYY-MM-DD',
                      label: 'Fecha de nacimiento',
                      icon: Icons.date_range_outlined,
                      validator: FormValidators.dateValidator,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              CustomButton(
                text: "Registrar usuario",
                onPressed: () async {
                  if (users.regForm.currentState?.validate() ?? false) {
                    users.regForm.currentState?.reset();
                    await users.register(1).then(
                      (value) {
                        if (value) {
                          return jsAlert("Usuario registrado con éxito");
                        }
                        return jsAlert("No se ha podido registrar el usuario");
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _IsEditing extends StatelessWidget {
  const _IsEditing({
    Key? key,
    required this.users,
    required this.user,
  }) : super(key: key);

  final UsersProvider users;
  final Users user;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: users.getUserInfo(user.idUsuarioCorreo!),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: users.editForm,
                child: Column(
                  children: [
                    //DATOS USUARIOS
                    SizedBox(
                      width: 500,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            "Datos usuario",
                            style: TextStyle(
                              fontFamily: "MontserratAlternates",
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          CustomInput(
                              readOnly: true,
                              hint: 'example@email.com',
                              label: 'Correo',
                              icon: Icons.mail_outline),
                          const SizedBox(height: 20),
                          CustomInput(
                              hint: '*****',
                              label: 'Contraseña',
                              icon: Icons.lock_outline),
                          const SizedBox(height: 20),
                          CustomInput(
                              hint: '*****',
                              label: 'Confirmar contraseña',
                              icon: Icons.lock_outline),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                    //DATOS PERSONALES
                    SizedBox(
                      width: 500,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            "Datos personales",
                            style: TextStyle(
                              fontFamily: "MontserratAlternates",
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          CustomInput(
                              hint: "Mi nombre",
                              label: "Nombre",
                              icon: Icons.account_box_outlined),
                          const SizedBox(height: 20),
                          CustomInput(
                              hint: "Mi apellido",
                              label: "Apellido paterno",
                              icon: Icons.account_box_outlined),
                          const SizedBox(height: 20),
                          CustomInput(
                              hint: "Mi apellido",
                              label: "Apellido materno",
                              icon: Icons.account_box_outlined),
                          const SizedBox(height: 20),
                          CustomInput(
                              hint: 'YYYY-MM-DD',
                              label: 'Fecha de nacimiento',
                              icon: Icons.date_range_outlined),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                    //Datos ESTUDIANTE
                    SizedBox(
                      width: 500,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            "Datos estudiante",
                            style: TextStyle(
                              fontFamily: "MontserratAlternates",
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          CustomInput(
                              readOnly: true,
                              hint: "000000000",
                              label: "Id de estudiante",
                              icon: Icons.numbers_outlined),
                          const SizedBox(height: 20),
                          CustomInput(
                              hint: "4.5",
                              label: "Promedio ponderado",
                              icon: Icons.grade_outlined),
                          const SizedBox(height: 20),
                          CustomInput(
                              hint: "Ing de sistemas e informática",
                              label: "Facultad",
                              icon: Icons.apartment_outlined),
                          const SizedBox(height: 20),
                          CustomInput(
                              hint: "Primer semestre",
                              label: "Semestre",
                              icon: Icons.present_to_all_outlined),
                          const SizedBox(height: 20),
                          CustomButton(
                            text: "Actualizar Perfil",
                            onPressed: () {
                              jsAlert("Perfil actualizado con éxito");
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.black,
          ),
        );
      },
    );
  }
}

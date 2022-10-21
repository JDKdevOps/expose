// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;
import 'package:email_validator/email_validator.dart';
import 'package:expose/backend/providers/auth_provider.dart';
import 'package:expose/backend/router/router.dart';
import 'package:expose/backend/services/navigation_service.dart';
import 'package:expose/frontend/shared/custom_button.dart';
import 'package:expose/frontend/shared/custom_input.dart';
import 'package:expose/frontend/shared/link_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Center(
            child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            key: authProvider.registerKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //Nombre
                  CustomInput(
                      onChanged: (p0) => authProvider.regName = p0,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Escriba su nombre';
                        }
                        return null;
                      },
                      hint: 'Jhon',
                      label: 'Nombre',
                      icon: Icons.account_box_outlined),
                  const SizedBox(height: 20),
                  //Apellido Paterno
                  CustomInput(
                      onChanged: (p0) => authProvider.regApellidoPaterno = p0,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Escriba sus apellidos';
                        }
                        return null;
                      },
                      hint: 'Doe',
                      label: 'Apellido Paterno',
                      icon: Icons.account_box_outlined),
                  const SizedBox(height: 20),
                  //Apellido Materno
                  CustomInput(
                      onChanged: (p0) => authProvider.regApellidoMaterno = p0,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Escriba sus apellidos';
                        }
                        return null;
                      },
                      hint: 'Dae',
                      label: 'Apellido Materno',
                      icon: Icons.account_box_outlined),
                  const SizedBox(height: 20),
                  //Fecha de Nacimiento
                  CustomInput(
                    onChanged: (p0) => authProvider.regFechaNacimiento = p0,
                    readOnly: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Seleccione una Fecha';
                      }
                      return null;
                    },
                    hint: 'YYYY-MM-DD',
                    label: 'Fecha de nacimiento',
                    icon: Icons.date_range_outlined,
                  ),
                  const SizedBox(height: 20),
                  //Correo
                  CustomInput(
                      onChanged: (p0) => authProvider.regCorreo = p0,
                      validator: (value) {
                        if (!EmailValidator.validate(value ?? '')) {
                          return 'Email no válido';
                        }
                        return null;
                      },
                      hint: 'example@email.com',
                      label: 'Correo',
                      icon: Icons.mail_outline),
                  const SizedBox(height: 20),
                  CustomInput(
                    onChanged: (p0) => authProvider.regPasswd = p0,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ingrese su contraseña';
                      }
                      if (value.length < 6) {
                        return 'La contraseña debe ser de 6 caracteres';
                      }
                      return null;
                    },
                    obscureText: true,
                    hint: '*****',
                    label: 'Contraseña',
                    icon: Icons.lock_outline,
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    text: 'Registrarse',
                    onPressed: () {
                      authProvider.register().then((value) {
                        if (value) {
                          js.context.callMethod("alert", [
                            "Se ha registrado correctamente, ya puede ingresar al sistema"
                          ]);
                        } else {
                          js.context.callMethod("alert", [
                            "Hubo un error al registarse, verifica tu conexión a internet, estado del servicio, o si estás utilizando un correo duplicado"
                          ]);
                        }
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  LinkText(
                    text: 'Ingresar a mi cuenta',
                    onPressed: () =>
                        NavigationService.replaceTo(SystemRouter.login),
                  ),
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }
}

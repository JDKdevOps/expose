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
                  //Apellido
                  CustomInput(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Escriba sus apellidos';
                        }
                        return null;
                      },
                      hint: 'Doe',
                      label: 'Apellidos',
                      icon: Icons.account_box_outlined),
                  const SizedBox(height: 20),
                  //Fecha de Nacimiento
                  CustomInput(
                    readOnly: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Seleccione una Fecha';
                      }
                      return null;
                    },
                    hint: 'DD-MM-YY',
                    label: 'Fecha de nacimiento',
                    icon: Icons.date_range_outlined,
                    iconButton: IconButton(
                      onPressed: () async {
                        final test = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now());
                      },
                      icon: const Icon(
                        Icons.add_outlined,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  //Correo
                  CustomInput(
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
                    onPressed: () {},
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

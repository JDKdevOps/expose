import 'package:email_validator/email_validator.dart';
import 'package:expose/backend/providers/auth_provider.dart';
import 'package:expose/backend/router/router.dart';
import 'package:expose/backend/services/navigation_service.dart';
import 'package:expose/frontend/shared/custom_button.dart';
import 'package:expose/frontend/shared/custom_input.dart';
import 'package:expose/frontend/shared/link_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Center(
          child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          key: authProvider.loginKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //Correo
              CustomInput(
                  onChanged: (value) => authProvider.email = value,
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
                onChanged: (value) => authProvider.password = value,
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
                text: 'Iniciar Sesión',
                onPressed: () {
                  final isValid = authProvider.validateLogin();
                  if (isValid) {
                    authProvider.login(
                        authProvider.email, authProvider.password);
                  }
                },
              ),
              const SizedBox(height: 20),
              LinkText(
                text: 'Crear una cuenta',
                onPressed: () =>
                    NavigationService.replaceTo(SystemRouter.register),
              ),
            ],
          ),
        ),
      )),
    );
  }
}

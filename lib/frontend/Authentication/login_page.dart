import 'package:expose_master/backend/providers/auth_provider.dart';
import 'package:expose_master/backend/router/navigation_service.dart';
import 'package:expose_master/backend/router/router.dart';
import 'package:expose_master/backend/services/form_validators.dart';
import 'package:expose_master/backend/services/js_alert.dart';
import 'package:expose_master/frontend/shared/custom_button.dart';
import 'package:expose_master/frontend/shared/custom_input.dart';
import 'package:expose_master/frontend/shared/link_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final auth = Provider.of<AuthProvider>(context);

    return Container(
      margin: const EdgeInsets.all(20),
      width: double.infinity,
      height: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SvgPicture.asset(
            "imgs/pitch.svg",
            width: size.width * 0.4,
            height: size.height * 0.7,
            fit: BoxFit.contain,
          ),
          Form(
            key: auth.loginForm,
            child: SizedBox(
              width: size.width * 0.3,
              height: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Todo comienza con una idea',
                      style: TextStyle(
                        fontFamily: "MontserratAlternates",
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center),
                  const SizedBox(height: 100),
                  CustomInput(
                    hint: "example@gmail.com",
                    label: "Correo",
                    icon: Icons.email_outlined,
                    onChanged: (p0) => auth.correo = p0,
                    validator: FormValidators.emailValidator,
                  ),
                  const SizedBox(height: 50),
                  CustomInput(
                    hint: "******",
                    label: "Contraseña",
                    icon: Icons.lock_outline,
                    obscureText: true,
                    onChanged: (p0) => auth.passwd = p0,
                    validator: FormValidators.passwordValidator,
                  ),
                  const SizedBox(height: 50),
                  CustomButton(
                    text: "Iniciar Sesión",
                    onPressed: () {
                      if (auth.loginForm.currentState?.validate() ?? false) {
                        auth.login().then(
                          (value) {
                            if (value) {
                              jsAlert("Has ingresado exitosamente");
                              NavigationRouter.replaceTo(SystemRouter.dash);
                              return;
                            }
                            jsAlert(
                                "Ha ocurrido un error, revisa tus credenciales. Si crees que hay un error contáctanos al centro de ayuda");
                          },
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  LinkText(
                    text: "Crear una cuenta",
                    onPressed: () =>
                        NavigationRouter.navigateTo(SystemRouter.register),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

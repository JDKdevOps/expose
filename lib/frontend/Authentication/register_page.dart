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

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

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
            key: auth.registerForm,
            autovalidateMode: AutovalidateMode.onUserInteraction,
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
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      children: [
                        //Nombre
                        CustomInput(
                          onChanged: (p0) => auth.regName = p0,
                          validator: FormValidators.defaultValidator,
                          hint: 'Jhon',
                          label: 'Nombre',
                          icon: Icons.account_box_outlined,
                        ),
                        const SizedBox(height: 50),
                        //Apellido Paterno
                        CustomInput(
                            onChanged: (p0) => auth.regApellidoPaterno = p0,
                            validator: FormValidators.defaultValidator,
                            hint: 'Doe',
                            label: 'Apellido Paterno',
                            icon: Icons.account_box_outlined),
                        const SizedBox(height: 50),
                        //Apellido Materno
                        CustomInput(
                            onChanged: (p0) => auth.regApellidoMaterno = p0,
                            validator: FormValidators.defaultValidator,
                            hint: 'Dae',
                            label: 'Apellido Materno',
                            icon: Icons.account_box_outlined),
                        const SizedBox(height: 50),
                        //Fecha de Nacimiento
                        CustomInput(
                          onChanged: (p0) => auth.regFechaNacimiento = p0,
                          validator: FormValidators.dateValidator,
                          hint: 'YYYY-MM-DD',
                          label: 'Fecha de nacimiento',
                          icon: Icons.date_range_outlined,
                        ),
                        const SizedBox(height: 50),
                        //Correo
                        CustomInput(
                            onChanged: (p0) => auth.regCorreo = p0,
                            validator: FormValidators.emailValidator,
                            hint: 'example@email.com',
                            label: 'Correo',
                            icon: Icons.mail_outline),
                        const SizedBox(height: 50),
                        CustomInput(
                          onChanged: (p0) => auth.regPasswd = p0,
                          validator: FormValidators.passwordValidator,
                          obscureText: true,
                          hint: '*****',
                          label: 'Contraseña',
                          icon: Icons.lock_outline,
                        ),
                        const SizedBox(height: 20),
                        CheckboxListTile(
                            checkColor: Colors.white,
                            activeColor: Colors.black,
                            title: const Text(
                              "He leído y acepto las políticas de privacidad de este sitio",
                              style:
                                  TextStyle(fontFamily: "MontserratAlternates"),
                            ),
                            value: auth.policy,
                            onChanged: (_) {
                              auth.policy = !auth.policy;
                            }),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                  CustomButton(
                    text: "Registrarse",
                    onPressed: () {
                      if (auth.registerForm.currentState?.validate() ?? false) {
                        if (!auth.policy) {
                          jsAlert(
                              "Debes aceptar las políticas de privacidad y tratamiento de datos");
                          return;
                        }
                        auth.registerForm.currentState!.reset();
                        auth.register(1).then((value) {
                          if (value) {
                            return jsAlert("Registro exitoso");
                          }
                          return jsAlert(
                              "El registro ha fallado, puede que tus datos ya se encuentren registrados en el sistema");
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  LinkText(
                    text: "Iniciar sesión",
                    onPressed: () =>
                        NavigationRouter.navigateTo(SystemRouter.login),
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

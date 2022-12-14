import 'package:expose_master/backend/classes/iniciativa.dart';
import 'package:expose_master/backend/providers/auth_provider.dart';
import 'package:expose_master/backend/providers/dash_provider.dart';
import 'package:expose_master/backend/services/form_validators.dart';
import 'package:expose_master/backend/services/js_alert.dart';
import 'package:expose_master/backend/services/system.dart';
import 'package:expose_master/frontend/shared/custom_button.dart';
import 'package:expose_master/frontend/shared/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactFormView extends StatelessWidget {
  final Initiative initiative;

  const ContactFormView({Key? key, required this.initiative}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dash = Provider.of<DashProvider>(context);
    final auth = Provider.of<AuthProvider>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: dash.contactForm,
        child: Column(
          children: [
            CustomInput(
              hint: "Nombre",
              label: "Nombre del interesado",
              icon: Icons.person_outline,
              maxLength: 255,
              initialValue:
                  SystemData.userData?.idUsuarioCorreo ?? "Remitente@gmail.com",
              validator: FormValidators.emailValidator,
              readOnly: true,
            ),
            const SizedBox(height: 20),
            CustomInput(
              onChanged: (p0) => dash.asunto = p0,
              hint: "Razón de contacto",
              label: "Título del asunto",
              icon: Icons.title_outlined,
              maxLength: 255,
              validator: FormValidators.defaultValidator,
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 100,
              child: CustomInput(
                maxLines: 5,
                hint: "Mi contenido",
                label: "Contenido",
                onChanged: (p0) => dash.contenido = p0,
                validator: FormValidators.defaultValidator,
                maxLength: 255,
              ),
            ),
            if (auth.routerStatus == RouterStatus.auth) ...{
              const SizedBox(height: 20),
              CustomButton(
                text: "Enviar",
                onPressed: () => {
                  if (dash.contactForm.currentState?.validate() ?? false)
                    {
                      dash.contactForm.currentState?.reset(),
                      dash.sendInitiativeMessage(initiative.idIniciativa!).then(
                          (value) => jsAlert("Formulario enviado con éxito")),
                    }
                },
              ),
            } else ...{
              const SizedBox(height: 50),
              const Text(
                "Inicia sesión para poder contactarlos",
                style: TextStyle(
                  fontFamily: "MontserratAlternates",
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            },
          ],
        ),
      ),
    );
  }
}

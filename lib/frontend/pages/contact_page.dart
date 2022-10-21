import 'package:expose/backend/classes/iniciativa.dart';
import 'package:expose/backend/providers/initiatives_provider.dart';
import 'package:expose/backend/providers/system.dart';
import 'package:expose/frontend/shared/custom_button.dart';
import 'package:expose/frontend/shared/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactPage extends StatelessWidget {
  final Initiative initiative;

  const ContactPage({Key? key, required this.initiative}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final initiativesProvider = Provider.of<InitiativesProvider>(context);

    return Form(
      key: initiativesProvider.formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomInput(
              initialValue: "${SystemData.userData!.idUsuarioCorreo}",
              hint: "Nombre",
              label: "Nombre del interesado",
              icon: Icons.person_outline,
              maxLength: 255),
          const SizedBox(height: 20),
          CustomInput(
            onChanged: (p0) => initiativesProvider.titulo = p0,
            hint: "Razón de contacto",
            label: "Título del asunto",
            icon: Icons.title_outlined,
            maxLength: 255,
          ),
          const SizedBox(height: 20),
          CustomInput(
            onChanged: (p0) => initiativesProvider.contenido = p0,
            hint: "Contenido",
            label: "Escribe tus dudas",
            icon: Icons.document_scanner_outlined,
            maxLength: 255,
          ),
          const SizedBox(height: 20),
          CustomButton(
              text: "Enviar",
              onPressed: () => initiativesProvider
                  .sendInitiativeMessage(initiative.idIniciativa!))
        ],
      ),
    );
  }
}

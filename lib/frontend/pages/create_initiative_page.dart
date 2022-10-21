// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;
import 'package:expose/backend/classes/groups.dart';
import 'package:expose/backend/providers/groups_provider.dart';
import 'package:expose/frontend/shared/custom_button.dart';
import 'package:expose/frontend/shared/custom_input.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateInitiativePage extends StatelessWidget {
  final Group group;

  const CreateInitiativePage({Key? key, required this.group}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final groupsProvider = Provider.of<GroupsProvider>(context);
    final fileController = TextEditingController();

    return SizedBox(
      width: 500,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CustomInput(
              onChanged: (p0) => groupsProvider.nombreInitiative = p0,
              hint: "Mi gran idea",
              label: "Nombre de la iniciativa",
              icon: Icons.handshake_outlined),
          CustomInput(
              onChanged: (p0) => groupsProvider.descInitiative = p0,
              maxLength: 255,
              hint: "Mi descripción",
              label: "Descripción",
              icon: Icons.data_array_outlined),
          CustomInput(
              onChanged: (p0) => groupsProvider.videoInitiative = p0,
              hint: "Mi gran video",
              label: "Link del video (youtube)",
              icon: Icons.video_call_outlined),
          CustomInput(
            readOnly: true,
            controller: fileController,
            hint: "Mi gran presentación",
            label: "Diapositivas",
            icon: Icons.present_to_all_outlined,
            iconButton: IconButton(
              icon: const Icon(
                Icons.file_present_outlined,
                color: Colors.black,
              ),
              onPressed: () async {
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                    type: FileType.custom, allowedExtensions: ["pdf", "pptx"]);
                if (result != null) {
                  groupsProvider.initiativeFile = result.files.single.bytes!;
                  groupsProvider.fileName = result.files.single.name;
                  fileController.text = groupsProvider.fileName;
                }
              },
            ),
          ),
          CustomButton(
              text: "Registrar Iniciativa",
              onPressed: () {
                groupsProvider.addInitiative(group.idGrupo!).then((value) {
                  js.context.callMethod("alert", [
                    "La iniciativa fue creada exitosamente y enviada a revisión"
                  ]);
                  Navigator.pop(context);
                });
              }),
        ],
      ),
    );
  }
}

import 'package:expose_master/backend/classes/groups.dart';
import 'package:expose_master/backend/providers/groups_provider.dart';
import 'package:expose_master/backend/services/form_validators.dart';
import 'package:expose_master/backend/services/js_alert.dart';
import 'package:expose_master/frontend/shared/custom_button.dart';
import 'package:expose_master/frontend/shared/custom_input.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewInitiativeView extends StatelessWidget {
  final Group group;

  const NewInitiativeView({Key? key, required this.group}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final groups = Provider.of<GroupsProvider>(context);

    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: groups.newInitiativeKey,
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            children: [
              CustomInput(
                hint: "Mi gran idea",
                label: "Nombre de la iniciativa",
                icon: Icons.co_present_outlined,
                maxLength: 255,
                onChanged: (p0) => groups.nombreInitiative = p0,
                validator: FormValidators.defaultValidator,
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 100,
                child: CustomInput(
                  onChanged: (p0) => groups.descInitiative = p0,
                  maxLength: 255,
                  hint: "Mi descripción",
                  label: "Descripción",
                  maxLines: 5,
                  icon: Icons.data_array_outlined,
                  validator: FormValidators.defaultValidator,
                ),
              ),
              const SizedBox(height: 20),
              CustomInput(
                onChanged: (p0) => groups.videoInitiative = p0,
                hint: "Mi gran video",
                label: "Link del video (youtube)",
                icon: Icons.video_call_outlined,
                validator: FormValidators.defaultValidator,
              ),
              const SizedBox(height: 20),
              CustomInput(
                readOnly: true,
                controller: groups.fileController,
                hint: "Mi gran presentación",
                label: "Diapositivas",
                icon: Icons.present_to_all_outlined,
                validator: FormValidators.defaultValidator,
                actionButton: IconButton(
                  icon: const Icon(
                    Icons.file_present_outlined,
                    color: Colors.black,
                  ),
                  onPressed: () async {
                    FilePickerResult? result = await FilePicker.platform
                        .pickFiles(
                            type: FileType.custom,
                            allowedExtensions: ["pdf", "pptx"]);
                    if (result != null) {
                      groups.initiativeFile = result.files.single.bytes!;
                      groups.fileName = result.files.single.name;
                      groups.fileController.text = groups.fileName;
                    }
                  },
                ),
              ),
              const SizedBox(height: 20),
              CustomButton(
                text: "Registrar",
                onPressed: () => {
                  if (groups.newInitiativeKey.currentState?.validate() ?? false)
                    {
                      groups.newInitiativeKey.currentState?.reset(),
                      groups.addInitiative(group.idGrupo!).then(
                          (_) => jsAlert("Iniciativa creada exitosamente")),
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

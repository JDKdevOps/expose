import 'package:expose_master/backend/providers/groups_provider.dart';
import 'package:expose_master/backend/services/form_validators.dart';
import 'package:expose_master/backend/services/js_alert.dart';
import 'package:expose_master/frontend/shared/custom_button.dart';
import 'package:expose_master/frontend/shared/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateGroupView extends StatelessWidget {
  const CreateGroupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final groups = Provider.of<GroupsProvider>(context);

    return SizedBox(
      width: 500,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
            key: groups.createGroupForm,
            child: CustomInput(
              onChanged: (p0) => groups.groupName = p0,
              hint: "Mi grupo asombroso",
              label: "Nombre del grupo",
              icon: Icons.group_add_outlined,
              validator: FormValidators.defaultValidator,
            ),
          ),
          const SizedBox(height: 50),
          CustomButton(
            text: "Registrar grupo",
            onPressed: () async {
              if (groups.createGroupForm.currentState?.validate() ?? false) {
                groups.createGroupForm.currentState!.reset();
                await groups.registerGroup().then(
                  (value) {
                    if (value) {
                      jsAlert("Grupo creado exitosamente");

                      return;
                    } else {
                      jsAlert("Hubo un error al crear el grupo");
                      return;
                    }
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

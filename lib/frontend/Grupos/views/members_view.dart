import 'package:expose_master/backend/classes/groups.dart';
import 'package:expose_master/backend/providers/groups_provider.dart';
import 'package:expose_master/backend/services/form_validators.dart';
import 'package:expose_master/backend/services/js_alert.dart';
import 'package:expose_master/backend/services/system.dart';
import 'package:expose_master/frontend/shared/custom_button.dart';
import 'package:expose_master/frontend/shared/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MembersView extends StatelessWidget {
  final Group group;

  const MembersView({Key? key, required this.group}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final groups = Provider.of<GroupsProvider>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (group.lider == SystemData.studentData!.idEstudiante) ...{
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 400,
                  child: Form(
                    key: groups.miembrosForm,
                    child: CustomInput(
                      hint: "Miembro",
                      label: "Agregar miembro",
                      icon: Icons.person_add_outlined,
                      onChanged: (p0) => groups.addMiembro = p0,
                      validator: FormValidators.defaultValidator,
                    ),
                  ),
                ),
                CustomButton(
                  text: "Añadir miembro",
                  onPressed: () {
                    if (groups.miembrosForm.currentState?.validate() ?? false) {
                      groups
                          .addMember(group.idGrupo!,
                              int.tryParse(groups.addMiembro) ?? 0)
                          .then((value) {
                        if (value) {
                          jsAlert(
                              "${groups.addMiembro} ha sido añadido al grupo");
                          return;
                        }
                        jsAlert("No se ha podido añadir el miembro al grupo");
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        },
        SizedBox(
          width: 700,
          height: 300,
          child: FutureBuilder(
            future: groups.getMembers(group.idGrupo!),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                groups.miembros = snapshot.data!;
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final data = snapshot.data![index];
                    final name =
                        "${data.peNombres!} ${data.peApellidoPaterno!} ${data.peApellidoMaterno!}";
                    return Card(
                      color: const Color(0xffF6F6F6),
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      elevation: 5,
                      shadowColor: Colors.black,
                      child: ListTile(
                        leading: Image.network(
                            "https://ui-avatars.com/api/?rounded=true&name=$name"),
                        title: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name,
                                style: const TextStyle(
                                  fontFamily: "MontserratAlternates",
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                data.idEstudiante!.toString(),
                                style: const TextStyle(
                                  fontFamily: "MontserratAlternates",
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                        trailing: group.lider ==
                                    SystemData.studentData!.idEstudiante &&
                                data.idEstudiante! !=
                                    SystemData.studentData!.idEstudiante
                            ? IconButton(
                                onPressed: () {
                                  groups
                                      .removeMember(
                                          group.idGrupo!, data.idEstudiante!)
                                      .then((_) {
                                    jsAlert(
                                        "$name ha sido removido del grupo exitosamente");
                                  });
                                },
                                icon: Icon(
                                  Icons.remove_circle_outline,
                                  color: Colors.red[300],
                                ))
                            : null,
                      ),
                    );
                  },
                );
              }
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

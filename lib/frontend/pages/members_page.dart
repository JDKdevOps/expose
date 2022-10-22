// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;
import 'package:expose/backend/classes/groups.dart';
import 'package:expose/backend/providers/groups_provider.dart';
import 'package:expose/backend/providers/system.dart';
import 'package:expose/frontend/shared/custom_button.dart';
import 'package:expose/frontend/shared/custom_input.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MembersPage extends StatelessWidget {
  final Group group;

  const MembersPage({Key? key, required this.group}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final groupsProvider = Provider.of<GroupsProvider>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (group.lider == SystemData.studentData!.idEstudiante) ...{
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 500,
                  child: CustomInput(
                    hint: "Miembro",
                    label: "Agregar miembro",
                    icon: Icons.person_add_outlined,
                    onChanged: (p0) => groupsProvider.addMiembro = p0,
                  ),
                ),
                CustomButton(
                    text: "Añadir miembro",
                    onPressed: () {
                      groupsProvider
                          .addMember(group.idGrupo!,
                              int.tryParse(groupsProvider.addMiembro) ?? 0)
                          .then((value) {
                        if (value) {
                          js.context.callMethod("alert", [
                            "${groupsProvider.addMiembro} ha sido añadido al grupo exitosamente"
                          ]);
                          return;
                        }
                        js.context.callMethod("alert",
                            ["No se ha podido añadir el miembro al grupo"]);
                      });
                    }),
              ],
            ),
          ),
        },
        SizedBox(
          width: 700,
          height: 300,
          child: FutureBuilder(
            future: groupsProvider.getMembers(group.idGrupo!),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                groupsProvider.miembros = snapshot.data!;
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
                                style: GoogleFonts.roboto(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                data.idEstudiante!.toString(),
                                style: GoogleFonts.roboto(
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal),
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
                                  groupsProvider
                                      .removeMember(
                                          group.idGrupo!, data.idEstudiante!)
                                      .then((_) {
                                    js.context.callMethod("alert", [
                                      "$name ha sido removido del grupo exitosamente"
                                    ]);
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
              } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "empty.svg",
                      fit: BoxFit.contain,
                      width: 200,
                      height: 200,
                    ),
                    const SizedBox(height: 50),
                    Text(
                      "Soñar en equipo te llevará mas alto",
                      style: GoogleFonts.montserrat(
                          fontSize: 35, fontWeight: FontWeight.bold),
                    ),
                  ],
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

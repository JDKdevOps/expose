import 'package:expose_master/backend/providers/groups_provider.dart';
import 'package:expose_master/backend/services/js_alert.dart';
import 'package:expose_master/backend/services/system.dart';
import 'package:expose_master/frontend/Grupos/views/create_group_view.dart';
import 'package:expose_master/frontend/Grupos/views/inbox_view.dart';
import 'package:expose_master/frontend/Grupos/views/initiatives_group_view.dart';
import 'package:expose_master/frontend/Grupos/views/members_view.dart';
import 'package:expose_master/frontend/Grupos/views/new_initiative_view.dart';
import 'package:expose_master/frontend/Grupos/views/register_student_view.dart';
import 'package:expose_master/frontend/Grupos/views/request_leader_view.dart';
import 'package:expose_master/frontend/shared/custom_button.dart';
import 'package:expose_master/frontend/shared/custom_card.dart';
import 'package:expose_master/frontend/shared/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class GroupsPage extends StatelessWidget {
  const GroupsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final groups = Provider.of<GroupsProvider>(context);

    return Container(
      margin: const EdgeInsets.all(20),
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Grupos:",
                  style: TextStyle(
                    fontFamily: "MontserratAlternates",
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              CustomButton(
                text: SystemData.userData!.tipTipoUsuario != "Estudiante"
                    ? "Registrarme como Estudiante"
                    : "Crear nuevo grupo",
                onPressed: () {
                  if (SystemData.userData!.tipTipoUsuario != "Estudiante") {
                    return showDialog(
                      context: context,
                      builder: (context) => const CustomDialog(
                        title: "Registrarme como studiante",
                        content: RegisterStudentView(),
                      ),
                    );
                  } else if (SystemData.studentData!.estEsLider != 1) {
                    return showDialog(
                      context: context,
                      builder: (context) => const CustomDialog(
                        title: "Solicitar liderazgo",
                        content: RequestLeaderView(),
                      ),
                    );
                  }
                  showDialog(
                    context: context,
                    builder: (context) => const CustomDialog(
                      title: "Nuevo grupo",
                      content: CreateGroupView(),
                    ),
                  );
                },
              ),
            ],
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: FutureBuilder(
                    future: groups.getGroups(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                        return Center(
                          child: SingleChildScrollView(
                            child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.start,
                              direction: Axis.horizontal,
                              children: [
                                ...snapshot.data!.map(
                                  (e) => CustomCard(
                                    width: 350,
                                    height: 80,
                                    title: e.gruNombre!,
                                    assetImg: "imgs/group.svg",
                                    options: CustomOptions(
                                      options: [
                                        //Crear iniciativas
                                        if (e.lider ==
                                            SystemData
                                                .studentData!.idEstudiante) ...{
                                          OptionProps(
                                            title: "Nueva Iniciativa",
                                            icon: Icons.push_pin_outlined,
                                            content:
                                                NewInitiativeView(group: e),
                                          ),
                                        },
                                        //Ver iniciativas del Grupo
                                        OptionProps(
                                          title: "Nuestras Iniciativas",
                                          icon: Icons.co_present_outlined,
                                          content:
                                              InitiativesGroupView(group: e),
                                        ),
                                        //Ver miembros del grupo
                                        OptionProps(
                                          title: "Mis Compañeros",
                                          icon: Icons.groups_outlined,
                                          content: MembersView(group: e),
                                        ),
                                        //Ver buzón del grupo
                                        OptionProps(
                                          title: "Mensajes de Contacto",
                                          icon: Icons.email_outlined,
                                          content: InboxView(group: e),
                                        ),
                                      ],
                                    ),
                                    extraOptions:
                                        SystemData.studentData!.idEstudiante ==
                                                e.lider
                                            ? Align(
                                                alignment: Alignment.center,
                                                child: CustomButton(
                                                  text: "Eliminar Grupo",
                                                  onPressed: () => groups
                                                      .deleteGroup(e.idGrupo!)
                                                      .then((value) => jsAlert(
                                                          "Grupo desactivado exitosamente")),
                                                ),
                                              )
                                            : null,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                        return SizedBox(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "imgs/empty.svg",
                                fit: BoxFit.contain,
                                width: 300,
                                height: 300,
                              ),
                              const SizedBox(height: 50),
                              const Text(
                                "Más ideas vienen en camino",
                                style: TextStyle(
                                  fontFamily: "MontserratAlternates",
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(color: Colors.black),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

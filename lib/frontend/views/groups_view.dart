import 'package:expose/backend/providers/groups_provider.dart';
import 'package:expose/backend/providers/system.dart';
import 'package:expose/frontend/pages/register_group_page.dart';
import 'package:expose/frontend/pages/request_leader_page.dart';
import 'package:expose/frontend/pages/student_register_page.dart';
import 'package:expose/frontend/shared/custom_button.dart';
import 'package:expose/frontend/shared/custom_dialog.dart';
import 'package:expose/frontend/shared/groups_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class GroupsView extends StatelessWidget {
  const GroupsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final groupsProvider = Provider.of<GroupsProvider>(context);
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Grupos:",
                  style: GoogleFonts.montserrat(
                      fontSize: 50, fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (SystemData.userData!.tipTipoUsuario != "Estudiante") ...{
                    CustomButton(
                      text: "Unirme a un Grupo",
                      onPressed: () => showDialog(
                        context: context,
                        barrierColor: Colors.black.withOpacity(0.2),
                        builder: (_) {
                          return const CustomDialog(
                              title: "Registrarme como Estudiante",
                              content: StudentRegisterPage());
                        },
                      ),
                    ),
                  },
                  const SizedBox(width: 20),
                  CustomButton(
                    text: "Crear Grupo",
                    onPressed: () {
                      if (SystemData.studentData?.estEsLider == 1) {
                        showDialog(
                          context: context,
                          barrierColor: Colors.black.withOpacity(0.2),
                          builder: (_) {
                            return const CustomDialog(
                              title: "Nuestras iniciativas",
                              content: RegisterGroupPage(),
                            );
                          },
                        );
                        return;
                      }
                      showDialog(
                        context: context,
                        barrierColor: Colors.black.withOpacity(0.2),
                        builder: (_) {
                          return const CustomDialog(
                            content: RequestLeaderPage(),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          Expanded(
            child: Center(
              child: FutureBuilder(
                future: groupsProvider.getGroups(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    return SingleChildScrollView(
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.start,
                        direction: Axis.horizontal,
                        children: [
                          ...snapshot.data!.map(
                            (e) => GroupsCard(
                              group: e,
                              width: 400,
                              height: 125,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  if (snapshot.hasData && snapshot.data!.isEmpty) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "empty.svg",
                          fit: BoxFit.contain,
                          width: 300,
                          height: 300,
                        ),
                        const SizedBox(height: 50),
                        Text(
                          "Tu emprendimiento empieza aquí",
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
          ),
        ],
      ),
    );
  }
}

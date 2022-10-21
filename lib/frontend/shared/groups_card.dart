import 'package:expose/backend/classes/groups.dart';
import 'package:expose/backend/providers/system.dart';
import 'package:expose/frontend/pages/create_initiative_page.dart';
import 'package:expose/frontend/pages/inbox_page.dart';
import 'package:expose/frontend/pages/members_page.dart';
import 'package:expose/frontend/pages/multi_initiatives_page.dart';
import 'package:expose/frontend/shared/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class GroupsCard extends StatelessWidget {
  final Group group;
  final double? width;
  final double? height;

  const GroupsCard({
    Key? key,
    this.width,
    this.height,
    required this.group,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(10),
      decoration: buildBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedBox(
            fit: BoxFit.contain,
            child: Text(
              group.gruNombre!,
              style:
                  GoogleFonts.roboto(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          const Divider(),
          Align(
            alignment: Alignment.center,
            child: SvgPicture.asset(
              "group.svg",
              height: height,
              fit: BoxFit.cover,
            ),
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              if (group.lider == SystemData.studentData!.idEstudiante) ...{
                IconButton(
                  icon: const Icon(
                    Icons.push_pin_outlined,
                    color: Colors.black,
                  ),
                  onPressed: () => showDialog(
                    context: context,
                    barrierColor: Colors.black.withOpacity(0.2),
                    builder: (_) {
                      return CustomDialog(
                        title: "Nueva Iniciativa",
                        content: CreateInitiativePage(group: group),
                      );
                    },
                  ),
                ),
              },
              IconButton(
                onPressed: () => showDialog(
                  context: context,
                  barrierColor: Colors.black.withOpacity(0.2),
                  builder: (_) {
                    return CustomDialog(
                      title: "Nuestras iniciativas",
                      content: MultiInitiativesPage(group: group),
                    );
                  },
                ),
                icon: const Icon(
                  Icons.info_outline,
                  color: Colors.black,
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.group_outlined,
                  color: Colors.black,
                ),
                onPressed: () => showDialog(
                  context: context,
                  barrierColor: Colors.black.withOpacity(0.2),
                  builder: (_) {
                    return CustomDialog(
                      title: "Miembros",
                      content: MembersPage(group: group),
                    );
                  },
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.mail_outline,
                  color: Colors.black,
                ),
                onPressed: () => showDialog(
                  context: context,
                  barrierColor: Colors.black.withOpacity(0.2),
                  builder: (_) {
                    return CustomDialog(
                      title: "Buzón de contacto",
                      content: InboxPage(group: group),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5)
          ]);
}

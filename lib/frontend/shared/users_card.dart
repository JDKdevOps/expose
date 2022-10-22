// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;
import 'package:expose/backend/classes/iniciativa.dart';
import 'package:expose/backend/classes/leaders.dart';
import 'package:expose/backend/classes/users.dart';
import 'package:expose/backend/providers/leaders_provider.dart';
import 'package:expose/backend/providers/users_provider.dart';
import 'package:expose/frontend/pages/comments_page.dart';
import 'package:expose/frontend/pages/contact_page.dart';
import 'package:expose/frontend/pages/rating_page.dart';
import 'package:expose/frontend/shared/custom_dialog.dart';
import 'package:expose/frontend/pages/initiative_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class UsersCard extends StatelessWidget {
  final Users user;
  final double? width;
  final double? height;

  const UsersCard({
    Key? key,
    this.width,
    this.height,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final usersProvider = Provider.of<UsersProvider>(context);

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
              user.idUsuarioCorreo!,
              style:
                  GoogleFonts.roboto(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          const Divider(),
          Align(
            alignment: Alignment.center,
            child: SvgPicture.asset(
              "initiative.svg",
              height: height,
              fit: BoxFit.cover,
            ),
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  if (user.fkIdEstado == 1) {
                    js.context.callMethod(
                        "alert", ["Este usuario ya se encuentra activado"]);
                    return;
                  }
                  usersProvider.updateUser(user.idUsuarioCorreo!, 1).then((_) =>
                      js.context
                          .callMethod("alert", ["Usuario activado con éxito"]));
                },
                icon: const Icon(
                  Icons.add_box_outlined,
                  color: Colors.black,
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.do_disturb_on_outlined,
                  color: Colors.black,
                ),
                onPressed: () {
                  if (user.fkIdEstado == 4) {
                    js.context.callMethod(
                        "alert", ["Este usuario ya se encuentra desactivado"]);
                    return;
                  }
                  usersProvider.updateUser(user.idUsuarioCorreo!, 4).then((_) =>
                      js.context.callMethod(
                          "alert", ["Usuario desactivado con éxito"]));
                },
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

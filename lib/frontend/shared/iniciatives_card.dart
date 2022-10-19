import 'package:expose/backend/classes/iniciativa.dart';
import 'package:expose/frontend/pages/comments_page.dart';
import 'package:expose/frontend/pages/contact_page.dart';
import 'package:expose/frontend/pages/rating_page.dart';
import 'package:expose/frontend/shared/custom_dialog.dart';
import 'package:expose/frontend/pages/iniciative_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class IniciativesCard extends StatelessWidget {
  final Initiatives initiative;
  final int initiativeId;
  final double? width;
  final double? height;

  const IniciativesCard({
    Key? key,
    this.width,
    this.height,
    required this.initiative,
    required this.initiativeId,
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
              initiative.iniNombre!,
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
                onPressed: () => showDialog(
                  context: context,
                  barrierColor: Colors.black.withOpacity(0.2),
                  builder: (_) {
                    return CustomDialog(
                      title: initiative.iniNombre!,
                      content: IniciativesPage(
                        initiative: initiative,
                      ),
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
                  Icons.star_border_outlined,
                  color: Colors.black,
                ),
                onPressed: () => showDialog(
                  context: context,
                  barrierColor: Colors.black.withOpacity(0.2),
                  builder: (_) {
                    return CustomDialog(
                      content: RatingPage(initiative: initiative),
                    );
                  },
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.comment_outlined,
                  color: Colors.black,
                ),
                onPressed: () => showDialog(
                  context: context,
                  barrierColor: Colors.black.withOpacity(0.2),
                  builder: (_) {
                    return CustomDialog(
                      title: "Comentarios",
                      content: CommentsPage(initiative: initiative),
                    );
                  },
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.contact_phone_outlined,
                  color: Colors.black,
                ),
                onPressed: () => showDialog(
                  context: context,
                  barrierColor: Colors.black.withOpacity(0.2),
                  builder: (_) {
                    return CustomDialog(
                      title: "Formulario de Contacto",
                      content: ContactPage(initiative: initiative),
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

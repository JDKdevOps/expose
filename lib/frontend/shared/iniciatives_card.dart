import 'package:expose/frontend/shared/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class IniciativesCard extends StatelessWidget {
  final String? title;
  final Widget child;
  final double? width;
  final double? height;
  final Function? onPressed;

  const IniciativesCard({
    Key? key,
    required this.child,
    this.title,
    this.width,
    this.height,
    this.onPressed,
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
          if (title != null) ...[
            FittedBox(
              fit: BoxFit.contain,
              child: Text(
                title!,
                style: GoogleFonts.roboto(
                    fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            const Divider()
          ],
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
                    builder: (_) =>
                        CustomDialog(title: "Descripción", content: "xd")),
                icon: Icon(
                  Icons.info_outline,
                  color: Colors.black,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.star_border_outlined,
                  color: Colors.black,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.comment_outlined,
                  color: Colors.black,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.contact_phone_outlined,
                  color: Colors.black,
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

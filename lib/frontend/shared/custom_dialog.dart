import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final Widget content;

  const CustomDialog({Key? key, required this.title, required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Text(
          title,
          style: GoogleFonts.roboto(fontSize: 40, fontWeight: FontWeight.bold),
        ),
      ),
      content: Container(
        alignment: Alignment.center,
        width: 700,
        height: 400,
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(10),
          child: content,
        )),
      ),
    );
  }
}

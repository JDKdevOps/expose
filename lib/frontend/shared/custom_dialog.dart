import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String? title;
  final Widget content;

  const CustomDialog({Key? key, this.title, required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title != null
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                title!,
                style: const TextStyle(
                  fontFamily: "MontserratAlternates",
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            )
          : null,
      content: Container(
        alignment: Alignment.topCenter,
        width: 700,
        height: 400,
        child: content,
      ),
    );
  }
}

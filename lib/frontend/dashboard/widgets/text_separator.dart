import 'package:flutter/material.dart';

class TextSeparator extends StatelessWidget {
  final String text;

  const TextSeparator({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      margin: const EdgeInsets.only(bottom: 5),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: "MontserratAlternates",
          color: Colors.white.withOpacity(0.6),
          fontSize: 12,
        ),
      ),
    );
  }
}

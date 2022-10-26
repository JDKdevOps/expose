import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 30),
      child: const Text(
        "Expose",
        style: TextStyle(
            fontFamily: "MontserratAlternates",
            fontSize: 35,
            fontWeight: FontWeight.w500,
            color: Colors.white),
        textAlign: TextAlign.center,
      ),
    );
  }
}

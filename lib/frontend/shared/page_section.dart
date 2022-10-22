import 'package:flutter/material.dart';

class PageSection extends StatelessWidget {
  final String? title;
  final String content;

  const PageSection({Key? key, this.title, required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...{
            Text(
              title!,
              style: const TextStyle(
                fontFamily: "MontserratAlternates",
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            const SizedBox(height: 20),
          },
          Text(
            content,
            style: const TextStyle(
              fontFamily: "MontserratAlternates",
              fontWeight: FontWeight.normal,
              fontSize: 25,
            ),
          ),
        ],
      ),
    );
  }
}

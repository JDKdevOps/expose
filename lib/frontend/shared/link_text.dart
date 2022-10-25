import 'package:flutter/material.dart';

class LinkText extends StatefulWidget {
  final Color? color;
  final String text;
  final Function? onPressed;

  const LinkText({Key? key, required this.text, this.onPressed, this.color})
      : super(key: key);

  @override
  State<LinkText> createState() => _LinkTextState();
}

class _LinkTextState extends State<LinkText> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onPressed != null ? widget.onPressed!() : null,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => isHover = true),
        onExit: (_) => setState(() => isHover = false),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Text(
            widget.text,
            style: TextStyle(
                fontFamily: "MontserratAlternates",
                fontSize: 16,
                color: widget.color ?? Colors.grey[700],
                decoration:
                    isHover ? TextDecoration.underline : TextDecoration.none),
          ),
        ),
      ),
    );
  }
}

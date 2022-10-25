import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final Function onPressed;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onHover: (value) => setState(() => isHover = value),
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        side: MaterialStateProperty.all(
          const BorderSide(color: Colors.black),
        ),
        backgroundColor: MaterialStateProperty.all(
            isHover ? Colors.transparent : Colors.black),
      ),
      onPressed: () => widget.onPressed(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Text(
          widget.text,
          style: TextStyle(
            fontFamily: "MontserratAlternates",
            color: isHover ? Colors.black : Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomInput extends StatelessWidget {
  final String hint;
  final String label;
  final bool? obscureText;
  final IconData icon;
  final IconButton? iconButton;
  final String? initialValue;
  final bool? readOnly;
  final int? maxLength;
  final TextInputFormatter? inputFormatter;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  const CustomInput(
      {Key? key,
      required this.hint,
      required this.label,
      this.obscureText,
      required this.icon,
      this.iconButton,
      this.initialValue,
      this.readOnly,
      this.maxLength,
      this.inputFormatter,
      this.validator,
      this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly ?? false,
      maxLength: maxLength,
      initialValue: initialValue,
      obscureText: obscureText ?? false,
      onChanged: onChanged,
      validator: validator,
      inputFormatters: inputFormatter != null ? [inputFormatter!] : null,
      decoration: inputDecoration(
          hint: hint, label: label, icon: icon, iconButton: iconButton),
    );
  }
}

InputDecoration inputDecoration(
        {required String hint,
        required String label,
        required IconData icon,
        IconButton? iconButton}) =>
    InputDecoration(
      border: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.black,
        ),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.black,
        ),
      ),
      disabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.black,
        ),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          width: 2,
          color: Colors.black,
        ),
      ),
      hintText: hint,
      labelText: label,
      prefixIcon: Icon(
        icon,
        color: Colors.black54,
      ),
      suffixIcon: iconButton,
      hintStyle: const TextStyle(color: Colors.black54),
      labelStyle: const TextStyle(
        color: Colors.black54,
      ),
    );

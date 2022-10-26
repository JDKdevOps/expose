import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomInput extends StatelessWidget {
  final TextEditingController? controller;
  final String hint;
  final String label;
  final bool? obscureText;
  final IconData? icon;
  final Widget? actionButton;
  final String? initialValue;
  final bool? readOnly;
  final int? maxLength;
  final int? maxLines;
  final TextInputFormatter? inputFormatter;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  const CustomInput(
      {Key? key,
      required this.hint,
      required this.label,
      this.obscureText,
      this.icon,
      this.actionButton,
      this.initialValue,
      this.readOnly,
      this.maxLength,
      this.maxLines,
      this.inputFormatter,
      this.validator,
      this.onChanged,
      this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly ?? false,
      maxLength: maxLength,
      maxLines: maxLines ?? 1,
      initialValue: initialValue,
      obscureText: obscureText ?? false,
      onChanged: onChanged,
      validator: validator,
      inputFormatters: inputFormatter != null ? [inputFormatter!] : null,
      decoration: inputDecoration(
          hint: hint, label: label, icon: icon, actionButton: actionButton),
    );
  }
}

InputDecoration inputDecoration(
        {required String hint,
        required String label,
        IconData? icon,
        Widget? actionButton}) =>
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
      prefixIcon: icon != null
          ? Icon(
              icon,
              color: Colors.black54,
            )
          : null,
      suffixIcon: actionButton,
      hintStyle: const TextStyle(color: Colors.black54),
      labelStyle: const TextStyle(
        color: Colors.black54,
      ),
    );

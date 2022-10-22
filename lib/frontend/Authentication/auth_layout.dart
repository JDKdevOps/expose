import 'package:flutter/material.dart';

class AuthLayout extends StatelessWidget {
  final Widget widget;

  const AuthLayout({Key? key, required this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget,
    );
  }
}

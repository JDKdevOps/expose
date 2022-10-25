import 'package:flutter/material.dart';

class DashLayout extends StatelessWidget {
  final Widget widget;

  const DashLayout({Key? key, required this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xffEDF1F2),
    );
  }
}

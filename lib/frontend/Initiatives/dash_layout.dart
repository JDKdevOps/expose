import 'package:expose_master/frontend/Initiatives/widgets/sidebar.dart';
import 'package:flutter/material.dart';

class DashLayout extends StatelessWidget {
  final Widget widget;

  const DashLayout({Key? key, required this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEDF1F2),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Row(
          children: [
            const Sidebar(),
            Expanded(child: widget),
          ],
        ),
      ),
    );
  }
}

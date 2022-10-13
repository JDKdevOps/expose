import 'package:expose/backend/providers/system.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(SystemData.userData!.idUsuarioCorreo!),
      ),
    );
  }
}

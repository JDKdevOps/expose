import 'package:expose/backend/providers/system.dart';
import 'package:flutter/material.dart';

class GroupsView extends StatelessWidget {
  const GroupsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(SystemData.userData!.tipTipoUsuario!),
    );
  }
}

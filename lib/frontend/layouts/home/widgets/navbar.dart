import 'package:expose/backend/providers/sidemenu_provider.dart';
import 'package:expose/frontend/layouts/home/widgets/navbar_avatar.dart';
import 'package:expose/frontend/layouts/home/widgets/notifications_indicator.dart';
import 'package:expose/frontend/layouts/home/widgets/search_text.dart';
import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: 50,
      decoration: buildBoxDecoration(),
      child: Row(
        children: [
          SizedBox(width: 5),

          // Search input
          if (size.width > 390)
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 250),
              child: SearchText(),
            ),

          Spacer(),

          NotificationsIndicator(),
          SizedBox(width: 10),
          NavbarAvatar(),
          SizedBox(width: 10)
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(
      color: Colors.white,
      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)]);
}

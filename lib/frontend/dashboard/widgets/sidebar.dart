import 'package:expose_master/backend/providers/auth_provider.dart';
import 'package:expose_master/backend/providers/side_menu_provider.dart';
import 'package:expose_master/backend/router/navigation_service.dart';
import 'package:expose_master/backend/router/router.dart';
import 'package:expose_master/backend/router/router_manager.dart';
import 'package:expose_master/frontend/dashboard/widgets/logo.dart';
import 'package:expose_master/frontend/dashboard/widgets/menu_item.dart';
import 'package:expose_master/frontend/dashboard/widgets/text_separator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final side = Provider.of<SideMenuProvider>(context);
    final auth = Provider.of<AuthProvider>(context);

    return Container(
      width: 150,
      height: double.infinity,
      decoration: buildBoxDecoration(),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          const Logo(),
          const SizedBox(height: 50),
          const TextSeparator(text: "Inicio"),
          MenuItems(
            icon: Icons.co_present_outlined,
            isActive: side.currentPage == RouterPath.dash,
            onPressed: () => NavigationRouter.navigateTo(SystemRouter.dash),
          ),
          MenuItems(
            icon: Icons.groups_outlined,
            isActive: side.currentPage == RouterPath.groups,
            onPressed: () =>
                NavigationRouter.navigateTo(SystemRouter.dashGroups),
          ),
          const TextSeparator(text: "Salir"),
          MenuItems(
            icon: Icons.logout_outlined,
            isActive: false,
            onPressed: () => auth.logout(),
          ),
        ],
      ),
    );
  }
}

BoxDecoration buildBoxDecoration() => const BoxDecoration(
    color: Colors.black,
    boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)]);

import 'package:expose_master/backend/providers/auth_provider.dart';
import 'package:expose_master/backend/providers/side_menu_provider.dart';
import 'package:expose_master/backend/router/navigation_service.dart';
import 'package:expose_master/backend/router/router.dart';
import 'package:expose_master/backend/router/router_manager.dart';
import 'package:expose_master/backend/services/system.dart';
import 'package:expose_master/frontend/Initiatives/widgets/logo.dart';
import 'package:expose_master/frontend/Initiatives/widgets/menu_item.dart';
import 'package:expose_master/frontend/Initiatives/widgets/text_separator.dart';
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
          const SizedBox(height: 40),
          const TextSeparator(text: "Inicio"),
          MenuItems(
            icon: Icons.co_present_outlined,
            isActive: side.currentPage == RouterPath.dash,
            onPressed: () => NavigationRouter.navigateTo(SystemRouter.dash),
          ),
          if (SystemData.userData!.tipTipoUsuario == "Estudiante") ...{
            MenuItems(
              icon: Icons.groups_outlined,
              isActive: side.currentPage == RouterPath.groups,
              onPressed: () =>
                  NavigationRouter.navigateTo(SystemRouter.dashGroups),
            ),
          },
          const SizedBox(height: 40),
          const TextSeparator(text: "Perfil"),
          MenuItems(
            icon: Icons.manage_accounts_outlined,
            isActive: side.currentPage == RouterPath.profile,
            onPressed: () =>
                NavigationRouter.navigateTo(SystemRouter.dashProfile),
          ),
          //Área del coordinador & admin
          if (SystemData.userData!.tipTipoUsuario == 'Coordinador' ||
              SystemData.userData!.tipTipoUsuario == "administrador") ...{
            const SizedBox(height: 50),
            const TextSeparator(text: "Coordinador"),
            MenuItems(
              icon: Icons.group_outlined,
              isActive: side.currentPage == RouterPath.users,
              onPressed: () =>
                  NavigationRouter.navigateTo(SystemRouter.dashUsers),
            ),
            MenuItems(
              icon: Icons.leaderboard_outlined,
              isActive: side.currentPage == RouterPath.leaders,
              onPressed: () =>
                  NavigationRouter.navigateTo(SystemRouter.dashLeaders),
            ),
            MenuItems(
              icon: Icons.present_to_all_outlined,
              isActive: side.currentPage == RouterPath.proposals,
              onPressed: () =>
                  NavigationRouter.navigateTo(SystemRouter.dashProposals),
            ),
            MenuItems(
              icon: Icons.comment_outlined,
              isActive: side.currentPage == RouterPath.comments,
              onPressed: () =>
                  NavigationRouter.navigateTo(SystemRouter.dashComments),
            ),
          },
          //Área del administrador
          if (SystemData.userData!.tipTipoUsuario == "administrador") ...{
            const SizedBox(height: 40),
            const TextSeparator(text: "Administrador"),
            MenuItems(
              icon: Icons.person_add_outlined,
              isActive: side.currentPage == RouterPath.admin,
              onPressed: () =>
                  NavigationRouter.navigateTo(SystemRouter.dashAdmin),
            ),
          },
          const SizedBox(height: 40),
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

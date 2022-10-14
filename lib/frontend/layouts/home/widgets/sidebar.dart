import 'package:expose/backend/providers/sidemenu_provider.dart';
import 'package:expose/backend/providers/system.dart';
import 'package:expose/backend/router/router.dart';
import 'package:expose/backend/services/navigation_service.dart';
import 'package:expose/frontend/layouts/home/widgets/logo.dart';
import 'package:expose/frontend/layouts/home/widgets/menu_item.dart';
import 'package:expose/frontend/layouts/home/widgets/text_separator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  void navigateTo(String routeName) {
    NavigationService.navigateTo(routeName);
  }

  @override
  Widget build(BuildContext context) {
    final sideMenuProvider = Provider.of<SideMenuProvider>(context);

    return Container(
      width: 200,
      height: double.infinity,
      decoration: buildBoxDecoration(),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Logo(),
          const SizedBox(height: 50),
          const TextSeparator(text: 'Inicio'),
          MenuItems(
            text: 'Iniciativas',
            icon: Icons.compass_calibration_outlined,
            onPressed: () => navigateTo(SystemRouter.dashboard),
            isActive: sideMenuProvider.currentPage == SystemRouter.dashboard,
          ),
          MenuItems(
            text: 'Grupos',
            icon: Icons.group_add_outlined,
            onPressed: () => navigateTo(SystemRouter.dashGroups),
            isActive: sideMenuProvider.currentPage == SystemRouter.dashGroups,
          ),
          const SizedBox(height: 50),
          const TextSeparator(text: 'Perfil'),
          MenuItems(
            text: 'Editar Perfil',
            icon: Icons.show_chart_outlined,
            onPressed: () {},
            isActive: sideMenuProvider.currentPage == SystemRouter.dashboard,
          ),
          MenuItems(
            text: 'Privacidad',
            icon: Icons.layers_outlined,
            onPressed: () {},
            isActive: sideMenuProvider.currentPage == SystemRouter.dashboard,
          ),
          if (SystemData.userData!.tipTipoUsuario == 'Coordinador') ...{
            const SizedBox(height: 30),
            const TextSeparator(text: 'Coordinador'),
            MenuItems(
              text: 'Líderes',
              icon: Icons.list_alt_outlined,
              onPressed: () => navigateTo(SystemRouter.dashboard),
              isActive: sideMenuProvider.currentPage == SystemRouter.dashboard,
            ),
            MenuItems(
              text: 'Propuestas',
              icon: Icons.note_add_outlined,
              onPressed: () {},
              isActive: sideMenuProvider.currentPage == SystemRouter.dashboard,
            ),
            MenuItems(
              text: 'Comentarios',
              icon: Icons.mark_email_read_outlined,
              onPressed: () {},
              isActive: sideMenuProvider.currentPage == SystemRouter.dashboard,
            ),
          },
          if (SystemData.userData!.tipTipoUsuario == 'Administrador') ...{
            const SizedBox(height: 50),
            const TextSeparator(text: 'Administrador'),
            MenuItems(
              text: 'Coordinadores',
              icon: Icons.post_add_outlined,
              onPressed: () => navigateTo(SystemRouter.dashboard),
              isActive: sideMenuProvider.currentPage == SystemRouter.dashboard,
            ),
          },
          const SizedBox(height: 50),
          const TextSeparator(text: 'Salir'),
          MenuItems(
            text: 'Cerrar Sesión',
            icon: Icons.exit_to_app_outlined,
            onPressed: () {},
            isActive: sideMenuProvider.currentPage == SystemRouter.dashboard,
          ),
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => const BoxDecoration(
      color: Colors.black,
      boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)]);
}

import 'package:expose_master/backend/providers/auth_provider.dart';
import 'package:expose_master/backend/providers/side_menu_provider.dart';
import 'package:expose_master/backend/router/router_manager.dart';
import 'package:expose_master/frontend/404/not_found_page.dart';
import 'package:expose_master/frontend/Authentication/login_page.dart';
import 'package:expose_master/frontend/Authentication/register_page.dart';
import 'package:expose_master/frontend/Grupos/groups_page.dart';
import 'package:expose_master/frontend/Informacion%20Adicional/help_center_page.dart';
import 'package:expose_master/frontend/Leaders/leaders_page.dart';
import 'package:expose_master/frontend/Profile/profile_page.dart';
import 'package:expose_master/frontend/Proposals/proposals_page.dart';
import 'package:expose_master/frontend/Initiatives/iniciatives_page.dart';
import 'package:expose_master/frontend/Users/users_page.dart';
import 'package:expose_master/frontend/landing%20Page/landing_page.dart';
import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';

class RouterHandlers {
  //404
  static Handler errorPage = Handler(
    handlerFunc: (context, parameters) {
      RouterBuilderManager.routerPath = RouterPath.notFound;
      final side = Provider.of<SideMenuProvider>(context!);
      side.setCurrentPageUrl(RouterPath.notFound);
      return const NotFoundPage();
    },
  );

  //Root
  static Handler root = Handler(
    handlerFunc: (context, parameters) {
      final auth = Provider.of<AuthProvider>(context!);
      if (auth.routerStatus == RouterStatus.auth) {
        RouterBuilderManager.routerPath = RouterPath.dash;
        final side = Provider.of<SideMenuProvider>(context);
        side.setCurrentPageUrl(RouterPath.dash);
        return const IniciativesPage();
      }
      RouterBuilderManager.routerPath = RouterPath.root;
      return const LandingPage();
    },
  );

  //Help
  static Handler help = Handler(
    handlerFunc: (context, parameters) {
      RouterBuilderManager.routerPath = RouterPath.help;
      return const HelpCenterPage();
    },
  );

  //Login
  static Handler login = Handler(
    handlerFunc: (context, parameters) {
      final auth = Provider.of<AuthProvider>(context!);

      if (auth.routerStatus == RouterStatus.auth) {
        RouterBuilderManager.routerPath = RouterPath.dash;
        final side = Provider.of<SideMenuProvider>(context);
        side.setCurrentPageUrl(RouterPath.dash);
        return const IniciativesPage();
      }
      RouterBuilderManager.routerPath = RouterPath.login;
      return const LoginPage();
    },
  );

  //Register
  static Handler register = Handler(
    handlerFunc: (context, parameters) {
      final auth = Provider.of<AuthProvider>(context!);

      if (auth.routerStatus == RouterStatus.auth) {
        RouterBuilderManager.routerPath = RouterPath.dash;
        final side = Provider.of<SideMenuProvider>(context);
        side.setCurrentPageUrl(RouterPath.dash);
        return const IniciativesPage();
      }
      RouterBuilderManager.routerPath = RouterPath.register;
      return const RegisterPage();
    },
  );

  //Iniciatives
  static Handler dash = Handler(
    handlerFunc: (context, parameters) {
      RouterBuilderManager.routerPath = RouterPath.dash;
      final side = Provider.of<SideMenuProvider>(context!);
      side.setCurrentPageUrl(RouterPath.dash);
      return const IniciativesPage();
    },
  );

  //Grupos
  static Handler groups = Handler(
    handlerFunc: (context, parameters) {
      final auth = Provider.of<AuthProvider>(context!);

      if (auth.routerStatus == RouterStatus.auth) {
        RouterBuilderManager.routerPath = RouterPath.groups;
        final side = Provider.of<SideMenuProvider>(context);
        side.setCurrentPageUrl(RouterPath.groups);
        return const GroupsPage();
      }
      RouterBuilderManager.routerPath = RouterPath.root;
      return const LandingPage();
    },
  );

  //Perfil
  static Handler profile = Handler(
    handlerFunc: (context, parameters) {
      final auth = Provider.of<AuthProvider>(context!);

      if (auth.routerStatus == RouterStatus.auth) {
        RouterBuilderManager.routerPath = RouterPath.profile;
        final side = Provider.of<SideMenuProvider>(context);
        side.setCurrentPageUrl(RouterPath.profile);
        return const ProfilePage();
      }
      RouterBuilderManager.routerPath = RouterPath.root;
      return const LandingPage();
    },
  );

  //Usuarios
  static Handler users = Handler(
    handlerFunc: (context, parameters) {
      final auth = Provider.of<AuthProvider>(context!);

      if (auth.routerStatus == RouterStatus.auth) {
        RouterBuilderManager.routerPath = RouterPath.users;
        final side = Provider.of<SideMenuProvider>(context);
        side.setCurrentPageUrl(RouterPath.users);
        return const UsersPage();
      }
      RouterBuilderManager.routerPath = RouterPath.root;
      return const LandingPage();
    },
  );

  //Leaders
  static Handler leaders = Handler(
    handlerFunc: (context, parameters) {
      final auth = Provider.of<AuthProvider>(context!);

      if (auth.routerStatus == RouterStatus.auth) {
        RouterBuilderManager.routerPath = RouterPath.leaders;
        final side = Provider.of<SideMenuProvider>(context);
        side.setCurrentPageUrl(RouterPath.leaders);
        return const LeadersPage();
      }
      RouterBuilderManager.routerPath = RouterPath.root;
      return const LandingPage();
    },
  );

  //Proposals
  static Handler proposals = Handler(
    handlerFunc: (context, parameters) {
      final auth = Provider.of<AuthProvider>(context!);

      if (auth.routerStatus == RouterStatus.auth) {
        RouterBuilderManager.routerPath = RouterPath.proposals;
        final side = Provider.of<SideMenuProvider>(context);
        side.setCurrentPageUrl(RouterPath.proposals);
        return const ProposalsPage();
      }
      RouterBuilderManager.routerPath = RouterPath.root;
      return const LandingPage();
    },
  );
}

import 'package:expose/backend/providers/auth_provider.dart';
import 'package:expose/backend/providers/dashboard_provider.dart';
import 'package:expose/backend/providers/sidemenu_provider.dart';
import 'package:expose/backend/router/router.dart';
import 'package:expose/frontend/views/groups_view.dart';
import 'package:expose/frontend/views/iniciatives_view.dart';
import 'package:expose/frontend/views/d1.dart';
import 'package:expose/frontend/views/login_view.dart';
import 'package:expose/frontend/views/register_view.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RouterHandlers {
  //Auth
  static Handler login = Handler(
    handlerFunc: (context, parameters) {
      final authProvider = Provider.of<AuthProvider>(context!);

      if (authProvider.authStatus == AuthStatus.notAuthenticated) {
        return const LoginView();
      } else {
        return const IniciativesView();
      }
    },
  );

  static Handler register = Handler(
    handlerFunc: (context, parameters) {
      final authProvider = Provider.of<AuthProvider>(context!);

      if (authProvider.authStatus == AuthStatus.notAuthenticated) {
        return const RegisterView();
      } else {
        return const IniciativesView();
      }
    },
  );

  //Dashboard
  static Handler home = Handler(
    handlerFunc: (context, parameters) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false)
          .setCurrentPageUrl(SystemRouter.dashboard);
      if (authProvider.authStatus == AuthStatus.authenticated) {
        return const IniciativesView();
      } else {
        return const LoginView();
      }
    },
  );

  //Iniciatives
  static Handler iniciatives = Handler(
    handlerFunc: (context, parameters) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false)
          .setCurrentPageUrl(SystemRouter.dashboard);
      if (authProvider.authStatus == AuthStatus.authenticated) {
        final dashboardProvider =
            Provider.of<DashboardProvider>(context, listen: false);
        dashboardProvider.findIniciative = parameters["id"]!.first;
        return const IniciativasView();
      } else {
        return const LoginView();
      }
    },
  );

  //DashGroups
  static Handler groups = Handler(
    handlerFunc: (context, parameters) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false)
          .setCurrentPageUrl(SystemRouter.dashGroups);
      if (authProvider.authStatus == AuthStatus.authenticated) {
        return const GroupsView();
      } else {
        return const LoginView();
      }
    },
  );

  //404
  static Handler errorPage = Handler(
    handlerFunc: (context, parameters) {
      return const Center(
        child: Text('404'),
      );
    },
  );
}

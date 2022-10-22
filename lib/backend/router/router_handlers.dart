import 'package:expose/backend/providers/auth_provider.dart';
import 'package:expose/backend/providers/initiatives_provider.dart';
import 'package:expose/backend/providers/sidemenu_provider.dart';
import 'package:expose/backend/router/router.dart';
import 'package:expose/frontend/views/groups_view.dart';
import 'package:expose/frontend/views/iniciatives_view.dart';
import 'package:expose/frontend/pages/initiative_page.dart';
import 'package:expose/frontend/views/leaders_view.dart';
import 'package:expose/frontend/views/login_view.dart';
import 'package:expose/frontend/views/privacy_view.dart';
import 'package:expose/frontend/views/profile_view.dart';
import 'package:expose/frontend/views/proposals_view.dart';
import 'package:expose/frontend/views/register_view.dart';
import 'package:expose/frontend/views/users_view.dart';
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

  //Dashprofile
  static Handler profile = Handler(
    handlerFunc: (context, parameters) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false)
          .setCurrentPageUrl(SystemRouter.dashboardProfile);
      if (authProvider.authStatus == AuthStatus.authenticated) {
        return const ProfileView();
      } else {
        return const LoginView();
      }
    },
  );

  //Dashprivacy
  static Handler privacy = Handler(
    handlerFunc: (context, parameters) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false)
          .setCurrentPageUrl(SystemRouter.dashboardPrivacy);
      if (authProvider.authStatus == AuthStatus.authenticated) {
        return const PrivacyView();
      } else {
        return const LoginView();
      }
    },
  );

  //DashUsers
  static Handler users = Handler(
    handlerFunc: (context, parameters) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false)
          .setCurrentPageUrl(SystemRouter.dashboardUsers);
      if (authProvider.authStatus == AuthStatus.authenticated) {
        return const UsersView();
      } else {
        return const LoginView();
      }
    },
  );

  //DashLeaders
  static Handler leaders = Handler(
    handlerFunc: (context, parameters) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false)
          .setCurrentPageUrl(SystemRouter.dashboardLeaders);
      if (authProvider.authStatus == AuthStatus.authenticated) {
        return const LeadersView();
      } else {
        return const LoginView();
      }
    },
  );

  //DashProposals
  static Handler proposals = Handler(
    handlerFunc: (context, parameters) {
      final authProvider = Provider.of<AuthProvider>(context!);
      Provider.of<SideMenuProvider>(context, listen: false)
          .setCurrentPageUrl(SystemRouter.dashboardProposals);
      if (authProvider.authStatus == AuthStatus.authenticated) {
        return const ProposalsView();
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

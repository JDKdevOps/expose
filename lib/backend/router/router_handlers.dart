import 'package:expose/backend/providers/auth_provider.dart';
import 'package:expose/frontend/views/home_view.dart';
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
        return const HomeView();
      }
    },
  );

  static Handler register = Handler(
    handlerFunc: (context, parameters) {
      final authProvider = Provider.of<AuthProvider>(context!);

      if (authProvider.authStatus == AuthStatus.notAuthenticated) {
        return const RegisterView();
      } else {
        return const HomeView();
      }
    },
  );

  //Dashboard
  static Handler home = Handler(
    handlerFunc: (context, parameters) {
      final authProvider = Provider.of<AuthProvider>(context!);
      if (authProvider.authStatus == AuthStatus.authenticated) {
        return const HomeView();
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

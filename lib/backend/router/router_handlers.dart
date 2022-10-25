import 'package:expose_master/backend/router/router_manager.dart';
import 'package:expose_master/frontend/404/not_found_page.dart';
import 'package:expose_master/frontend/Authentication/login_page.dart';
import 'package:expose_master/frontend/Authentication/register_page.dart';
import 'package:expose_master/frontend/Informacion%20Adicional/help_center_page.dart';
import 'package:expose_master/frontend/dashboard/iniciatives_page.dart';
import 'package:expose_master/frontend/landing%20Page/landing_page.dart';
import 'package:fluro/fluro.dart';

class RouterHandlers {
  //404
  static Handler errorPage = Handler(
    handlerFunc: (context, parameters) {
      RouterBuilderManager.routerPath = RouterPath.notFound;
      return const NotFoundPage();
    },
  );

  //Root
  static Handler root = Handler(
    handlerFunc: (context, parameters) {
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
      RouterBuilderManager.routerPath = RouterPath.login;
      return const LoginPage();
    },
  );

  //Register
  static Handler register = Handler(
    handlerFunc: (context, parameters) {
      RouterBuilderManager.routerPath = RouterPath.register;
      return const RegisterPage();
    },
  );

  //Iniciatives
  static Handler dash = Handler(
    handlerFunc: (context, parameters) {
      RouterBuilderManager.routerPath = RouterPath.dash;
      return const IniciativesPage();
    },
  );
}

import 'package:expose_master/backend/router/router_manager.dart';
import 'package:expose_master/frontend/404/not_found.dart';
import 'package:expose_master/frontend/Authentication/login_page.dart';
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
      return const LandingPage();
    },
  );

  //Login
  static Handler login = Handler(
    handlerFunc: (context, parameters) {
      RouterBuilderManager.routerPath = RouterPath.login;
      return const LoginPage();
    },
  );
}

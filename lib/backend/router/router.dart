import 'package:expose/backend/router/router_handlers.dart';
import 'package:fluro/fluro.dart';

class SystemRouter {
  static final FluroRouter router = FluroRouter();

  //Root Router
  static String root = '/auth/login';

  //Auth Router
  static String login = '/auth/login';
  static String register = '/auth/register';

  //Dashboard Router
  static String dashboard = '/dashboard';

  //Inicializar Router
  static void initRouter() {
    //root define
    router.define(root,
        handler: RouterHandlers.login, transitionType: TransitionType.none);

    //auth define
    router.define(login,
        handler: RouterHandlers.login, transitionType: TransitionType.none);
  }
}

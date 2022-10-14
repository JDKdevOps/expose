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
  static String dashGroups = '/dashboard/groups';
  static String dashboardGroupsId = '/dashboard/groups/:id';

  //Inicializar Router
  static void initRouter() {
    //root define
    router.define(root,
        handler: RouterHandlers.login, transitionType: TransitionType.none);

    //auth define
    router.define(login,
        handler: RouterHandlers.login, transitionType: TransitionType.none);
    router.define(register,
        handler: RouterHandlers.register, transitionType: TransitionType.none);

    //dashboard define
    router.define(dashboard,
        handler: RouterHandlers.home, transitionType: TransitionType.fadeIn);
    router.define(dashGroups,
        handler: RouterHandlers.groups, transitionType: TransitionType.fadeIn);

    //404
    router.notFoundHandler = RouterHandlers.errorPage;
  }
}

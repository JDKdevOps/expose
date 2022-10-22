import 'package:expose_master/backend/router/router_handlers.dart';
import 'package:fluro/fluro.dart';

class SystemRouter {
  static final FluroRouter router = FluroRouter();

  //Root Router
  static String root = '/';

  //Auth Router
  static String login = '/auth/login';
  static String register = '/auth/register';

  //Dashboard Router
  static String dash = '/dash';
  static String dashGroups = '/dash/groups';
  static String dashProfile = "/dash/profile";
  static String dashPrivacy = "/dash/privacy";
  static String dashUsers = "/dash/users";
  static String dashLeaders = "/dash/leaders";
  static String dashProposals = "/dash/proposals";
  static String dashComments = "/dash/comments";
  static String dashCoordinators = "/dash/coordinators";

  //DefineRoutes
  static void initRouter() {
    //404
    router.notFoundHandler = RouterHandlers.errorPage;

    //RootApp
    router.define(
      root,
      handler: RouterHandlers.root,
      transitionType: TransitionType.none,
    );

    //Login
    router.define(login,
        handler: RouterHandlers.login, transitionType: TransitionType.none);
  }
}

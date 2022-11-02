import 'package:expose_master/backend/router/router_handlers.dart';
import 'package:fluro/fluro.dart';

class SystemRouter {
  static final FluroRouter router = FluroRouter();

  //Root Router
  static String root = '/';
  static String help = "/help";

  //Auth Router
  static String login = '/auth/login';
  static String register = '/auth/register';

  //Dashboard Router
  static String dash = '/dash';
  static String dashGroups = '/dash/groups';
  static String dashProfile = "/dash/profile";
  static String dashUsers = "/dash/users";
  static String dashLeaders = "/dash/leaders";
  static String dashProposals = "/dash/proposals";

  //DefineRoutes
  static void initRouter() {
    //404
    router.notFoundHandler = RouterHandlers.errorPage;

    //RootApp
    router.define(root,
        handler: RouterHandlers.root, transitionType: TransitionType.none);
    router.define(help,
        handler: RouterHandlers.help, transitionType: TransitionType.none);

    //Login
    router.define(login,
        handler: RouterHandlers.login, transitionType: TransitionType.none);

    //Register
    router.define(register,
        handler: RouterHandlers.register, transitionType: TransitionType.none);

    //Iniciatives
    router.define(dash,
        handler: RouterHandlers.dash, transitionType: TransitionType.none);

    //Groups
    router.define(dashGroups,
        handler: RouterHandlers.groups, transitionType: TransitionType.none);

    //Profile
    router.define(dashProfile,
        handler: RouterHandlers.profile, transitionType: TransitionType.none);

    //Users
    router.define(dashUsers,
        handler: RouterHandlers.users, transitionType: TransitionType.none);

    //Leaders
    router.define(dashLeaders,
        handler: RouterHandlers.leaders, transitionType: TransitionType.none);

    //Proposals
    router.define(dashProposals,
        handler: RouterHandlers.proposals, transitionType: TransitionType.none);
  }
}

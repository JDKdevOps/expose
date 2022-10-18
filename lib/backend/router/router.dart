import 'package:expose/backend/router/router_handlers.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';

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
  static String dashboardProfile = "/dashboard/profile";
  static String dashboardPrivacy = "/dashboard/privacy";
  static String dashboardLeaders = "/dashboard/leaders";
  static String dashboardProposals = "/dashboard/proposals";
  static String dashboardComments = "/dashboard/comments";
  static String dashboardCoordinators = "/dashboard/coordinators";
  static String dashboardLogout = "/dashboard/logout";

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

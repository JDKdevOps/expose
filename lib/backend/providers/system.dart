import 'package:flutter/cupertino.dart';

class System extends ChangeNotifier {
   RouteStatus routeStatus = RouteStatus.normal;
   RouteModule routeModule = RouteModule.auth;
}

//RouteStatus
enum RouteStatus {
  normal,
  error,
}

//RouteModule
enum RouteModule {
  auth,
  dashboard,
}

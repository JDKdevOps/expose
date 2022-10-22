import 'package:expose_master/frontend/404/not_found.dart';
import 'package:expose_master/frontend/landing%20Page/landing_page.dart';
import 'package:fluro/fluro.dart';

class RouterHandlers {
  //404
  static Handler errorPage = Handler(
    handlerFunc: (context, parameters) {
      return const NotFoundPage();
    },
  );

  //Root
  static Handler root = Handler(
    handlerFunc: (context, parameters) {
      return const LandingPage();
    },
  );
}

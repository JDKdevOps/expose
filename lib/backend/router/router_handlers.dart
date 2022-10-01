import 'package:expose/frontend/views/login_view.dart';
import 'package:fluro/fluro.dart';

class RouterHandlers {
  static Handler login = Handler(
    handlerFunc: (context, parameters) {
      return const LoginView();
    },
  );
}

import 'package:expose/backend/providers/auth_provider.dart';
import 'package:expose/frontend/views/login_view.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class RouterHandlers {
  static Handler login = Handler(
    handlerFunc: (context, parameters) {
      return ChangeNotifierProvider(
        create: (_) => AuthProvider(),
        child: const LoginView(),
      );
    },
  );

  //404
  static Handler errorPage = Handler(
    handlerFunc: (context, parameters) {
      return Container(
        child: Center(
          child: Text('404'),
        ),
      );
    },
  );
}

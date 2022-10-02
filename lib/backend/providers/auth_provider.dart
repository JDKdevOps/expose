import 'package:expose/backend/router/router.dart';
import 'package:expose/backend/services/local_storage.dart';
import 'package:expose/backend/services/navigation_service.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  String? _token;

  AuthStatus authStatus = AuthStatus.checking;

  GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  GlobalKey<FormState> registerKey = GlobalKey<FormState>();

  String email = '';
  String password = '';

  AuthProvider() {
    isAuthenticated();
  }

  Future<bool> isAuthenticated() async {
    final token = LocalStorage.localDB.getString('token');

    if (token == null) {
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      return false;
    }

    // TODO: ir al backend y comprobar si el JWT es válido

    await Future.delayed(Duration(milliseconds: 1000));
    authStatus = AuthStatus.authenticated;
    notifyListeners();
    return true;
  }

  bool validateLogin() {
    if (loginKey.currentState!.validate()) {
      return true;
    }
    return false;
  }

  login(String email, String password) {
    // TODO: Petición HTTP
    this._token = 'adjkfhadfyiu12y3hjasd.ajskhdaks.kjshdkjas';
    LocalStorage.localDB.setString('token', this._token!);

    authStatus = AuthStatus.authenticated;
    notifyListeners();

    NavigationService.replaceTo(SystemRouter.dashboard);
  }
}

enum AuthStatus { checking, authenticated, notAuthenticated }

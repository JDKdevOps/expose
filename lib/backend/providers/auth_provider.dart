import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  GlobalKey<FormState> registerKey = GlobalKey<FormState>();

  String email = '';
  String password = '';

  bool validateLogin() {
    if (loginKey.currentState!.validate()) {
      return true;
    }
    return false;
  }
}

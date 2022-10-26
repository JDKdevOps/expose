import 'package:expose_master/backend/router/router_manager.dart';
import 'package:flutter/material.dart';

class SideMenuProvider extends ChangeNotifier {
  RouterPath _currentPage = RouterPath.root;

  RouterPath get currentPage {
    return _currentPage;
  }

  void setCurrentPageUrl(RouterPath routeName) {
    _currentPage = routeName;
    Future.delayed(const Duration(milliseconds: 100), () {
      notifyListeners();
    });
  }
}

import 'package:expose_master/backend/providers/auth_provider.dart';
import 'package:expose_master/backend/providers/dash_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppSate extends StatelessWidget {
  final Widget app;

  const AppSate({Key? key, required this.app}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (context) => AuthProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => DashProvider(),
      ),
    ], child: app);
  }
}

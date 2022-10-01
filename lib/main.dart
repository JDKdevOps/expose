import 'package:expose/backend/router/router.dart';
import 'package:expose/frontend/layouts/auth/auth_layout.dart';
import 'package:flutter/material.dart';

void main() {
  SystemRouter.initRouter();

  runApp(const ExposeApp());
}

class ExposeApp extends StatelessWidget {
  const ExposeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expose',
      initialRoute: SystemRouter.root,
      onGenerateRoute: (settings) => SystemRouter.router.generator(settings),
      builder: (context, child) {
        return AuthLayout(child: child!);
      },
    );
  }
}

import 'package:expose/backend/router/router.dart';
import 'package:expose/frontend/layouts/auth/auth_layout.dart';
import 'package:flutter/material.dart';

void main() {
  //Inicializar sistema de rutas
  SystemRouter.initRouter();

  //Inicializar aplicación
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
      onGenerateRoute: SystemRouter.router.generator,
      builder: (_, child) {
        return AuthLayout(child: child!);
      },
    );
  }
}

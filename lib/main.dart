import 'package:expose_master/backend/router/navigation_service.dart';
import 'package:expose_master/backend/router/router_manager.dart';
import 'package:expose_master/backend/router/router.dart';
import 'package:expose_master/backend/services/local_storage.dart';
import 'package:expose_master/firebase_options.dart';
import 'package:expose_master/frontend/dashboard/dash_layout.dart';
import 'package:expose_master/frontend/landing%20Page/landing_layout.dart';
import 'package:expose_master/main_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  //[Base de datos NoSQL]
  //Inicia la base de datos no relacional "Firebase" mediante una instancia
  //global que es accedida por sus clases correspondientes.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //[Base de datos local]
  //Inicia la base de datos local en el "localSotrage" del navegador para
  //manejar la sesión de usuario de forma encriptada.
  await LocalStorage.initDB();

  //[Router]
  //Inicia el manejo de rutas para las vistas de la aplicación, configurando
  //las URL de acceso y los métodos de seguridad correspondientes
  SystemRouter.initRouter();

  //[Correr aplicación]
  //Inicia la aplicación inicial después de haber instanciado todas las
  //dependencias correspondientes al proyecto.
  runApp(
    const AppSate(
      app: ExposeApp(),
    ),
  );
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
      navigatorKey: NavigationRouter.navigatorKey,
      builder: (context, child) {
        if (RouterBuilderManager.routerStatus == RouterStatus.auth) {
          return DashLayout(widget: child!);
        }
        return LandingLayout(widget: child!);
      },
    );
  }
}

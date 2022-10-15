import 'package:expose/backend/providers/auth_provider.dart';
import 'package:expose/backend/providers/dashboard_provider.dart';
import 'package:expose/backend/providers/sidemenu_provider.dart';
import 'package:expose/backend/router/router.dart';
import 'package:expose/backend/services/local_storage.dart';
import 'package:expose/backend/services/navigation_service.dart';
import 'package:expose/firebase_options.dart';
import 'package:expose/frontend/layouts/auth/auth_layout.dart';
import 'package:expose/frontend/layouts/home/home_layout.dart';
import 'package:expose/frontend/layouts/interface/splash_layout.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  //Inicia la base de datos no relacional
  //Realiza una petición con los credenciales a firebase para instanciarse
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //Inicializar base de datos local
  //Crea la instancia de la base de datos local en el navegador
  await LocalStorage.initDB();

  //Inicializar sistema de rutas
  //Crea las URL accesibles por el usuario final
  SystemRouter.initRouter();

  //Inicializar aplicación
  //Inicia el arbol de widgets para toda la aplicación desde root
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Crea un servicio múltiple de Providers
    //Instancia distintos servicios para manejar el estado de la página
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => DashboardProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => SideMenuProvider(),
          lazy: false,
        ),
      ],
      child: const ExposeApp(),
    );
  }
}

class ExposeApp extends StatelessWidget {
  const ExposeApp({super.key});

  @override
  Widget build(BuildContext context) {
    //Inicia la aplicación web
    //Instancia la aplicación en la dirección URL especificada
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expose',
      initialRoute: SystemRouter.root,
      onGenerateRoute: SystemRouter.router.generator,
      navigatorKey: NavigationService.navigatorKey,
      builder: (_, child) {
        final authProvider = Provider.of<AuthProvider>(context);

        if (authProvider.authStatus == AuthStatus.checking) {
          return const SplashLayout();
        }

        if (authProvider.authStatus == AuthStatus.authenticated) {
          return DashboardLayout(child: child!);
        } else {
          return AuthLayout(child: child!);
        }
      },
    );
  }
}

import 'package:expose_master/backend/router/navigation_service.dart';
import 'package:expose_master/backend/router/router.dart';
import 'package:expose_master/backend/router/router_manager.dart';
import 'package:expose_master/frontend/shared/custom_button.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 150),
        const Text(
          "¿Tienes una idea?",
          style: TextStyle(
            fontFamily: "MontserratAlternates",
            fontSize: 80,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 50),
        const Text(
          """
¡En Expose puedes publicar tus iniciativas para que sean reconocidas!
Cocina, tecnología, inmuebles, todo lo que imagines para cambiar el mundo
Puedes echar un vistazo o unirte a nuestro grupo de emprendedores, ¿Qué esperas?
""",
          style: TextStyle(
            fontFamily: "MontserratAlternates",
            fontSize: 20,
            fontWeight: FontWeight.normal,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 50),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              text: "Ingresar como Visitante",
              onPressed: () {
                RouterBuilderManager.routerPath = RouterPath.dash;
                NavigationRouter.navigateTo(
                  SystemRouter.dash,
                );
              },
            ),
            const SizedBox(
              width: 50,
            ),
            CustomButton(
              text: "Ingresar como Expositor",
              onPressed: () {
                RouterBuilderManager.routerPath = RouterPath.login;
                NavigationRouter.navigateTo(
                  SystemRouter.login,
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}

import 'package:expose_master/backend/router/navigation_service.dart';
import 'package:expose_master/backend/router/router.dart';
import 'package:expose_master/backend/router/router_manager.dart';
import 'package:expose_master/frontend/shared/link_text.dart';
import 'package:flutter/material.dart';

class LandingLayout extends StatelessWidget {
  final Widget widget;

  const LandingLayout({Key? key, required this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 5,
        title: GestureDetector(
          onTap: () {
            if (RouterBuilderManager.routerPath != RouterPath.root) {
              RouterBuilderManager.routerPath = RouterPath.root;
              NavigationRouter.replaceTo(SystemRouter.root);
            }
          },
          child: const MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Text(
              "Expose",
              style: TextStyle(
                fontFamily: "MontserratAlternates",
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: size.height * 0.88,
            child: widget,
          ),
          const Expanded(
            child: _Footer(),
          ),
        ],
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        const LinkText(
          text: 'Política de Privacidad',
        ),
        const LinkText(
          text: 'Términos y Condiciones',
        ),
        const LinkText(
          text: 'Licenciamiento',
        ),
        const LinkText(
          text: 'Centro de ayuda',
        ),
      ],
    );
  }
}

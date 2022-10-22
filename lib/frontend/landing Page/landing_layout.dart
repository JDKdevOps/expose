import 'package:expose_master/backend/router/navigation_service.dart';
import 'package:expose_master/backend/router/router.dart';
import 'package:expose_master/backend/router/router_manager.dart';
import 'package:expose_master/frontend/Footer/license.dart';
import 'package:expose_master/frontend/Footer/privacy_policy_page.dart';
import 'package:expose_master/frontend/Footer/terms_and_condition_page.dart';
import 'package:expose_master/frontend/shared/custom_dialog.dart';
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
        LinkText(
          text: 'Políticas de Privacidad',
          onPressed: () => showDialog(
            context: NavigationRouter.navigatorKey.currentContext!,
            builder: (_) => const CustomDialog(
              title: 'Políticas de Privacidad',
              content: PrivacyPolicyPage(),
            ),
          ),
        ),
        LinkText(
          text: 'Términos y Condiciones',
          onPressed: () => showDialog(
            context: NavigationRouter.navigatorKey.currentContext!,
            builder: (_) => const CustomDialog(
              title: 'Términos y Condiciones',
              content: TermsAndConditionPage(),
            ),
          ),
        ),
        LinkText(
          text: 'Licenciamiento',
          onPressed: () => showDialog(
            context: NavigationRouter.navigatorKey.currentContext!,
            builder: (_) => const CustomDialog(
              title: 'Términos y Condiciones',
              content: LicensesPage(),
            ),
          ),
        ),
        const LinkText(
          text: 'Centro de ayuda',
        ),
      ],
    );
  }
}

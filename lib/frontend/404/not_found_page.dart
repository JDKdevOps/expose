import 'package:expose_master/backend/router/router.dart';
import 'package:expose_master/backend/router/navigation_service.dart';
import 'package:expose_master/frontend/shared/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEDF1F2),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "imgs/not_found.svg",
              width: 700,
              height: 400,
            ),
            CustomButton(
              text: "Volver al inicio",
              onPressed: () {
                NavigationRouter.replaceTo(
                  SystemRouter.root,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

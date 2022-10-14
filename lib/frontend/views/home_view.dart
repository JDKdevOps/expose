import 'package:expose/backend/providers/dashboard_provider.dart';
import 'package:expose/backend/services/navigation_service.dart';
import 'package:expose/frontend/shared/custom_button.dart';
import 'package:expose/frontend/shared/white_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dashboardProvider = Provider.of<DashboardProvider>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Iniciativas:",
          style:
              GoogleFonts.montserrat(fontSize: 50, fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FutureBuilder(
                  future: dashboardProvider.getIniciativasPreview(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData &&
                        snapshot.data!.initiatives!.isNotEmpty) {
                      return Wrap(
                        crossAxisAlignment: WrapCrossAlignment.start,
                        direction: Axis.horizontal,
                        children: [
                          ...snapshot.data!.initiatives!.map(
                            (e) => WhiteCard(
                              width: 400,
                              height: 125,
                              title: e.iniNombre!,
                              child: Text(
                                e.iniDescripcion!,
                              ),
                              onPressed: () {
                                final index =
                                    snapshot.data!.initiatives!.indexOf(e) +
                                        dashboardProvider.indexPreview +
                                        1;
                                NavigationService.navigateTo(
                                    "/dashboard/$index");
                              },
                            ),
                          ),
                        ],
                      );
                    }
                    if (snapshot.hasData &&
                        snapshot.data!.initiatives!.isEmpty) {
                      return const FlutterLogo();
                    }
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.black,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        Row(
          children: [
            const SizedBox(width: 15),
            if (dashboardProvider.indexPreview != 0) ...{
              CustomButton(
                text: "Atrás",
                onPressed: () => dashboardProvider.indexPreview -= 5,
              ),
              const SizedBox(width: 40),
            },
            CustomButton(
              text: "Adelante",
              onPressed: () => dashboardProvider.indexPreview += 5,
            ),
          ],
        ),
      ],
    );
  }
}

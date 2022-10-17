import 'package:expose/backend/providers/dashboard_provider.dart';
import 'package:expose/backend/services/navigation_service.dart';
import 'package:expose/frontend/shared/custom_button.dart';
import 'package:expose/frontend/shared/iniciatives_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class IniciativesView extends StatelessWidget {
  const IniciativesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dashboardProvider = Provider.of<DashboardProvider>(context);

    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Iniciativas:",
              style: GoogleFonts.montserrat(
                  fontSize: 50, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: FutureBuilder(
                  future: dashboardProvider.getIniciativasPreview(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData &&
                        snapshot.data!.initiatives!.isNotEmpty) {
                      return Wrap(
                        crossAxisAlignment: WrapCrossAlignment.start,
                        direction: Axis.horizontal,
                        children: [
                          ...snapshot.data!.initiatives!.map(
                            (e) => IniciativesCard(
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
                      return Center(
                        child: SvgPicture.asset(
                          "empty.svg",
                          fit: BoxFit.contain,
                          width: 300,
                          height: 300,
                        ),
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.black,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
                  text: "Siguiente",
                  onPressed: () => dashboardProvider.indexPreview += 5,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

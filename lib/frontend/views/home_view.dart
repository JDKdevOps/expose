import 'package:expose/backend/providers/dashboard_provider.dart';
import 'package:expose/backend/providers/system.dart';
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
          child: Row(
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
                        ...snapshot.data!.initiatives!.map((e) => WhiteCard(
                            width: 500,
                            title: e.iniNombre!,
                            child: Text(e.iniDescripcion!)))
                      ],
                    );
                  }
                  if (snapshot.hasData && snapshot.data!.initiatives!.isEmpty) {
                    return FlutterLogo();
                  }
                  return Center(child: const CircularProgressIndicator());
                },
              ),
            ],
          ),
        ),
        Row(
          children: [
            if (dashboardProvider.indexPreview != 0) ...{
              CustomButton(
                text: "Atrás",
                onPressed: () => dashboardProvider.indexPreview -= 1,
              ),
              SizedBox(width: 40),
            },
            CustomButton(
              text: "Adelante",
              onPressed: () => dashboardProvider.indexPreview += 1,
            ),
          ],
        ),
      ],
    );
  }
}

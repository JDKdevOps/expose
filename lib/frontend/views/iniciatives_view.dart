import 'package:expose/backend/providers/initiatives_provider.dart';
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
    final dashboardProvider = Provider.of<InitiativesProvider>(context);

    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Iniciativas:",
                  style: GoogleFonts.montserrat(
                      fontSize: 50, fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 15),
                  CustomButton(
                    text: "Atrás",
                    onPressed: () {
                      if (dashboardProvider.indexPreview != 0) {
                        return dashboardProvider.indexPreview -= 5;
                      }
                    },
                  ),
                  const SizedBox(width: 20),
                  CustomButton(
                    text: "Siguiente",
                    onPressed: () {
                      if (!dashboardProvider.emptyContent) {
                        return dashboardProvider.indexPreview += 5;
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
          Expanded(
            child: Center(
              child: FutureBuilder(
                future: dashboardProvider.getIniciativas(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    dashboardProvider.emptyContent = false;
                    return Wrap(
                      crossAxisAlignment: WrapCrossAlignment.start,
                      direction: Axis.horizontal,
                      children: [
                        ...snapshot.data!.map(
                          (e) => IniciativesCard(
                            width: 400,
                            height: 125,
                            initiative: e,
                          ),
                        ),
                      ],
                    );
                  }
                  if (snapshot.hasData && snapshot.data!.isEmpty) {
                    dashboardProvider.emptyContent = true;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "empty.svg",
                          fit: BoxFit.contain,
                          width: 300,
                          height: 300,
                        ),
                        const SizedBox(height: 50),
                        Text(
                          "Más ideas vienen en camino",
                          style: GoogleFonts.montserrat(
                              fontSize: 35, fontWeight: FontWeight.bold),
                        ),
                      ],
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
        ],
      ),
    );
  }
}

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
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: FutureBuilder(
                  future: dashboardProvider.getIniciativas(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data!.isNotEmpty) {
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

import 'package:expose/backend/providers/leaders_provider.dart';
import 'package:expose/frontend/shared/iniciatives_card.dart';
import 'package:expose/frontend/shared/leaders_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LeadersView extends StatelessWidget {
  const LeadersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final leadersProvider = Provider.of<LeadersProvider>(context);

    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Solicitud de líderes:",
              style: GoogleFonts.montserrat(
                  fontSize: 50, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Center(
              child: FutureBuilder(
                future: leadersProvider.getLeaders(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    return SingleChildScrollView(
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.start,
                        direction: Axis.horizontal,
                        children: [
                          ...snapshot.data!.map(
                            (e) => LeadersCard(
                              width: 400,
                              height: 125,
                              leader: e,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  if (snapshot.hasData && snapshot.data!.isEmpty) {
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
                          "Más emprendedores vienen en camino",
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

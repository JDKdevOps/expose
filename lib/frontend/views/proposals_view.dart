import 'package:expose/backend/providers/initiatives_provider.dart';
import 'package:expose/backend/providers/proposals_provider.dart';
import 'package:expose/frontend/shared/custom_button.dart';
import 'package:expose/frontend/shared/iniciatives_card.dart';
import 'package:expose/frontend/shared/proposals_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProposalsView extends StatelessWidget {
  const ProposalsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final proposalsProvider = Provider.of<ProposalsProvider>(context);

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
                  "Propuestas pendientes  :",
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
                      if (proposalsProvider.indexPreview != 0) {
                        return proposalsProvider.indexPreview -= 5;
                      }
                    },
                  ),
                  const SizedBox(width: 20),
                  CustomButton(
                    text: "Siguiente",
                    onPressed: () {
                      if (!proposalsProvider.emptyContent) {
                        return proposalsProvider.indexPreview += 5;
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
                future: proposalsProvider.getIniciativas(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    proposalsProvider.emptyContent = false;
                    return Wrap(
                      crossAxisAlignment: WrapCrossAlignment.start,
                      direction: Axis.horizontal,
                      children: [
                        ...snapshot.data!.map(
                          (e) => ProposalsCard(
                            width: 400,
                            height: 125,
                            initiative: e,
                          ),
                        ),
                      ],
                    );
                  }
                  if (snapshot.hasData && snapshot.data!.isEmpty) {
                    proposalsProvider.emptyContent = true;
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

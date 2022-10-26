import 'package:expose_master/backend/providers/proposals_provider.dart';
import 'package:expose_master/frontend/Proposals/views/proposals_view.dart';
import 'package:expose_master/frontend/shared/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ProposalsPage extends StatelessWidget {
  const ProposalsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final proposals = Provider.of<ProposalsProvider>(context);

    return Container(
      margin: const EdgeInsets.all(20),
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Iniciativas Pendientes:",
              style: TextStyle(
                fontFamily: "MontserratAlternates",
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  child: IconButton(
                    onPressed: () {
                      if (proposals.index != 0) {
                        proposals.index -= 5;
                      }
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: Colors.black,
                      size: 50,
                    ),
                  ),
                ),
                Expanded(
                  child: FutureBuilder(
                    future: proposals.getIniciativas(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                        proposals.empty = false;
                        return Center(
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.start,
                            direction: Axis.horizontal,
                            children: [
                              ...snapshot.data!.map(
                                (e) => CustomCard(
                                  width: 350,
                                  height: 80,
                                  title: e.iniNombre!,
                                  assetImg: "imgs/initiative.svg",
                                  options: CustomOptions(
                                    options: [
                                      //Aprobar iniciativa
                                      OptionProps(
                                        title: "Aceptar Propuesta",
                                        icon: Icons.check_circle_outline,
                                        content: ProposalsView(
                                            initiative: e, isAccepting: true),
                                      ),
                                      //Rechazar iniciativa
                                      OptionProps(
                                        title: "Rechazar Propuesta",
                                        icon: Icons.cancel_outlined,
                                        content: ProposalsView(
                                            initiative: e, isAccepting: false),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                        proposals.empty = true;
                        return SizedBox(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "imgs/empty.svg",
                                fit: BoxFit.contain,
                                width: 300,
                                height: 300,
                              ),
                              const SizedBox(height: 50),
                              const Text(
                                "Más ideas vienen en camino",
                                style: TextStyle(
                                  fontFamily: "MontserratAlternates",
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(color: Colors.black),
                      );
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: IconButton(
                    onPressed: () {
                      if (!proposals.empty) {
                        proposals.index += 5;
                      }
                    },
                    icon: const Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Colors.black,
                      size: 50,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

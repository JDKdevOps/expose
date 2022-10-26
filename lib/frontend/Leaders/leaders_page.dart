import 'package:expose_master/backend/providers/leaders_provider.dart';
import 'package:expose_master/frontend/Leaders/views/leaders_view.dart';
import 'package:expose_master/frontend/shared/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class LeadersPage extends StatelessWidget {
  const LeadersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final leaders = Provider.of<LeadersProvider>(context);

    return Container(
      margin: const EdgeInsets.all(20),
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Solicitud de Liderazgo:",
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
                Expanded(
                  child: FutureBuilder(
                    future: leaders.getLeaders(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                        return Center(
                          child: SingleChildScrollView(
                            child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.start,
                              direction: Axis.horizontal,
                              children: [
                                ...snapshot.data!.map(
                                  (e) => CustomCard(
                                    width: 350,
                                    height: 80,
                                    title:
                                        "${e.peNombres!} ${e.peApellidoPaterno!} ${e.peApellidoMaterno!}",
                                    assetImg: "imgs/group.svg",
                                    options: CustomOptions(
                                      options: [
                                        //Aprobar líder
                                        OptionProps(
                                          title: "Aceptar Lider",
                                          icon: Icons.check_circle_outline,
                                          content: LeadersView(
                                              leader: e, isAccepting: true),
                                        ),
                                        //Rechazar líder
                                        OptionProps(
                                          title: "Rechazar Lider",
                                          icon: Icons.cancel_outlined,
                                          content: LeadersView(
                                              leader: e, isAccepting: false),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      } else if (snapshot.hasData && snapshot.data!.isEmpty) {
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}

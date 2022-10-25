import 'package:expose_master/backend/providers/dash_provider.dart';
import 'package:expose_master/backend/router/router_manager.dart';
import 'package:expose_master/frontend/dashboard/views/comments_view.dart';
import 'package:expose_master/frontend/dashboard/views/initiative_view.dart';
import 'package:expose_master/frontend/shared/custom_card.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IniciativesPage extends StatelessWidget {
  const IniciativesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dash = Provider.of<DashProvider>(context);

    return Container(
      margin: const EdgeInsets.all(20),
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Iniciativas:",
              style: TextStyle(
                fontFamily: "MontserratAlternates",
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: dash.getIniciativas(),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  return Wrap(
                    crossAxisAlignment: WrapCrossAlignment.start,
                    direction: Axis.horizontal,
                    children: [
                      ...snapshot.data!.map(
                        (e) => CustomCard(
                          width: 400,
                          height: 75,
                          title: e.iniNombre!,
                          assetImg: "imgs/initiative.svg",
                          options: CustomOptions(
                            options: [
                              //Ver iniciativas
                              OptionProps(
                                title: e.iniNombre!,
                                icon: Icons.info_outline,
                                content: IniciativeView(initiative: e),
                              ),
                              //Ver y publicar comentarios
                              OptionProps(
                                title: "Comentarios",
                                icon: Icons.comment_outlined,
                                content:  CommentsView(initiative: e),
                              ),
                            ],
                          ),
                          extraOptions: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "Calificación: ${double.parse(
                                  e.iniCalificacionPromedio!.toStringAsFixed(2),
                                )}",
                                style: const TextStyle(
                                  fontFamily: "MontserratAlternates",
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              if (RouterBuilderManager.routerStatus ==
                                  RouterStatus.auth) ...{
                                RatingBar.builder(
                                  itemSize: 25,
                                  initialRating: dash.ratingList
                                      .singleWhere((value) =>
                                          value.initiative ==
                                          e.idIniciativa!.toString())
                                      .value,
                                  minRating: 0,
                                  maxRating: 5,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemPadding:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star_border_outlined,
                                    size: 50,
                                  ),
                                  onRatingUpdate: (value) {
                                    dash.updateRating(e.idIniciativa!, value);
                                  },
                                ),
                              }
                            ],
                          ),
                        ),
                      ),
                    ],
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
    );
  }
}

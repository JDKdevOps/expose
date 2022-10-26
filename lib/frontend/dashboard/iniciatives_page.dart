import 'package:expose_master/backend/providers/auth_provider.dart';
import 'package:expose_master/backend/providers/dash_provider.dart';
import 'package:expose_master/frontend/dashboard/views/comments_view.dart';
import 'package:expose_master/frontend/dashboard/views/contact_form_view.dart';
import 'package:expose_master/frontend/dashboard/views/initiative_view.dart';
import 'package:expose_master/frontend/shared/custom_card.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class IniciativesPage extends StatelessWidget {
  const IniciativesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dash = Provider.of<DashProvider>(context);
    final auth = Provider.of<AuthProvider>(context);

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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  child: IconButton(
                    onPressed: () {
                      if (dash.index != 0) {
                        dash.index -= 5;
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
                    future: dash.getIniciativas(auth.routerStatus),
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                        dash.empty = false;
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
                                        content: CommentsView(
                                            initiative: e,
                                            routerStatus: auth.routerStatus),
                                      ),
                                      //Formulario de contacto
                                      OptionProps(
                                        title: "Contáctanos",
                                        icon: Icons.mail_outline,
                                        content: ContactFormView(initiative: e),
                                      ),
                                    ],
                                  ),
                                  extraOptions: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        "Calificación: ${double.parse(
                                          e.iniCalificacionPromedio!
                                              .toStringAsFixed(2),
                                        )}",
                                        style: const TextStyle(
                                          fontFamily: "MontserratAlternates",
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      if (auth.routerStatus ==
                                          RouterStatus.auth) ...{
                                        RatingBar.builder(
                                          itemSize: 25,
                                          initialRating: e.miCalificacion!,
                                          minRating: 0,
                                          maxRating: 5,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 4),
                                          itemBuilder: (context, index) =>
                                              const Icon(
                                            Icons.star_border_outlined,
                                            size: 50,
                                          ),
                                          onRatingUpdate: (value) {
                                            dash.updateRating(
                                                e.idIniciativa!, value);
                                          },
                                        ),
                                      }
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                        dash.empty = true;
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
                      if (!dash.empty) {
                        dash.index += 5;
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

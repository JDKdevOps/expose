import 'package:expose/backend/classes/groups.dart';
import 'package:expose/backend/providers/groups_provider.dart';
import 'package:expose/backend/providers/system.dart';

import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MultiInitiativesPage extends StatelessWidget {
  final Group group;

  const MultiInitiativesPage({Key? key, required this.group}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final groupsProvider = Provider.of<GroupsProvider>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: FutureBuilder(
            future: groupsProvider.getInitiativesGroup(group.idGrupo!),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final data = snapshot.data![index];
                    return Card(
                      color: const Color(0xffF6F6F6),
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      elevation: 5,
                      shadowColor: Colors.black,
                      child: ListTile(
                        title: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.iniNombre!,
                                style: GoogleFonts.roboto(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                data.iniDescripcion!,
                                style: GoogleFonts.roboto(
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal),
                              ),
                              InkWell(
                                child: Text(
                                  "Link del video: Mi Asombroso video",
                                  style: GoogleFonts.roboto(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                onTap: () =>
                                    launchUrl(Uri.parse(data.iniVideo!)),
                              ),
                              InkWell(
                                child: Text(
                                  "Link de las diapositivas: Mi Asombrosa presentación",
                                  style: GoogleFonts.roboto(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                onTap: () =>
                                    launchUrl(Uri.parse(data.iniDiapositiva!)),
                              ),
                            ],
                          ),
                        ),
                        subtitle: Text(
                            "Calificación promedio: ${data.iniCalificacionPromedio!}"),
                      ),
                    );
                  },
                );
              } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "empty.svg",
                      fit: BoxFit.contain,
                      width: 200,
                      height: 200,
                    ),
                    const SizedBox(height: 50),
                    Text(
                      "Soñar en equipo te llevará mas alto",
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
      ],
    );
  }
}

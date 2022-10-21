import 'package:expose/backend/classes/groups.dart';
import 'package:expose/backend/providers/groups_provider.dart';
import 'package:expose/backend/providers/system.dart';

import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class InboxPage extends StatelessWidget {
  final Group group;

  const InboxPage({Key? key, required this.group}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final groupsProvider = Provider.of<GroupsProvider>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: FutureBuilder(
            future: groupsProvider.getInbox(group.idGrupo!),
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
                                "Remitente: ${data.fkIdUsuario}",
                                style: GoogleFonts.roboto(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Asunto: ${data.meTitulo}",
                                style: GoogleFonts.roboto(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Contenido:\n${data.meContenido}",
                                style: GoogleFonts.roboto(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                              ),
                              Text(
                                "${data.meFecha!}, ${data.meHora!}",
                              ),
                            ],
                          ),
                        ),
                        subtitle: Text("Iniciativa: ${data.iniNombre!}"),
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

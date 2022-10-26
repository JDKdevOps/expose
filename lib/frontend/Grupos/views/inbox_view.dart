import 'package:expose_master/backend/classes/groups.dart';
import 'package:expose_master/backend/providers/groups_provider.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InboxView extends StatelessWidget {
  final Group group;

  const InboxView({Key? key, required this.group}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final groups = Provider.of<GroupsProvider>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: FutureBuilder(
            future: groups.getInbox(group.idGrupo!),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final data = snapshot.data![index];
                    return Card(
                      color: const Color(0xffF6F6F6),
                      margin: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 20),
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
                                data.meTitulo!,
                                style: const TextStyle(
                                  fontFamily: "MontserratAlternates",
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                data.meContenido!,
                                style: const TextStyle(
                                  fontFamily: "MontserratAlternates",
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Text(
                                "Iniciativa: ${data.meTitulo!}",
                                style: const TextStyle(
                                  fontFamily: "MontserratAlternates",
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Enviado por: ${data.meTitulo!}",
                                style: const TextStyle(
                                  fontFamily: "MontserratAlternates",
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              data.meFecha!,
                              style: const TextStyle(
                                  fontFamily: "MontserratAlternates",
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              data.meHora!,
                              style: const TextStyle(
                                  fontFamily: "MontserratAlternates",
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "imgs/empty.svg",
                      fit: BoxFit.contain,
                      width: 200,
                      height: 200,
                    ),
                    const SizedBox(height: 50),
                    const Text(
                      "Soñar en equipo te llevará mas alto",
                      style: TextStyle(
                        fontFamily: "MontserratAlternates",
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
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

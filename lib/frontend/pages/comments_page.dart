import 'package:expose/backend/classes/iniciativa.dart';
import 'package:expose/backend/providers/initiatives_provider.dart';
import 'package:expose/backend/providers/system.dart';
import 'package:expose/frontend/shared/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CommentsPage extends StatelessWidget {
  final Initiatives initiative;

  const CommentsPage({Key? key, required this.initiative}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final initiativesProvider = Provider.of<InitiativesProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomInput(
            hint: "Comentarios",
            label: "Escribe un comentario...",
            onChanged: (p0) => initiativesProvider.comment = p0,
            icon: Icons.comment_outlined,
            iconButton: IconButton(
              onPressed: () => initiativesProvider
                  .postComments(initiative.idIniciativa.toString()),
              icon: const Icon(
                Icons.send_outlined,
              ),
              color: Colors.black,
              disabledColor: Colors.grey,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 700,
            height: 400,
            child: FutureBuilder(
              future: initiativesProvider
                  .getComments(initiative.idIniciativa.toString()),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, index) {
                      final data = snapshot.data![index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 15),
                        elevation: 5,
                        shadowColor: Colors.black,
                        child: ListTile(
                          leading: Image.network(
                              "https://ui-avatars.com/api/?rounded=true&name=${data.name}"),
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.name!,
                                style: GoogleFonts.roboto(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                data.content!,
                                style: GoogleFonts.roboto(
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Text(data.timestamp!),
                          ),
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                  return Center(
                    child: SvgPicture.asset(
                      "empty.svg",
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
          )
        ],
      ),
    );
  }
}

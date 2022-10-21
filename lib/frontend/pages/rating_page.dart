import 'package:expose/backend/classes/iniciativa.dart';
import 'package:expose/backend/providers/initiatives_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RatingPage extends StatelessWidget {
  final Initiative initiative;

  const RatingPage({Key? key, required this.initiative}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final initiativesProvider = Provider.of<InitiativesProvider>(context);

    return FutureBuilder(
      future: initiativesProvider.getRating(initiative.idIniciativa.toString()),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final myRating = snapshot.data;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RatingBar.builder(
                initialRating: myRating!,
                minRating: 0,
                maxRating: 5,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                itemBuilder: (context, index) => const Icon(
                  Icons.star_border_outlined,
                  size: 50,
                ),
                onRatingUpdate: (value) {
                  initiativesProvider.updateRating(
                      initiative.idIniciativa!, value);
                },
              ),
              const SizedBox(height: 20),
              Text(
                "Mi calificación: $myRating",
                style: GoogleFonts.roboto(
                    fontSize: 60, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 40),
              Text(
                initiative.iniCalificacionPromedio == 0
                    ? "Se el primero en calificar"
                    : "Calificación Promedio: ${initiative.iniCalificacionPromedio}",
                style: GoogleFonts.roboto(
                    fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
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
    );
  }
}

import 'package:expose_master/backend/providers/dash_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class RatingView extends StatelessWidget {
  final double promedio;
  final String idInitiative;

  const RatingView(
      {Key? key, required this.promedio, required this.idInitiative})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dash = Provider.of<DashProvider>(context, listen: true);

    return FutureBuilder(
      future: dash.getRating(idInitiative),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RatingBar.builder(
                initialRating: snapshot.data!,
                itemSize: 100,
                itemBuilder: (context, index) =>
                    const Icon(Icons.star_border_outlined),
                onRatingUpdate: (value) {
                  dash.updateRating(int.parse(idInitiative), value);
                },
              ),
              const SizedBox(height: 40),
              Text(
                "Mi calificación: ${double.parse(
                  snapshot.data!.toStringAsFixed(2),
                )}",
                style: const TextStyle(
                  fontFamily: "MontserratAlternates",
                  fontSize: 30,
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
    );
  }
}

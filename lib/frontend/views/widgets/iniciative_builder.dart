import 'package:expose/backend/classes/iniciativa.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pod_player/pod_player.dart';

class IniciativeBuilder extends StatelessWidget {
  const IniciativeBuilder({
    Key? key,
    required this.data,
    required this.controller,
  }) : super(key: key);

  final Initiative data;
  final PodPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.keyboard_return_outlined,
                color: Colors.black,
                size: 40,
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  data.iniNombre!,
                  style: GoogleFonts.montserrat(
                      fontSize: 50, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 640,
            height: 480,
            child: PodVideoPlayer(controller: controller),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Descripción:",
              style: GoogleFonts.montserrat(
                  fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              data.iniDescripcion!,
              style: GoogleFonts.montserrat(
                  fontSize: 25, fontWeight: FontWeight.normal),
            ),
          ),
          SizedBox(height: 50),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Calificación:",
              style: GoogleFonts.montserrat(
                  fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

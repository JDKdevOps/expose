import 'package:expose/backend/classes/iniciativa.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pod_player/pod_player.dart';

class IniciativesPage extends StatefulWidget {
  final Initiative initiative;

  const IniciativesPage({super.key, required this.initiative});

  @override
  State<IniciativesPage> createState() => _IniciativesPageState();
}

class _IniciativesPageState extends State<IniciativesPage> {
  late final PodPlayerController controller;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    controller = PodPlayerController(
        playVideoFrom: PlayVideoFrom.youtube(widget.initiative.iniVideo!))
      ..initialise().onError((error, stackTrace) => null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: PodVideoPlayer(controller: controller),
        ),
        const SizedBox(height: 15),
        Text(
          "Descripción",
          style: GoogleFonts.roboto(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        Text(
          widget.initiative.iniDescripcion!,
          style:
              GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.normal),
        ),
        const SizedBox(height: 15),
        Text(
          "Link de Presentación",
          style: GoogleFonts.roboto(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        Text(
          widget.initiative.iniDiapositiva!,
          style:
              GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.normal),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}

import 'package:expose_master/backend/classes/iniciativa.dart';
import 'package:flutter/material.dart';
import 'package:pod_player/pod_player.dart';
import 'package:url_launcher/url_launcher.dart';

class IniciativeView extends StatefulWidget {
  final Initiative initiative;

  const IniciativeView({super.key, required this.initiative});

  @override
  State<IniciativeView> createState() => _IniciativeViewState();
}

class _IniciativeViewState extends State<IniciativeView> {
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
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: PodVideoPlayer(controller: controller),
            ),
            const SizedBox(height: 15),
            const Text(
              "Descripción",
              style: TextStyle(
                fontFamily: "MontserratAlternates",
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              widget.initiative.iniDescripcion!,
              style: const TextStyle(
                fontFamily: "MontserratAlternates",
                fontSize: 20,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              "Link de Presentación",
              style: TextStyle(
                fontFamily: "MontserratAlternates",
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            InkWell(
              child: Row(
                children: const [
                  Icon(Icons.link_outlined, color: Colors.black),
                  Text(
                    "Link de diapositivas: Mi Asombrosa presentación",
                    style: TextStyle(
                      fontFamily: "MontserratAlternates",
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
              onTap: () => launchUrl(
                Uri.parse(
                  widget.initiative.iniDiapositiva!,
                ),
              ),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}

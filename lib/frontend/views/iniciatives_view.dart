import 'package:expose/backend/providers/dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pod_player/pod_player.dart';
import 'package:provider/provider.dart';

class IniciativasView extends StatefulWidget {
  const IniciativasView({super.key});

  @override
  State<IniciativasView> createState() => _IniciativasViewState();
}

class _IniciativasViewState extends State<IniciativasView> {
  late final PodPlayerController controller;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dashboardProvider = Provider.of<DashboardProvider>(context);

    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: FutureBuilder(
        future: dashboardProvider.findIniciativa(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!.initiative!.first;
            controller = PodPlayerController(
              playVideoFrom: PlayVideoFrom.youtube(
                data.iniVideo!,
              ),
            )..initialise();

            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      data.iniNombre!,
                      style: GoogleFonts.montserrat(
                          fontSize: 50, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 500,
                      height: 500,
                      child: PodVideoPlayer(controller: controller),
                    )
                  ],
                )
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
    );
  }
}

import 'package:expose/backend/providers/dashboard_provider.dart';
import 'package:expose/frontend/views/widgets/iniciative_builder.dart';
import 'package:flutter/material.dart';
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

            return IniciativeBuilder(data: data, controller: controller);
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

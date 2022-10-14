import 'package:expose/backend/providers/dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class IniciativasView extends StatelessWidget {
  const IniciativasView({super.key});

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
            return Column(
              children: [
                Text(
                  data.iniNombre!,
                  style: GoogleFonts.montserrat(
                      fontSize: 50, fontWeight: FontWeight.bold),
                ),
              ],
            );
          }
          return Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          );
        },
      ),
    );
  }
}

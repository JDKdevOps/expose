import 'package:expose/frontend/layouts/home/widgets/navbar.dart';
import 'package:expose/frontend/layouts/home/widgets/sidebar.dart';
import 'package:flutter/material.dart';

class DashboardLayout extends StatelessWidget {
  final Widget child;

  const DashboardLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEDF1F2),
      body: Stack(
        children: [
          Row(
            children: [
              //Barra de navegación Latera
              const Sidebar(),
              Expanded(
                child: Column(
                  children: [
                    // Barra de búsqueda superior
                    Navbar(),
                    // Vistas del dashboard
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: child,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

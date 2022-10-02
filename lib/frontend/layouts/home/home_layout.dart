import 'package:flutter/material.dart';

class HomeLayout extends StatelessWidget {
  final Widget child;

  const HomeLayout({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(destinations: [
            NavigationRailDestination(
                icon: Icon(Icons.home_outlined), label: Text('Casa')),
            NavigationRailDestination(
                icon: Icon(Icons.home_outlined), label: Text('Iniciativas'))
          ], selectedIndex: 1),
          Expanded(child: child),
        ],
      ),
    );
  }
}

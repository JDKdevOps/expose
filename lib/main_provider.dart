import 'package:expose_master/backend/providers/auth_provider.dart';
import 'package:expose_master/backend/providers/dash_provider.dart';
import 'package:expose_master/backend/providers/groups_provider.dart';
import 'package:expose_master/backend/providers/leaders_provider.dart';
import 'package:expose_master/backend/providers/proposals_provider.dart';
import 'package:expose_master/backend/providers/side_menu_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppSate extends StatelessWidget {
  final Widget app;

  const AppSate({Key? key, required this.app}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (context) => AuthProvider(),
        lazy: false,
      ),
      ChangeNotifierProvider(
        create: (context) => SideMenuProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => DashProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => GroupsProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => LeadersProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => ProposalsProvider(),
      ),
    ], child: app);
  }
}

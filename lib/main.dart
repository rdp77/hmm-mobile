import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hmm/screens/maintenance.dart';
import 'package:hmm/screens/not_active.dart';
import 'package:hmm/screens/splash.dart';
import 'package:hmm/screens/statistics.dart';

import './themes/theme.dart';
import 'utils/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "HMM Apps",
      theme: AppTheme.lightTheme.copyWith(
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => const SplashScreen(),
        MyRoutes.maintenanceRoute: (context) => MaintenanceScreen(),
        MyRoutes.statisticsRoute: (context) => StatisticsScreen(),
        MyRoutes.notActiveRoute: (context) => const NotActiveScreen(),
      },
    );
  }
}

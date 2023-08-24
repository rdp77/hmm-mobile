import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../env.dart';
import '../themes/light_color.dart';
import 'dashboard.dart';
import 'not_active.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<bool> checkWebsiteStatus() async {
    try {
      final response = await http.get(Uri.parse(Environment.baseUrl));
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    checkWebsiteStatus().then((isWebsiteActive) {
      Future.delayed(
        const Duration(seconds: 3),
        () {
          if (isWebsiteActive) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const DashboardScreen()),
            );
          } else {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => NotActiveScreen()));
          }
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightColor.background,
      body: Center(
          child: CircleAvatar(
        backgroundColor: LightColor.lightGrey,
        radius: 48,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            "assets/images/toolbox.png",
            scale: 1.5,
          ),
        ),
      )),
    );
  }
}

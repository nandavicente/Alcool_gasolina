import 'package:flutter/material.dart';
import  'home_screen.dart';

class SplashScreen extends StatefulWidget {
  final VoidCallback onThemeChange;
  const SplashScreen({super.key, required this.onThemeChange});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => HomeScreen(onThemeChange: widget.onThemeChange)),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Center(
        child: Image.asset(
          "assets/images/logo.png",
          width: 220,
        ),
      ),
    );
  }
}


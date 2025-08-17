import "package:flutter/material.dart";
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/splash_screen.dart' show SplashScreen;

void main() async {
  var WidgetsFlutterBinding;
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  bool isDark = prefs.getBool("isDarkTheme") ?? false;

  runApp(FuelApp(isDark: isDark));
}

class FuelApp extends StatefulWidget {
  final bool isDark;
  const FuelApp({super.key, required this.isDark});

  @override
  State<FuelApp> createState() => _FuelAppState();
}

class _FuelAppState extends State<FuelApp> {
  late bool _isDark;

  @override
  void initState() {
    super.initState();
    _isDark = widget.isDark;
  }

  void toggleTheme() async {
    setState(() {
      _isDark = !_isDark;
    });
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("isDarkTheme", _isDark);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Álcool ou Gasolina',
      theme: _isDark ? ThemeData.dark() : ThemeData.light(),
      home: SplashScreen(onThemeChange: toggleTheme),
      debugShowCheckedModeBanner: false,
    );
  }
}

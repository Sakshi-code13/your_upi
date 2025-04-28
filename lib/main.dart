import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(YourUpiApp());
}

class YourUpiApp extends StatefulWidget {
  @override
  _YourUpiAppState createState() => _YourUpiAppState();
}

class _YourUpiAppState extends State<YourUpiApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void toggleTheme(bool isDark) {
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YOUR UPI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      themeMode: _themeMode,
      debugShowCheckedModeBanner: false,
      home: SplashScreen(onThemeChanged: toggleTheme),
      routes: {
        '/home': (context) => HomeScreen(onThemeChanged: toggleTheme),
      },
    );
  }
}

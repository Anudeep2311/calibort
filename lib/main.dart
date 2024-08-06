import 'package:calibort_assignment/app_theme.dart';
import 'package:calibort_assignment/view/home_screen.dart';
import 'package:calibort_assignment/view/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: appThemeData,
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen()
      },
    );
  }
}

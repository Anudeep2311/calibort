import 'package:flutter/material.dart';

ThemeData appThemeData = ThemeData(
  useMaterial3: true,
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: primaryColor,
    onPrimary: onColor,
    secondary: secondaryColor,
    onSecondary: onColor,
    error: Colors.red,
    onError: onColor,
    surface: surfaceColor,
    onSurface: onColor,
  ),
  scaffoldBackgroundColor: scaffoldColor,
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    backgroundColor: surfaceColor,
    foregroundColor: scaffoldColor,
  ),
);

const Color scaffoldColor = Color(0xFFFFF5E1);
const Color primaryColor = Color(0xFFFF6969);
const Color secondaryColor = Color(0xFFC80036);
const Color surfaceColor = Color(0xFF0C1844);
const Color onColor = Colors.black;

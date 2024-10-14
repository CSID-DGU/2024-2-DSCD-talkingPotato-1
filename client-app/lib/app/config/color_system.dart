import 'package:flutter/material.dart';

abstract class ColorSystem {
  static const ColorScheme colorScheme = ColorScheme.light(
    primary: primary,
    onPrimary: white,
    secondary: secondary,
    onSecondary: white,
    error: red,
    onError: white,
    surface: white,
    onSurface: black,
    brightness: Brightness.light,
  );

  /// Transparent Color
  static const Color transparent = Colors.transparent;

  /// White Color
  static const Color white = Color(0xFFFFFFFF);

  /// Black Color
  static const Color black = Color(0xFF1D1D1D);

  /// Primary Color
  static const MaterialColor primary = MaterialColor(
    _primaryValue,
    <int, Color>{
      900: Color(0xFF032A28),
      800: Color(0xFF05332C),
      700: Color(0xFF083F31),
      600: Color(0xFF0C4B35),
      500: Color(0xFF115838),
      400: Color(0xFF3D9A67),
      300: Color(0xFF69CC8C),
      200: Color(0xFFA1EEB4),
      100: Color(0xFFCEF6D4),
      50: Color(0xFFEBFFEE),
    },
  );
  static const int _primaryValue = 0xFF115838;

  /// Secondary Color
  static const MaterialColor secondary = MaterialColor(
    _secondaryValue,
    <int, Color>{
      900: Color(0xFF014845),
      800: Color(0xFF02574B),
      700: Color(0xFF036C53),
      600: Color(0xFF058157),
      500: Color(0xFF079658),
      400: Color(0xFF36C076),
      300: Color(0xFF97F4B0),
      200: Color(0xFF97F4B0),
      100: Color(0xFFCAF9D2),
      50: Color(0xFFDEFAE3),
    },
  );
  static const int _secondaryValue = 0xFF079658;

  /// Neutral Color
  static MaterialColor neutral = const MaterialColor(
    _neutralValue,
    <int, Color>{
      900: Color(0xFF1C1C4F),
      800: Color(0xFF2E2E5F),
      700: Color(0xFF494976),
      600: Color(0xFF6A6A8D),
      500: Color(0xFF9292A5),
      400: Color(0xFFB7B7C9),
      300: Color(0xFFD4D4E3),
      200: Color(0xFFEAEAF6),
      100: Color(0xFFF5F5FF),
      50: Color(0xFFFAFAFF),
    },
  );
  static const int _neutralValue = 0xFF9292A5;

  /// Red Color
  static const MaterialColor red = MaterialColor(
    _redValue,
    <int, Color>{
      900: Color(0xFF7A082D),
      800: Color(0xFF930D2E),
      700: Color(0xFFB7152F),
      600: Color(0xFFDB1F2C),
      500: Color(0xFFFF2E2B),
      400: Color(0xFFFF6F60),
      300: Color(0xFFFF977F),
      200: Color(0xFFFFC1AA),
      100: Color(0xFFFFE3D4),
      50: Color(0xFFFFEFE6),
    },
  );
  static const int _redValue = 0xFFFF2E2B;

  /// Red Color
  static const MaterialColor yellow = MaterialColor(
    _yellowValue,
    <int, Color>{
      900: Color(0xFF643500),
      800: Color(0xFF794400),
      700: Color(0xFF965A01),
      600: Color(0xFFB37201),
      500: Color(0xFFD18C02),
      400: Color(0xFFE3B03A),
      300: Color(0xFFF1CB61),
      200: Color(0xFFFAE397),
      100: Color(0xFFFCF2CA),
      50: Color(0xFFFFF9E1),
    },
  );
  static const int _yellowValue = 0xFFD18C02;

  /// Red Color
  static const MaterialColor blue = MaterialColor(
    _bludValue,
    <int, Color>{
      900: Color(0xFF102670),
      800: Color(0xFF002459),
      700: Color(0xFF01336F),
      600: Color(0xFF024585),
      500: Color(0xFF03599B),
      400: Color(0xFF338CC3),
      300: Color(0xFF5CB6E1),
      200: Color(0xFF94DBF5),
      100: Color(0xFFC8EFFA),
      50: Color(0xFFE9FAFF),
    },
  );
  static const int _bludValue = 0xFFFF2E2B;
}

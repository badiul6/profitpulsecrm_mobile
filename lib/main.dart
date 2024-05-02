import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: ThemeData(
        primaryColor: const Color.fromRGBO(0, 117, 124, 1),
        primarySwatch: createMaterialColor(const Color.fromRGBO(0, 117, 124, 1)),
        
        scaffoldBackgroundColor: Colors.white, // Setting the common white shade as background color
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: createMaterialColor(const Color.fromRGBO(0, 117, 124, 1)),
          // acc  entColor: Colors.amber,
        ).copyWith(secondary: Colors.amber,
        onBackground: Colors.black87,
        background: Colors.white,
        onPrimary:Colors.white),
        appBarTheme: const AppBarTheme(
          backgroundColor:  Color.fromRGBO(0, 117, 124, 1),
          foregroundColor: Colors.white, // Text color on AppBar
        ),
        
      ),
    ),
  );
}

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}
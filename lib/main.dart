import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:get/get.dart';
import 'package:profitpulsecrm_mobile/app/utils/image_utils.dart';

import 'app/routes/app_pages.dart';

Future<void> main() async {

    WidgetsFlutterBinding.ensureInitialized();
       HttpOverrides.global = MyHttpOverrides();

    await dotenv.load(fileName: ".env");
  ImageUtils.svgPrecacheImage();
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      debugShowCheckedModeBanner: false,
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

 class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
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
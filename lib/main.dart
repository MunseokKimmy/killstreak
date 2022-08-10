import 'package:flutter/material.dart';
import 'package:killstreak/utils/palette.dart';
import 'package:killstreak/view/home_page.dart';

void main() {
  runApp(const MyApp());
}

const Color baseColor = Color(0xff001f3f);
const Color accentColor = Color.fromRGBO(8, 51, 88, 1);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            primary: Colors.white,
            side: const BorderSide(color: Colors.white, width: 2),
          ),
        ),
        primarySwatch: generateMaterialColor(
          baseColor,
        ),
        scaffoldBackgroundColor: baseColor,
        cardColor: baseColor,
        textTheme: Typography.whiteMountainView,
      ),
      home: const HomePage(),
    );
  }
}

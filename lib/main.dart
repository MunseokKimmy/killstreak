import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:killstreak/utils/palette.dart';
import 'package:killstreak/utils/utils.dart';
import 'package:killstreak/view/authentication/auth_page.dart';
import 'package:killstreak/view/authentication/verify_email_page.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/services.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

const Color baseColor = Color(0xff001f3f);
const Color accentColor = Color.fromRGBO(8, 51, 88, 1);
const Color lightColor = Color.fromRGBO(5, 63, 94, 1);
const Color lightGrey = Color.fromARGB(255, 234, 232, 232);
const Color white = Colors.white;

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: Utils.messengerKey,
      navigatorKey: navigatorKey,
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
      home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(lightColor)));
            } else if (snapshot.hasError) {
              return const Center(child: Text("Login failed"));
            } else if (snapshot.hasData) {
              return VerifyEmailPage();
            } else {
              return const AuthPage();
            }
          }),
    );
  }
}

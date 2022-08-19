import 'package:flutter/material.dart';
import 'package:killstreak/view/authentication/login_page.dart';
import 'package:killstreak/view/authentication/sign_up_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;
  void toggle() => setState(() {
        isLogin = !isLogin;
      });
  @override
  Widget build(BuildContext context) {
    return isLogin
        ? LoginWidget(onClickedSignUp: toggle)
        : SignUpWidget(onClickedSignIn: toggle);
  }
}

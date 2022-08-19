import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:killstreak/view/authentication/login_page.dart';
import 'package:email_validator/email_validator.dart';
import 'package:killstreak/view/authentication/sign_up_page.dart';
import '../../main.dart';
import '../../utils/utils.dart';

class AuthPage extends StatefulWidget {
  AuthPage({Key? key}) : super(key: key);

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

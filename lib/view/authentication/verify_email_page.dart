import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:killstreak/main.dart';
import 'package:killstreak/view/home_page.dart';

import '../../utils/utils.dart';

class VerifyEmailPage extends StatefulWidget {
  VerifyEmailPage({Key? key}) : super(key: key);

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;
  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      setState(() {
        canResendEmail = false;
      });
      await Future.delayed(const Duration(seconds: 30));
      setState(() {
        canResendEmail = true;
      });
    } catch (e) {
      Utils.showSnackBar(e.toString());
    }
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) timer?.cancel();
  }

  @override
  void initState() {
    super.initState();

    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(
        const Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isEmailVerified
        ? HomePage()
        : Scaffold(
            appBar: AppBar(
              title: const Text("Verify Email"),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                      "A verification email has been sent to your email. (Check spam!)",
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        primary: Colors.grey),
                    icon: const Icon(
                      Icons.email,
                      size: 32,
                      color: Colors.white,
                    ),
                    label: const Text("Resend Email",
                        style: TextStyle(fontSize: 24, color: Colors.white)),
                    onPressed: canResendEmail ? sendVerificationEmail : null,
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50)),
                    child: const Text("Cancel", style: TextStyle(fontSize: 24)),
                    onPressed: () => FirebaseAuth.instance.signOut(),
                  )
                ],
              ),
            ),
          );
  }
}

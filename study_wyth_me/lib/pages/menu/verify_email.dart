import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:study_wyth_me/pages/home/home.dart';
import 'package:study_wyth_me/services/authentication.dart';
import 'package:study_wyth_me/services/database.dart';
import 'package:study_wyth_me/shared/constants.dart';
import 'package:study_wyth_me/shared/custom_text_widgets.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({Key? key}) : super(key: key);

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  bool _verified = false;
  Timer? _timer;
  String _message = '';

  @override
  void initState() {
    super.initState();
    _verified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!_verified) {
      sendVerificationEmail();

      // periodically check if the email has been verified
      _timer = Timer.periodic(
        const Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future sendVerificationEmail() async {
    try {
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
      return 'Email sent!';
    } catch (exception) {
      return 'Please try again later.';
    }
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      _verified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (_verified) {
      _timer?.cancel();
      await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid).updateStatusToVerified();
    }
  }

  @override
  Widget build(BuildContext context) {
    return _verified ? const Home() : Scaffold(
      backgroundColor: darkBlueBackground,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget> [
                const SizedBox(height: 80.0),
                const ChewyHeaderText(text: 'Verify Email'),
                const SizedBox(height: 40.0),
                Container(
                    width: 300,
                    height: 100,
                    padding: const EdgeInsets.all(17.0),
                    decoration: smallRadiusRoundedBox,
                    child: const Text(
                      'A verification email has been sent to your email!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25.0,
                        letterSpacing: 1.1,
                        color: Colors.white,
                        fontFamily: 'Chewy',
                      ),
                    )
                ),
                const SizedBox(height: 60.0),
                Container(
                  width: 210,
                  height: 60,
                  decoration: largeRadiusRoundedBox,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(5.0),
                      primary: Colors.white,
                      textStyle: chewyTextStyle.copyWith(fontSize: 27.5),
                    ),
                    child: const Text(
                      'Resend Email',
                      textAlign: TextAlign.center,
                    ),
                    onPressed: () async {
                      String result = await sendVerificationEmail();
                      setState(() => _message = result);
                      await Future.delayed(const Duration(seconds: 1));
                      if (mounted) {
                        setState(() => _message = '');
                      }
                    },
                  ),
                ),
                gapBox,
                Container(
                  width: 100,
                  height: 40,
                  decoration: largeRadiusRoundedBox,
                  child: TextButton(
                    child: const Text('Cancel'),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(5.0),
                      primary: Colors.white,
                      textStyle: chewyTextStyle.copyWith(fontSize: 20.0),
                    ),
                    onPressed: () async {
                      await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid).deleteUserDocument();
                      await FirebaseAuth.instance.currentUser!.delete();
                      await Authentication().customSignOut();
                    },
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(
                  _message,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 12.0,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

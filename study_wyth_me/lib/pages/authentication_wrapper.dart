import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_wyth_me/models/custom_user.dart';
import 'package:study_wyth_me/pages/menu/main_menu.dart';
import 'package:study_wyth_me/pages/menu/verify_email.dart';

// direct to the MainMenu() or VerifyEmail() depending on whether user is signed in
class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomUser? _customUser = Provider.of<CustomUser?>(context);

    if (_customUser == null) { // user is signed out
      return const MainMenu();
    } else { // user is signed in
      return const VerifyEmail();
    }
  }
}

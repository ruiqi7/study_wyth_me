import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_wyth_me/models/custom_user.dart';
import 'package:study_wyth_me/pages/home.dart';
import 'package:study_wyth_me/pages/main_menu.dart';

// direct to the MainMenu() or Home() depending on whether user is signed in
class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomUser? customUser = Provider.of<CustomUser?>(context);

    if (customUser == null) { // user is signed out
      return const MainMenu();
    } else { // user is signed in
      return const Home();
    }
  }
}

import 'package:flutter/material.dart';
import 'package:study_wyth_me/models/constants.dart';
import 'package:study_wyth_me/models/custom_text_widgets.dart';

// feel free to convert it to a Stateful Widget when necessary
class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlueBackground,
      body: Center(
        child: Column (
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            const ChewyHeaderText(text: 'Sign Up'),
            gapBox,
            backButton(context)
          ]
        )
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:study_wyth_me/shared/constants.dart';
import 'package:study_wyth_me/shared/custom_text_widgets.dart';
import 'package:study_wyth_me/pages/about.dart';
import 'package:study_wyth_me/pages/sign_in.dart';
import 'package:study_wyth_me/pages/sign_up.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({Key? key}) : super(key: key);

  final double buttonWidth = 300;
  final double buttonHeight = 80;
  static ButtonStyle buttonStyle = TextButton.styleFrom(
    padding: const EdgeInsets.all(16.0),
    primary: Colors.white,
    textStyle: chewyTextStyle.copyWith(letterSpacing: 33.0),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlueBackground,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            const ChewyHeaderText(text: 'Study Wyth Me'),
            const SizedBox(height: 45),
            Container(
              width: buttonWidth,
              height: buttonHeight,
              decoration: smallRadiusRoundedBox,
              child: TextButton(
                style: buttonStyle,
                child: const Text('Welcome Back!'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignIn()),
                  );
                },
              ),
            ),
            gapBox,
            Container(
              width: buttonWidth,
              height: buttonHeight,
              decoration: smallRadiusRoundedBox,
              child: TextButton(
                style: buttonStyle,
                child: const Text('I\'m new here!'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignUp()),
                  );
                },
              ),
            ),
            gapBox,
            Container(
              width: buttonWidth,
              height: buttonHeight,
              decoration: smallRadiusRoundedBox,
              child: TextButton(
                style: buttonStyle,
                child: const Text('About'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const About()),
                  );
                },
              ),
            ),
          ],
        )
      ),
    );
  }
}
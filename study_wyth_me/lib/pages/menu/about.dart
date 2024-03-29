import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:study_wyth_me/shared/constants.dart';
import 'package:study_wyth_me/shared/custom_text_widgets.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlueBackground,
      body: Center(
        child: Column (
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            const ChewyHeaderText(text: 'About'),
            gapBox,
            Container(
              width: 300,
              height: 315,
              padding: const EdgeInsets.all(17.0),
              decoration: smallRadiusRoundedBox,
              child: const AutoSizeText(
                'This app serves as an integrated platform to help you study '
                    'better! It features a gamification system for you to '
                    'find motivation in studying, and also a discussion forum '
                    'for you to resolve your academic troubles.',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 24.1,
                  letterSpacing: 1.1,
                  color: Colors.white,
                  fontFamily: 'Chewy',
                ),
                maxLines: 9,
              ),
            ),
            gapBox,
            backButton(context)
          ],
        ),
      ),
    );
  }
}
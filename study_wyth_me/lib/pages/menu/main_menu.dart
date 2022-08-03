import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:study_wyth_me/shared/constants.dart';
import 'package:study_wyth_me/pages/menu/about.dart';
import 'package:study_wyth_me/pages/menu/sign_in.dart';
import 'package:study_wyth_me/pages/menu/sign_up.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({Key? key}) : super(key: key);

  final double _buttonWidth = 300;
  final double _buttonHeight = 80;
  static final ButtonStyle _buttonStyle = TextButton.styleFrom(
    padding: const EdgeInsets.all(16.0),
    primary: Colors.white,
    textStyle: chewyTextStyle.copyWith(fontSize: 33.0),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlueBackground,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Stack(
                children: <Widget>[
                  AutoSizeText(
                    'Study Wyth Me',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 70.0,
                      letterSpacing: 5.0,
                      fontFamily: 'Chewy',
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 5
                        ..color = Colors.white,
                    ),
                    maxLines: 2,
                  ),
                  const AutoSizeText(
                    'Study Wyth Me',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 70.0,
                      letterSpacing: 5.0,
                      fontFamily: 'Chewy',
                      color: Colors.transparent,
                      shadows: <Shadow>[
                        Shadow(
                          blurRadius: 0.0,
                          color: Colors.white70,
                          offset: Offset(3.0, 5.0),
                        )
                      ],
                    ),
                    maxLines: 2,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 45),
            Container(
              width: _buttonWidth,
              height: _buttonHeight,
              decoration: smallRadiusRoundedBox,
              child: TextButton(
                key: const Key('WelcomeBackButton'),
                style: _buttonStyle,
                child: const AutoSizeText('Welcome Back!', maxLines: 1),
                onPressed: () {
                  Navigator.push(
                    context,
                    PageTransition(child: const SignIn(), type: PageTransitionType.rightToLeftPop, childCurrent: this)
                  );
                },
              ),
            ),
            gapBox,
            Container(
              width: _buttonWidth,
              height: _buttonHeight,
              decoration: smallRadiusRoundedBox,
              child: TextButton(
                key: const Key('ImNewHereButton'),
                style: _buttonStyle,
                child: const AutoSizeText('I\'m new here!', maxLines: 1),
                onPressed: () {
                  Navigator.push(
                    context,
                    PageTransition(child: const SignUp(), type: PageTransitionType.rightToLeftPop, childCurrent: this)
                  );
                },
              ),
            ),
            gapBox,
            Container(
              width: _buttonWidth,
              height: _buttonHeight,
              decoration: smallRadiusRoundedBox,
              child: TextButton(
                key: const Key('AboutButton'),
                style: _buttonStyle,
                child: const AutoSizeText('About', maxLines: 1),
                onPressed: () {
                  Navigator.push(
                    context,
                    PageTransition(child: const About(), type: PageTransitionType.rightToLeftPop, childCurrent: this)
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
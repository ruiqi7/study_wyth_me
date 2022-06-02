import 'package:flutter/material.dart';
import 'package:study_wyth_me/shared/constants.dart';
import 'package:study_wyth_me/pages/menu/about.dart';
import 'package:study_wyth_me/pages/menu/sign_in.dart';
import 'package:study_wyth_me/pages/menu/sign_up.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({Key? key}) : super(key: key);

  final double buttonWidth = 300;
  final double buttonHeight = 80;
  static ButtonStyle buttonStyle = TextButton.styleFrom(
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
                  Text(
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
                  ),
                  const Text(
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
                  )
                ],
              ),
            ),
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
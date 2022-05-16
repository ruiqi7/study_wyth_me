import 'package:flutter/material.dart';
import 'package:study_wyth_me/main.dart';
import 'package:study_wyth_me/custom_text_widgets.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  final SizedBox gapBox = const SizedBox(height: 15);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColour,
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
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Color.fromRGBO(255, 255, 255, 0.15)
                    ),
                    child: const Text(
                      'This app serves as an integrated platform to help you study '
                          'better! It features a gamification system for you to '
                          'find motivation in studying, and also a discussion forum '
                          'for you to resolve your academic troubles.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 24.1,
                          letterSpacing: 1.1,
                          color: Colors.white,
                          fontFamily: 'Chewy'
                      ),
                    )
                ),
                gapBox,
                Container(
                  width: 100,
                  height: 50,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: Color.fromRGBO(255, 255, 255, 0.15)
                  ),
                  child: TextButton(
                    child: const Text('Back'),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(10.0),
                      primary: Colors.white,
                      textStyle: const TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          letterSpacing: 1.5,
                          fontFamily: 'Chewy'
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                )
              ]
          )
      ),
    );
  }
}
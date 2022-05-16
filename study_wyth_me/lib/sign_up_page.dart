import 'package:flutter/material.dart';
import 'package:study_wyth_me/custom_text_widgets.dart';
import 'package:study_wyth_me/main.dart';

// feel free to convert it to a Stateful Widget when necessary
class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  final SizedBox gapBox = const SizedBox(height: 15);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColour,
      body: Center(
          child: Column (
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget> [
                const ChewyHeaderText(text: 'Sign Up'),
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
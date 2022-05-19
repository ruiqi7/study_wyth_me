import 'package:flutter/material.dart';

// Header using the Chewy Font used for the Main, Sign In, Sign Up, About etc. pages
class ChewyHeaderText extends StatelessWidget {

  final String text;

  const ChewyHeaderText({
    Key? key,
    required this.text
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontSize: 70.0,
            letterSpacing: 5.0,
            color: Colors.white,
            fontFamily: 'Chewy'
        ),
      ),
    );
  }
}
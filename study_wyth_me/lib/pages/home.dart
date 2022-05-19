import 'package:flutter/material.dart';
import 'package:study_wyth_me/models/constants.dart';
import 'package:study_wyth_me/models/bar_widgets.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final int _position = 1; // used to identify which button in the bottom to darken

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlueBackground,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            Row(
              children: <Widget> [
                Expanded(
                  child: Container(
                    color: whiteOpacity20,
                    height: 75.0
                  )
                ),
              ]
            ),
            gapBox,
            bottomBar(context, _position)
          ],
        )
      )
    );
  }
}

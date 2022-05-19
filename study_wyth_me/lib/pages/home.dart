import 'package:flutter/material.dart';
import 'package:study_wyth_me/models/constants.dart';
import 'package:study_wyth_me/models/bar_widgets.dart';
import 'package:study_wyth_me/services/authentication.dart';

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
                    height: 75.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget> [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Container(
                            width: 80,
                            height: 40,
                            decoration: largeRadiusRoundedBox,
                            child: TextButton(
                              child: const Text('Logout'),
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.all(5.0),
                                primary: Colors.white,
                                textStyle: const TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.white,
                                    letterSpacing: 1.5,
                                    fontFamily: 'Chewy'
                                ),
                              ),
                              onPressed: () async {
                                await Authentication().customSignOut();
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
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
import 'package:flutter/material.dart';
import 'package:study_wyth_me/models/constants.dart';
import 'package:study_wyth_me/models/bar_widgets.dart';

class Timer extends StatefulWidget {
  const Timer({Key? key}) : super(key: key);

  @override
  State<Timer> createState() => _TimerState();
}

class _TimerState extends State<Timer> {

  final _position = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlueBackground,
      body: Center(
        child: bottomBar(context, _position)
      )
    );
  }
}

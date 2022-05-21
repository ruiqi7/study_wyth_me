import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:study_wyth_me/shared/constants.dart';
import 'package:study_wyth_me/shared/bar_widgets.dart';

import 'countdown.dart';

class Timer extends StatefulWidget {
  const Timer({Key? key}) : super(key: key);

  @override
  State<Timer> createState() => _TimerState();
}

class _TimerState extends State<Timer> {

  final _position = 3;


  Duration currDuration = const Duration(minutes: 30);

  // This shows a CupertinoModalPopup with a reasonable fixed height which hosts CupertinoTimerPicker.
  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
          height: 250,
          padding: const EdgeInsets.only(top: 6.0),
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          color: darkBlueBackground,
          // Use a SafeArea widget to avoid system overlaps.
          child: SafeArea(
            top: false,
            child: CupertinoTheme(
              data: const CupertinoThemeData(
                brightness: Brightness.dark
              ),
              child: CupertinoTimerPicker(
                mode: CupertinoTimerPickerMode.hm,
                initialTimerDuration: currDuration,
                onTimerDurationChanged: (Duration newDuration) {
                  setState(() => currDuration = newDuration);
                },
              ),
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final hours = currDuration.inHours.remainder(24).toString().length < 2 ? "0" + currDuration.inHours.remainder(24).toString() : currDuration.inHours.remainder(24).toString();
    final minutes = currDuration.inMinutes.remainder(60).toString().length < 2 ? "0" + currDuration.inMinutes.remainder(60).toString() : currDuration.inMinutes.remainder(60).toString();
    final seconds = currDuration.inSeconds.remainder(60).toString().length < 2 ? "0" + currDuration.inSeconds.remainder(60).toString() : currDuration.inSeconds.remainder(60).toString();
    return Scaffold(
      backgroundColor: darkBlueBackground,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            Container(
              width: 230,
              height: 230,
              decoration: const BoxDecoration(
                color: whiteOpacity15,
                shape: BoxShape.circle,
              ),
              child: CupertinoButton(
                // Display a CupertinoTimerPicker with hour/minute mode.
                onPressed: () => _showDialog(widget),
                child: Text(
                  '$hours:$minutes:$seconds',
                  style: const TextStyle(
                    fontSize: 43.0,
                    fontFamily: 'Chewy',
                    color: Colors.white,
                    letterSpacing: 3.0,
                  ),
                ),
              ),
            ),
            gapBox,
            Container(
              width: 100,
              height: 40,
              decoration: largeRadiusRoundedBox,
              child: TextButton(
                child: const Text('Start'),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(5.0),
                  primary: Colors.white,
                  textStyle: chewyTextStyle.copyWith(fontSize: 20.0),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Countdown(duration: currDuration)),
                  );
                },
              ),
            ),
            const Icon(
              Icons.arrow_right_alt_rounded,
              color: Colors.white,
              size: 50.0
            ),
            bottomBar(context, _position)
          ],
        )
      )
    );
  }
}

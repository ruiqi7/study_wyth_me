import 'package:flutter/material.dart';
import 'package:study_wyth_me/shared/constants.dart';
import 'dart:async';

class Countdown extends StatefulWidget {
  final Duration duration;
  const Countdown({
    Key? key,
    required this.duration
  }) : super(key: key);

  @override
  State<Countdown> createState() => _CountdownState();
}

class _CountdownState extends State<Countdown> {
  late Timer countdownTimer;
  late Duration currDuration = widget.duration;

  @override
  void initState() {
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _tick();
    });
    super.initState();
  }

  @override
  void dispose() {
    countdownTimer.cancel();
    super.dispose();
  }

  void _tick() {
    setState(() {
      int newSeconds = currDuration.inSeconds - 1;
      if (newSeconds < 0) {
        countdownTimer.cancel();
      } else {
        currDuration = Duration(seconds: newSeconds);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final hours = currDuration.inHours.remainder(24).toString().length < 2 ? "0" + currDuration.inHours.remainder(24).toString() : currDuration.inHours.remainder(24).toString();
    final minutes = currDuration.inMinutes.remainder(60).toString().length < 2 ? "0" + currDuration.inMinutes.remainder(60).toString() : currDuration.inMinutes.remainder(60).toString();
    final seconds = currDuration.inSeconds.remainder(60).toString().length < 2 ? "0" + currDuration.inSeconds.remainder(60).toString() : currDuration.inSeconds.remainder(60).toString();
    //startCountdown();
    return Scaffold(
      backgroundColor: darkBlueBackground,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            Text(
              '$hours:$minutes:$seconds',
              style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Chewy',
                  letterSpacing: 7.0,
                  fontSize: 60),
            ),
            gapBox,
            Container(
              width: 100,
              height: 40,
              decoration: largeRadiusRoundedBox,
              child: TextButton(
                child: const Text('Cancel'),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(5.0),
                  primary: Colors.white,
                  textStyle: const TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      letterSpacing: 1.5,
                      fontFamily: 'Chewy'
                  ),
                ),
                onPressed: () {
                  setState(() {countdownTimer.cancel();});
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        )
      ),
    );
  }
}

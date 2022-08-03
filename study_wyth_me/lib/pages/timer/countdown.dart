import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:study_wyth_me/services/notification.dart';
import 'package:study_wyth_me/shared/constants.dart';
import 'package:study_wyth_me/services/database.dart';

class Countdown extends StatefulWidget {
  final Duration duration;
  final String module;
  final String uid;
  const Countdown({
    Key? key,
    required this.duration,
    required this.module,
    required this.uid
  }) : super(key: key);

  @override
  State<Countdown> createState() => _CountdownState();
}

class _CountdownState extends State<Countdown> with WidgetsBindingObserver{
  late Timer _countdownTimer;
  late Duration _currDuration = widget.duration;
  bool _displayDone = false;

  @override
  void initState() {
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _tick();
    });
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    _countdownTimer.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _tick() {
    setState(() {
      int newSeconds = _currDuration.inSeconds - 1;
      if (newSeconds < 0) {
        _countdownTimer.cancel();
        _displayDone = true;
        NotificationService().showNotification(widget.duration, widget.module);
      } else {
        _currDuration = Duration(seconds: newSeconds);
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _countdownTimer.cancel();
      NotificationService().showPausedNotification(widget.duration, widget.module);
      Navigator.pop(context);
    }

    if (state == AppLifecycleState.detached) {
      _countdownTimer.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    final hours = _currDuration.inHours.remainder(24).toString().length < 2 ? "0" + _currDuration.inHours.remainder(24).toString() : _currDuration.inHours.remainder(24).toString();
    final minutes = _currDuration.inMinutes.remainder(60).toString().length < 2 ? "0" + _currDuration.inMinutes.remainder(60).toString() : _currDuration.inMinutes.remainder(60).toString();
    final seconds = _currDuration.inSeconds.remainder(60).toString().length < 2 ? "0" + _currDuration.inSeconds.remainder(60).toString() : _currDuration.inSeconds.remainder(60).toString();
    return Scaffold(
      backgroundColor: darkBlueBackground,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            AutoSizeText(
              '$hours:$minutes:$seconds',
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'Chewy',
                letterSpacing: 7.0,
                fontSize: 60,
              ),
              maxLines: 1,
            ),
            gapBox,
            Container(
              width: 100,
              height: 40,
              decoration: largeRadiusRoundedBox,
              child: TextButton(
                key: _displayDone ? const Key('CountdownDoneButton') : const Key('CountdownCancelButton'),
                child: AutoSizeText(_displayDone ? 'Done' : 'Cancel', maxLines: 1),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(5.0),
                  primary: Colors.white,
                  textStyle: chewyTextStyle.copyWith(fontSize: 20.0),
                ),
                onPressed: () async {
                  if (_displayDone) {
                    await NotificationService().cancelNotification();
                    await DatabaseService(uid: widget.uid).updateModule(widget.module, widget.duration.inMinutes);
                  }
                  setState(() {
                    _countdownTimer.cancel();
                  });
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

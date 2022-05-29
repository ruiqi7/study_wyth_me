import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:study_wyth_me/pages/edit_modules.dart';
import 'package:study_wyth_me/shared/constants.dart';
import 'package:study_wyth_me/shared/bar_widgets.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import '../models/app_user.dart';
import '../services/database.dart';
import 'countdown.dart';
import 'loading.dart';


class Timer extends StatefulWidget {
  const Timer({Key? key}) : super(key: key);

  @override
  State<Timer> createState() => _TimerState();
}

class _TimerState extends State<Timer> {

  final String uid = FirebaseAuth.instance.currentUser!.uid;

  // passed into navigation bar to identify which page we are on
  final _position = 3;
  final Duration _minDuration = const Duration(minutes: 1);
  final _formKey = GlobalKey<FormState>();

  bool _hideStartButton = false;

  bool changedDuration = false;
  late Duration _currDuration;

  String? _currentModule;

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
                brightness: Brightness.dark // turns the picker text white
              ),
              child: CupertinoTimerPicker(
                mode: CupertinoTimerPickerMode.hm,
                initialTimerDuration: _currDuration,
                onTimerDurationChanged: (Duration newDuration) async {
                  setState(() => newDuration.compareTo(_minDuration) > 0 ? _currDuration = newDuration : _currDuration = _minDuration);
                  await DatabaseService(uid: uid).updateDuration(newDuration.inMinutes);
                },
              ),
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AppUser>(
      stream: DatabaseService(uid: uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          AppUser appUser = snapshot.data!;

          var modules = [];
          appUser.map.forEach((k, v) => modules.add(k));

          if (!changedDuration) {
            _currDuration = Duration(minutes: appUser.duration);
            changedDuration = true;
          }
          final hours = _currDuration.inHours.remainder(24).toString().length < 2 ? "0" + _currDuration.inHours.remainder(24).toString() : _currDuration.inHours.remainder(24).toString();
          final minutes = _currDuration.inMinutes.remainder(60).toString().length < 2 ? "0" + _currDuration.inMinutes.remainder(60).toString() : _currDuration.inMinutes.remainder(60).toString();
          final seconds = _currDuration.inSeconds.remainder(60).toString().length < 2 ? "0" + _currDuration.inSeconds.remainder(60).toString() : _currDuration.inSeconds.remainder(60).toString();

          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: darkBlueBackground,
            appBar: appBar(context, uid),
            body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 60.0),
                    Container(
                      width: 230,
                      height: 230,
                      decoration: const BoxDecoration(
                        color: whiteOpacity15,
                        shape: BoxShape.circle,
                      ),
                      child: CupertinoButton(
                        // Display a CupertinoTimerPicker with hour/minute mode.
                        onPressed: () {
                          _showDialog(widget);
                        },
                        child: Text(
                          '$hours:$minutes:$seconds',
                          style: chewyTextStyle.copyWith(fontSize: 42, letterSpacing: 3)
                        ),
                      ),
                    ),
                    const SizedBox(height: 25.0),
                    Row(
                      children: [
                        Expanded(
                          child: Form(
                            key: _formKey,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 100.0),
                              child: DropdownButtonFormField2(
                                decoration: InputDecoration(
                                  fillColor: const Color.fromRGBO(
                                      255, 255, 255, 0.10),
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide.none
                                  ),
                                  contentPadding: const EdgeInsets.fromLTRB(
                                      15.0, 10.0, 5.0, 10.0),
                                  hintText: 'Choose a Module',
                                  hintStyle: chewyTextStyle.copyWith(fontSize: 16.0)
                                ),
                                icon: const Icon(
                                    Icons.keyboard_arrow_down_sharp),
                                iconEnabledColor: Colors.white,
                                iconSize: 30,
                                buttonHeight: 35.0,
                                dropdownDecoration: smallRadiusRoundedBox,
                                dropdownElevation: 0,
                                dropdownMaxHeight: 145.0,
                                itemHeight: 45.0,
                                scrollbarAlwaysShow: false,
                                scrollbarRadius: const Radius.circular(50.0),
                                scrollbarThickness: 6,
                                hint: Text(
                                  'Select a module',
                                  style: chewyTextStyle.copyWith(fontSize: 18.0)
                                ),
                                items: modules.map((module) {
                                  return DropdownMenuItem<String>(
                                    value: module,
                                    child: SizedBox(
                                      width: 145.0,
                                      height: 26.0,
                                      child: Text(
                                        module,
                                        style: chewyTextStyle.copyWith(fontSize: 20.0),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) =>
                                    setState(() {
                                      _currentModule = value as String;
                                    }),
                                value: _currentModule,
                                validator: (value) {
                                  if (value == null) {
                                    return 'Please select a module.';
                                  } else {
                                    return null;
                                  }
                                },
                                onMenuStateChange: (isOpen) {
                                  setState(() => _hideStartButton = isOpen);
                                },
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 5.0, right: 40.0, bottom: 5.0),
                          child: IconButton(
                            icon: const Icon(Icons.edit, color: Colors.white),
                            iconSize: 33,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => EditModules(uid: uid)),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 30.0),
                    !_hideStartButton ? Container(
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
                          if (_formKey.currentState!.validate()) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>
                                  Countdown(duration: _currDuration, module: _currentModule!, uid: uid)),
                            );
                          }
                        },
                      ),
                    )
                        : const SizedBox(
                      width: 100,
                      height: 40,
                    ),
                  ],
                )
            ),
            bottomNavigationBar: navigationBar(context, _position),
          );
        } else {
          return const Loading();
        }
      }
    );
  }
}

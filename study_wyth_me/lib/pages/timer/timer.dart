import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:page_transition/page_transition.dart';
import 'package:study_wyth_me/pages/timer/edit_modules.dart';
import 'package:study_wyth_me/shared/constants.dart';
import 'package:study_wyth_me/shared/bar_widgets.dart';
import 'package:study_wyth_me/models/app_user.dart';
import 'package:study_wyth_me/services/database.dart';
import 'package:study_wyth_me/pages/timer/countdown.dart';
import 'package:study_wyth_me/pages/loading.dart';

class Timer extends StatefulWidget {
  const Timer({Key? key}) : super(key: key);

  @override
  State<Timer> createState() => _TimerState();
}

class _TimerState extends State<Timer> {

  final String _uid = FirebaseAuth.instance.currentUser!.uid;

  // passed into navigation bar to identify which page we are on
  final _position = 3;
  final _formKey = GlobalKey<FormState>();

  bool _hideStartButton = false;

  bool _changedDuration = false;
  late Duration _currDuration;

  String? _currentModule;

  // to indicate if the selected duration is 0
  String _message = '';

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
                key: const Key('CupertinoTimerPicker'),
                mode: CupertinoTimerPickerMode.hm,
                initialTimerDuration: _currDuration,
                onTimerDurationChanged: (Duration newDuration) async {
                  setState(() => _currDuration = newDuration);
                  await DatabaseService(uid: _uid).updateDuration(newDuration.inMinutes);
                },
              ),
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AppUser>(
      stream: DatabaseService(uid: _uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          AppUser appUser = snapshot.data!;

          var modules = [];
          appUser.map.forEach((k, v) => modules.add(k));

          if (!_changedDuration) {
            _currDuration = Duration(minutes: appUser.duration);
            _changedDuration = true;
          }
          final hours = _currDuration.inHours.remainder(24).toString().length < 2 ? "0" + _currDuration.inHours.remainder(24).toString() : _currDuration.inHours.remainder(24).toString();
          final minutes = _currDuration.inMinutes.remainder(60).toString().length < 2 ? "0" + _currDuration.inMinutes.remainder(60).toString() : _currDuration.inMinutes.remainder(60).toString();
          final seconds = _currDuration.inSeconds.remainder(60).toString().length < 2 ? "0" + _currDuration.inSeconds.remainder(60).toString() : _currDuration.inSeconds.remainder(60).toString();

          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: darkBlueBackground,
            appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(75.0),
                  child: Container(
                    color: whiteOpacity20,
                    child: appBar(context, _uid),
                  )
              ),
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
                        key: const Key('CircularTimerIcon'),
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
                                key: const Key('DropdownMenu'),
                                decoration: InputDecoration(
                                  fillColor: whiteOpacity10,
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide.none
                                  ),
                                  contentPadding: const EdgeInsets.fromLTRB(15.0, 10.0, 5.0, 10.0),
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
                            key: const Key('EditModulesButton'),
                            icon: const Icon(Icons.edit, color: Colors.white),
                            iconSize: 33,
                            onPressed: () {
                              Navigator.push(
                                context,
                                PageTransition(child: EditModules(uid: _uid), type: PageTransitionType.bottomToTop)
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
                        key: const Key('StartTimerButton'),
                        child: const Text('Start'),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.all(5.0),
                          primary: Colors.white,
                          textStyle: chewyTextStyle.copyWith(fontSize: 20.0),
                        ),
                        onPressed: () {
                          if (_currDuration == const Duration()) {
                            setState(() => _message = 'Please select a duration.');
                            Future.delayed(const Duration(seconds: 1), () {
                              if (mounted) {
                                setState(() => _message = '');
                              }
                            });
                          } else if (_formKey.currentState!.validate()) {
                            Navigator.push(
                              context,
                              PageTransition(child: Countdown(duration: _currDuration, module: _currentModule!, uid: _uid), type: PageTransitionType.fade)
                            );
                          }
                        },
                      ),
                    ) : const SizedBox(
                      width: 100,
                      height: 40,
                    ),
                    gapBoxH10,
                    Text(
                      _message,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                )
            ),
            bottomNavigationBar: Container(
              color: whiteOpacity20,
              child: navigationBar(context, _position),
            )
          );
        } else {
          return const Loading();
        }
      }
    );
  }
}

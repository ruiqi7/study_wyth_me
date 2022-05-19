import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:study_wyth_me/models/constants.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: darkBlueBackground,
      body: Center(
        child: SpinKitFadingFour(
          color: Colors.white,
        )
      )
    );
  }
}

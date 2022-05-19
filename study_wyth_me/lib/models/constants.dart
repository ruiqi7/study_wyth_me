import 'package:flutter/material.dart';

const darkBlueBackground = Color.fromRGBO(0, 34, 75, 1.0);

const whiteOpacity15 = Color.fromRGBO(255, 255, 255, 0.15);

const whiteOpacity20 = Color.fromRGBO(255, 255, 255, 0.2);

const SizedBox gapBox = SizedBox(height: 15);

const BoxDecoration smallRadiusRoundedBox = BoxDecoration(
  borderRadius: BorderRadius.all(Radius.circular(10)),
  color: whiteOpacity15,
);

const BoxDecoration largeRadiusRoundedBox = BoxDecoration(
  borderRadius: BorderRadius.all(Radius.circular(30)),
  color: whiteOpacity15,
);

backButton(context) => Container(
  width: 100,
  height: 50,
  decoration: largeRadiusRoundedBox,
  child: TextButton(
    child: const Text('Back'),
    style: TextButton.styleFrom(
      padding: const EdgeInsets.all(10.0),
      primary: Colors.white,
      textStyle: const TextStyle(
          fontSize: 20.0,
          color: Colors.white,
          letterSpacing: 1.5,
          fontFamily: 'Chewy'
      ),
    ),
    onPressed: () {
      Navigator.pop(context);
    },
  ),
);
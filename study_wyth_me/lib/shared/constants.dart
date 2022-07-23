import 'package:flutter/material.dart';
import 'package:study_wyth_me/shared/bar_widgets.dart';

const darkBlueBackground = Color.fromRGBO(0, 34, 75, 1.0);
const darkBlueOpacity50 = Color.fromRGBO(0, 34, 75, 0.5);

const whiteOpacity10 = Color.fromRGBO(255, 255, 255, 0.10);
const whiteOpacity15 = Color.fromRGBO(255, 255, 255, 0.15);
const whiteOpacity20 = Color.fromRGBO(255, 255, 255, 0.20);
const whiteOpacity70 = Color.fromRGBO(255, 255, 255, 0.70);

const SizedBox gapBox = SizedBox(height: 15);
const SizedBox gapBoxH10 = SizedBox(height: 10);
const SizedBox emptyBox = SizedBox(height: 0, width: 0);

const BoxDecoration smallRadiusRoundedBox = BoxDecoration(
  borderRadius: BorderRadius.all(Radius.circular(10)),
  color: whiteOpacity15,
);

const BoxDecoration largeRadiusRoundedBox = BoxDecoration(
  borderRadius: BorderRadius.all(Radius.circular(30)),
  color: whiteOpacity15,
);

const TextStyle chewyTextStyle = TextStyle(
  fontFamily: 'Chewy',
  letterSpacing: 1.5,
  color: Colors.white,
);

const TextStyle norwesterTextStyle = TextStyle(
  fontFamily: 'Norwester',
  color: Colors.white,
);

const TextStyle oswaldTextStyle = TextStyle(
  fontFamily: 'Oswald',
  letterSpacing: 0.5,
  height: 1.2,
);

backButton(context) => Container(
  width: 100,
  height: 40,
  decoration: largeRadiusRoundedBox,
  child: TextButton(
    child: const Text('Back'),
    style: TextButton.styleFrom(
      padding: const EdgeInsets.all(5.0),
      primary: Colors.white,
      textStyle: chewyTextStyle.copyWith(fontSize: 20.0),
    ),
    onPressed: () {
      Navigator.pop(context);
    },
  ),
);

appBarButton(text, function) => Padding(
  padding: const EdgeInsets.only(right: 10.0),
  child: Container(
    width: 80,
    height: 40,
    decoration: largeRadiusRoundedBox,
    child: TextButton(
      key: Key(text),
      child: Text(text),
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(5.0),
        primary: Colors.white,
        textStyle: chewyTextStyle.copyWith(fontSize: 16.0),
      ),
      onPressed: function,
    ),
  ),
);

const InputDecoration formFieldDeco = InputDecoration(
  fillColor: whiteOpacity15,
  filled: true,
  hintStyle: TextStyle(color: Colors.white),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: whiteOpacity15,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.white,
      width: 2.0,
    ),
  ),
  isDense: true,
  contentPadding: EdgeInsets.all(10.0),
);

const InputDecoration forumFormFieldDeco = InputDecoration(
  hintStyle: TextStyle(color: Colors.white),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.transparent,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.transparent,
      width: 2.0,
    ),
  ),
  isDense: true,
  contentPadding: EdgeInsets.all(10.0),
);

backIcon(context) => IconButton(
  key: const Key('BackIcon'),
  icon: const Icon(
    Icons.arrow_back_ios,
    color: Colors.white,
    size: 35,
  ),
  onPressed: () {
    Navigator.pop(context);
  },
);

closeIcon(context) => Container(
  key: const Key('CloseIcon'),
  margin: const EdgeInsets.only(bottom: 10.0),
  child: IconButton(
    icon: const Icon(
      Icons.close,
      color: Colors.white,
      size: 45,
    ),
    onPressed: () {
      Navigator.pop(context);
    },
  ),
);

const horizontalDivider = Divider(color: Colors.white);
const noHeightHorizontalDivider = Divider(color: Colors.white, height: 0.0);

construction(context, uid, _position) => Scaffold(
  backgroundColor: darkBlueBackground,
  appBar: appBar(context, uid),
  body: Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column (
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            Text(
              'This page is under construction! Stay tuned for more updates!',
              style: chewyTextStyle.copyWith(fontSize: 25.0),
            ),
          ],
        ),
      )
  ),
  bottomNavigationBar: navigationBar(context, _position),
);

String timeDifference(int timestamp) {
  DateTime timeNow = DateTime.now();
  DateTime timePosted = DateTime.fromMillisecondsSinceEpoch(timestamp);
  Duration timeDifference = timeNow.difference(timePosted);

  int days = timeDifference.inDays;
  int hours = timeDifference.inHours;
  int minutes = timeDifference.inMinutes;
  if (days > 0) {
    if (days != 1) {
      return '$days days ago';
    } else {
      return '1 day ago';
    }
  } else if (hours > 0) {
    if (hours != 1) {
      return '$hours hours ago';
    } else {
      return '1 hour ago';
    }
  } else if (minutes > 0) {
    if (minutes != 1) {
      return '$minutes minutes ago';
    } else {
      return '1 minute ago';
    }
  } else {
    return 'just now';
  }
}

alertDialogue(context, message) => showDialog<String>(
    context: context,
    builder: (context) {
      var width = MediaQuery.of(context).size.width;
      return AlertDialog(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
        contentPadding: EdgeInsets.zero,
        insetPadding: const EdgeInsets.symmetric(horizontal: 60),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget> [
            SizedBox(
              height: 50,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.only(top: 25.0),
                  child: Text(
                    message,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            gapBox,
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                alignment: Alignment.center,
                height: 50,
                width: width,
                child: const Text(
                  'OK',
                  style: TextStyle(
                    color: Colors.lightBlue,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
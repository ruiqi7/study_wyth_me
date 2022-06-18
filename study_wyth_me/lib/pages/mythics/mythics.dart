import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:study_wyth_me/pages/loading.dart';
import '../../models/app_user.dart';
import '../../services/database.dart';
import '../../shared/bar_widgets.dart';
import '../../shared/constants.dart';
import 'dart:math' as math;

class Mythics extends StatefulWidget {
  const Mythics({Key? key}) : super(key: key);

  @override
  State<Mythics> createState() => _MythicsState();
}

class _MythicsState extends State<Mythics> {

  final String uid = FirebaseAuth.instance.currentUser!.uid;
  final _position = 5;
  final Map<String, int> _mythicNumbers = {
    'Chimera': 1,
    'Kraken': 2,
    'Phoenix': 3,
    'Dragon': 4,
    'Manticore': 5,
    'Unicorn': 6,
    'Catfish': 7,
    'Griffin': 8,
    'Kitsune': 9,
    'Pegasus': 10,
  };
  final SizedBox divider = const SizedBox(width: 25);
  late int _currPoints;

  Widget _mythicBox(bool obtained, String mythicName) {
    int points = _mythicNumbers[mythicName]! * 1000;
    return Column(
      children: <Widget> [
        Container(
          width: 150,
          height: 150,
          decoration: largeRadiusRoundedBox,
          child: obtained ? Image.asset('assets/images/mythics/'+ mythicName + '.png') : Center(
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: <Widget> [
                const Icon(
                  Icons.question_mark_rounded,
                  color: whiteOpacity70,
                  size: 100,
                ),
                Transform.rotate(
                  angle: -math.pi / 4,
                  child: Container(
                    width: 213,
                    height: 40,
                    decoration: largeRadiusRoundedBox.copyWith(color: darkBlueOpacity50),
                    child: Center(
                      child: Text(
                        points.toString() + ' points',
                        style: norwesterTextStyle.copyWith(fontSize: 25),
                      ),
                    ),
                  ),
                ),
              ]
            ),
          )
        ),
        const SizedBox(height: 10),
        obtained ? SizedBox(
          width: 120,
          height: 35,
          child: Center(
            child: Text(
              mythicName,
              style: chewyTextStyle.copyWith(fontSize: 21),
            ),
          ),
        ) : Container(
          width: 80,
          height: 35,
          decoration: largeRadiusRoundedBox,
          child: Center(
            child: TextButton(
              child: Text(
                'Claim!',
                style: chewyTextStyle.copyWith(fontSize: 17),
              ),
              onPressed: () async {
                if (_currPoints >= points) {
                  await DatabaseService(uid: uid).claimMythic(mythicName);
                } else {
                  showDialog<String>(
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
                                  child: const Text(
                                    "Insufficient points to claim!",
                                    style: TextStyle(
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
                }
              },
            ),
          )
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    List<String> _mythicsNames = _mythicNumbers.keys.toList();

    return StreamBuilder<AppUser>(
      stream: DatabaseService(uid: uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          AppUser appUser = snapshot.data!;
          _currPoints = appUser.points;
          return Scaffold(
            backgroundColor: darkBlueBackground,
            appBar: appBar(context, uid),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                gapBox,
                Text(
                  'My Mythics',
                  style: norwesterTextStyle.copyWith(fontSize: 30, letterSpacing: 1.2),
                ),
                gapBox,
                Center(
                  child: Container(
                    width: 170,
                    height: 50,
                    decoration: largeRadiusRoundedBox,
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                            appUser.points.toString(),
                            style: norwesterTextStyle.copyWith(fontSize: 30)
                        ),
                        const SizedBox(width: 10.0),
                        Text(
                            'points',
                            style: norwesterTextStyle.copyWith(fontSize: 20)
                        )
                      ]
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget> [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget> [
                            _mythicBox(appUser.mythics[_mythicsNames[0]], _mythicsNames[0]),
                            _mythicBox(appUser.mythics[_mythicsNames[1]], _mythicsNames[1]),
                          ],
                        ),
                        divider,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget> [
                            _mythicBox(appUser.mythics[_mythicsNames[2]], _mythicsNames[2]),
                            _mythicBox(appUser.mythics[_mythicsNames[3]], _mythicsNames[3])
                          ],
                        ),
                        divider,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget> [
                            _mythicBox(appUser.mythics[_mythicsNames[4]], _mythicsNames[4]),
                            _mythicBox(appUser.mythics[_mythicsNames[5]], _mythicsNames[5])
                          ],
                        ),
                        divider,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget> [
                            _mythicBox(appUser.mythics[_mythicsNames[6]], _mythicsNames[6]),
                            _mythicBox(appUser.mythics[_mythicsNames[7]], _mythicsNames[7])
                          ],
                        ),
                        divider,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget> [
                            _mythicBox(appUser.mythics[_mythicsNames[8]], _mythicsNames[8]),
                            _mythicBox(appUser.mythics[_mythicsNames[9]], _mythicsNames[9])
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
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

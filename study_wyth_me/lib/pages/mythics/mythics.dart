import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:study_wyth_me/pages/loading.dart';
import 'package:study_wyth_me/models/app_user.dart';
import 'package:study_wyth_me/services/database.dart';
import 'package:study_wyth_me/shared/bar_widgets.dart';
import 'package:study_wyth_me/shared/constants.dart';
import 'dart:math' as math;

class Mythics extends StatefulWidget {
  const Mythics({Key? key}) : super(key: key);

  @override
  State<Mythics> createState() => _MythicsState();
}

class _MythicsState extends State<Mythics> {

  final String _uid = FirebaseAuth.instance.currentUser!.uid;
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
                      child: AutoSizeText(
                        points.toString() + ' points',
                        style: norwesterTextStyle.copyWith(fontSize: 25),
                        maxLines: 1,
                      ),
                    ),
                  ),
                ),
              ]
            ),
          )
        ),
        gapBoxH10,
        obtained ? SizedBox(
          width: 120,
          height: 35,
          child: Center(
            child: AutoSizeText(
              mythicName,
              style: chewyTextStyle.copyWith(fontSize: 21),
              maxLines: 1,
            ),
          ),
        ) : Container(
          width: 80,
          height: 35,
          decoration: largeRadiusRoundedBox,
          child: Center(
            child: TextButton(
              key: const Key('ClaimButton'),
              child: AutoSizeText(
                'Claim!',
                style: chewyTextStyle.copyWith(fontSize: 17),
                maxLines: 1,
              ),
              onPressed: () async {
                if (_currPoints >= points) {
                  await DatabaseService(uid: _uid).claimMythic(mythicName);
                } else {
                  alertDialogue(context, 'Insufficient points to claim!');
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
      stream: DatabaseService(uid: _uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          AppUser appUser = snapshot.data!;
          _currPoints = appUser.points;
          return Scaffold(
            backgroundColor: darkBlueBackground,
            appBar: PreferredSize(
                preferredSize: const Size.fromHeight(75.0),
                child: Container(
                  color: whiteOpacity20,
                  child: appBar(context, _uid),
                )
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                gapBox,
                AutoSizeText(
                  'My Mythics',
                  style: norwesterTextStyle.copyWith(fontSize: 30, letterSpacing: 1.2),
                  maxLines: 1,
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
                        AutoSizeText(
                          key: const Key('MythicsPoints'),
                          appUser.points.toString(),
                          style: norwesterTextStyle.copyWith(fontSize: 30),
                          maxLines: 1,
                        ),
                        const SizedBox(width: 10.0),
                        AutoSizeText(
                          'points',
                          style: norwesterTextStyle.copyWith(fontSize: 20),
                          maxLines: 1,
                        )
                      ]
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: ListView(
                      key: const Key('MythicsCollection'),
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
            bottomNavigationBar: Container(
              color: whiteOpacity20,
              child: navigationBar(context, _position),
            ),
          );
        } else {
          return const Loading();
        }
      }
    );
  }
}

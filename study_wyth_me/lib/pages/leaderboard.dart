import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:study_wyth_me/main.dart';
import 'package:study_wyth_me/models/app_user.dart';
import '../services/database.dart';
import '../shared/bar_widgets.dart';
import '../shared/constants.dart';
import 'loading.dart';

class Leaderboard extends StatefulWidget {
  const Leaderboard({Key? key}) : super(key: key);

  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {

  final String uid = FirebaseAuth.instance.currentUser!.uid;
  final _position = 4;
  bool _isContainer = true;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AppUser>(
      stream: DatabaseService(uid: uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          AppUser appUser = snapshot.data!;
          return Scaffold(
            backgroundColor: darkBlueBackground,
            appBar: appBar(context, uid),
            body: Column(
              children: <Widget> [
                gapBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget> [
                    const Icon(
                      Icons.emoji_events_rounded,
                      color: Colors.white,
                      size: 150,
                    ),
                    const SizedBox(width: 25),
                    Column(
                      children: <Widget> [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget> [
                            Text(
                                appUser.points.toString(),
                                style: norwesterTextStyle.copyWith(fontSize: 30)
                            ),
                            const SizedBox(width: 15.0),
                            Text(
                              'points',
                              style: norwesterTextStyle.copyWith(fontSize: 20)
                            )
                          ],
                        ),
                        gapBox,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget> [
                            Text(
                                '2nd',
                                style: norwesterTextStyle.copyWith(fontSize: 30)
                            ),
                            const SizedBox(width: 15.0),
                            Text(
                                'rank',
                                style: norwesterTextStyle.copyWith(fontSize: 20)
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
                gapBox,
                Container(
                  height: 62,
                  width: 300,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: whiteOpacity15,
                      width: 7,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget> [
                      Center(
                        child: Container(
                          height: 48,
                          width: 143,
                          color: _isContainer ? whiteOpacity15 : const Color.fromRGBO(255, 255, 255, 0.0),
                          child: TextButton(
                            child: Text(
                              'Community',
                              style: chewyTextStyle.copyWith(fontSize: 21),
                            ),
                            onPressed: () {
                              if (!_isContainer) {
                                print("going community");
                              }
                            },
                          )
                        ),
                      ),
                      Center(
                        child: Container(
                          height: 48,
                          width: 143,
                          color: !_isContainer ? whiteOpacity15 : const Color.fromRGBO(255, 255, 255, 0.0),
                          child: TextButton(
                            child: Text(
                              'Friends',
                              style: chewyTextStyle.copyWith(fontSize: 21),
                            ),
                            onPressed: () {
                              if (_isContainer) {
                                print("going friends");
                              }
                            },
                          )
                        ),
                      )
                    ],
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

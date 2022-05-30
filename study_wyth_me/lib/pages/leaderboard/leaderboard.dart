import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_wyth_me/main.dart';
import 'package:study_wyth_me/models/app_user.dart';
import '../../services/database.dart';
import '../../shared/bar_widgets.dart';
import '../../shared/constants.dart';
import '../loading.dart';
import 'leaderboard_list.dart';

class Leaderboard extends StatefulWidget {
  const Leaderboard({Key? key}) : super(key: key);

  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {

  final String uid = FirebaseAuth.instance.currentUser!.uid;
  final _position = 4;
  bool _isCommunity = true;

  Widget displayBoard(List<String> list) {
    if (list.isNotEmpty) {
      return StreamProvider<List<AppUser>>.value(
        value: DatabaseService(uid: uid).userLeaderboardStream(_isCommunity, list),
        initialData: const [],
        child: const Expanded(child: LeaderboardList()),
      );
    } else {
      return const SizedBox(height: 10);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AppUser>(
      stream: DatabaseService(uid: uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          AppUser appUser = snapshot.data!;
          List<dynamic> friendsUsername = appUser.friendsUsername;
          List<String> list = [];
          friendsUsername.forEach((e) {list.add(e.toString());});
          return Scaffold(
            backgroundColor: darkBlueBackground,
            appBar: appBar(context, uid),
            body: Container(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Column(
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
                            color: _isCommunity ? whiteOpacity15 : const Color.fromRGBO(255, 255, 255, 0.0),
                            child: TextButton(
                              child: Text(
                                'Community',
                                style: chewyTextStyle.copyWith(fontSize: 21),
                              ),
                              onPressed: () {
                                if (!_isCommunity) {
                                  setState(() => _isCommunity = !_isCommunity);
                                }
                              },
                            )
                          ),
                        ),
                        Center(
                          child: Container(
                            height: 48,
                            width: 143,
                            color: !_isCommunity ? whiteOpacity15 : const Color.fromRGBO(255, 255, 255, 0.0),
                            child: TextButton(
                              child: Text(
                                'Friends',
                                style: chewyTextStyle.copyWith(fontSize: 21),
                              ),
                              onPressed: () {
                                if (_isCommunity) {
                                  setState(() => _isCommunity = !_isCommunity);
                                }
                              },
                            )
                          ),
                        )
                      ],
                    ),
                  ),
                  gapBox,
                  horizontalDivider,
                  displayBoard(list),
                  Text(
                    !_isCommunity ? 'yolo' : ''
                  ),
                ],
              ),
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

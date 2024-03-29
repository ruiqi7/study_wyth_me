import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:study_wyth_me/models/app_user.dart';
import 'package:study_wyth_me/services/database.dart';
import 'package:study_wyth_me/shared/bar_widgets.dart';
import 'package:study_wyth_me/shared/constants.dart';
import 'package:study_wyth_me/pages/loading.dart';
import 'package:study_wyth_me/pages/leaderboard/edit_friends.dart';
import 'package:study_wyth_me/pages/leaderboard/leaderboard_list.dart';

class Leaderboard extends StatefulWidget {
  const Leaderboard({Key? key}) : super(key: key);

  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {

  final String _uid = FirebaseAuth.instance.currentUser!.uid;
  final _position = 4;
  bool _isCommunity = true;

  String _getRank(int rank) {
    int lastDigit = rank % 10;
    if (lastDigit == 1 && rank != 11) {
      return '${rank}st';
    } else if (lastDigit == 2 && rank != 12) {
      return '${rank}nd';
    } else if (lastDigit == 3 && rank != 13) {
      return '${rank}rd';
    } else {
      return '${rank}th';
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AppUser>(
      stream: DatabaseService(uid: _uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          AppUser appUser = snapshot.data!;

          return StreamBuilder<List<AppUser>>(
            stream: DatabaseService(uid: _uid).userLeaderboardStream(_isCommunity, appUser.friendsId),
            builder: (BuildContext context, AsyncSnapshot<List<AppUser>> querySnapshot) {
              if (querySnapshot.hasData) {
                List<AppUser> userList = querySnapshot.data!;
                userList.sort((a, b) => b.compareTo(a));
                int _rank = userList.indexWhere((element) => element.username == appUser.username) + 1; // assuming usernames are unique

                return Scaffold(
                  backgroundColor: darkBlueBackground,
                  appBar: PreferredSize(
                    preferredSize: const Size.fromHeight(75.0),
                    child: Container(
                      color: whiteOpacity20,
                      child: appBar(context, _uid),
                    )
                  ),
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
                            SizedBox(
                              width: 125.0,
                              child: Column(
                                children: <Widget> [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget> [
                                      Expanded(
                                        child: AutoSizeText(
                                          key: const Key('LeaderboardPoints'),
                                          appUser.points.toString(),
                                          style: norwesterTextStyle.copyWith(fontSize: 30),
                                          textAlign: TextAlign.center,
                                          maxLines: 1,
                                        ),
                                      ),
                                      const SizedBox(width: 15.0),
                                      Expanded(
                                        child: AutoSizeText(
                                          'points',
                                          style: norwesterTextStyle.copyWith(fontSize: 20),
                                          maxLines: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                  gapBox,
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget> [
                                      Expanded(
                                        child: AutoSizeText(
                                          key: const Key('Rank'),
                                          _getRank(_rank),
                                          style: norwesterTextStyle.copyWith(fontSize: 30),
                                          maxLines: 1,
                                        ),
                                      ),
                                      const SizedBox(width: 15.0),
                                      Expanded(
                                        child: AutoSizeText(
                                          'rank',
                                          style: norwesterTextStyle.copyWith(fontSize: 20),
                                          maxLines: 1,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
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
                                    color: _isCommunity ? whiteOpacity15 : Colors.transparent,
                                    child: TextButton(
                                      child: AutoSizeText(
                                        'Community',
                                        style: chewyTextStyle.copyWith(fontSize: 21),
                                        maxLines: 1,
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
                                    color: !_isCommunity ? whiteOpacity15 : Colors.transparent,
                                    child: TextButton(
                                      key: const Key('FriendsButton'),
                                      child: AutoSizeText(
                                        'Friends',
                                        style: chewyTextStyle.copyWith(fontSize: 21),
                                        maxLines: 1,
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
                        noHeightHorizontalDivider,
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              StreamProvider<List<AppUser>>.value(
                                value: DatabaseService(uid: _uid).userLeaderboardStream(_isCommunity, appUser.friendsId),
                                initialData: const [],
                                child: Flexible(
                                    child: LeaderboardList(username: appUser.username)
                                ),
                              ),
                              !_isCommunity ? Container(
                                width: 200,
                                height: 40,
                                margin: const EdgeInsets.symmetric(vertical: 15.0),
                                decoration: largeRadiusRoundedBox,
                                child: TextButton(
                                  key: const Key('AddFriendButton'),
                                  child: const AutoSizeText('Add a new friend!', maxLines: 1,),
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.all(5.0),
                                    primary: Colors.white,
                                    textStyle: chewyTextStyle.copyWith(fontSize: 20.0),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        PageTransition(child: const EditFriends(), type: PageTransitionType.bottomToTop)
                                    );
                                  },
                                ),
                              )
                                  : const SizedBox(
                                width: 100,
                                height: 40,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
        } else {
          return const Loading();
        }
      }
    );
  }
}

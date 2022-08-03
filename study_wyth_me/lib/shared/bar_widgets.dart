import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:study_wyth_me/shared/constants.dart';
import 'package:study_wyth_me/models/app_user.dart';
import 'package:study_wyth_me/pages/forum/forum.dart';
import 'package:study_wyth_me/pages/home/edit_profile.dart';
import 'package:study_wyth_me/pages/home/home.dart';
import 'package:study_wyth_me/pages/leaderboard/leaderboard.dart';
import 'package:study_wyth_me/pages/mythics/mythics.dart';
import 'package:study_wyth_me/pages/timer/timer.dart';
import 'package:study_wyth_me/services/database.dart';

const oswaldText = TextStyle(
  fontFamily: 'Oswald',
  fontSize: 12.5,
  color: Colors.white
);

navigationBar(context, position) => SafeArea(
  key: const Key('NavigationBar'),
  child: Row(
    children: <Widget> [
      Expanded(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            color: Colors.transparent,
            height: 75.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget> [
                Container(
                  width: 65,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: position == 1 ? const Color.fromRGBO(0, 34, 75, 0.5) : const Color.fromRGBO(0, 34, 75, 0.0),
                  ),
                  child: TextButton(
                    key: const Key('HomeTab'),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget> [
                        Icon(
                          Icons.home,
                          color: Colors.white,
                        ),
                        Text(
                          'Home',
                          style: oswaldText,
                        )
                      ],
                    ),
                    onPressed: () {
                      if (position > 1) {
                        Navigator.push(
                          context,
                          PageTransition(child: const Home(), type: PageTransitionType.leftToRight)
                        );
                      } else if (position < 1) {
                        Navigator.push(
                            context,
                            PageTransition(child: const Home(), type: PageTransitionType.rightToLeft)
                        );
                      }
                    },
                  ),
                ),
                Container(
                  width: 65,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: position == 2 ? const Color.fromRGBO(0, 34, 75, 0.5) : const Color.fromRGBO(0, 34, 75, 0.0),
                  ),
                  child: TextButton(
                    key: const Key('forumTab'),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget> [
                        Icon(
                          Icons.forum_rounded,
                          color: Colors.white,
                        ),
                        Text(
                          'Forum',
                          style: oswaldText,
                        )
                      ],
                    ),
                    onPressed: () {
                      if (position > 2) {
                        Navigator.push(
                          context,
                          PageTransition(child: const Forum(), type: PageTransitionType.leftToRight)
                        );
                      } else if (position < 2) {
                        Navigator.push(
                            context,
                            PageTransition(child: const Forum(), type: PageTransitionType.rightToLeft)
                        );
                      }
                    },
                  ),
                ),
                Container(
                  width: 75,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: position == 3 ? const Color.fromRGBO(0, 34, 75, 0.5) : const Color.fromRGBO(0, 34, 75, 0.0),
                  ),
                  child: TextButton(
                    key: const Key('TimerTab'),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget> [
                        Icon(
                          Icons.timer,
                          color: Colors.white,
                        ),
                        Text(
                          'Study Timer',
                          style: oswaldText,
                        )
                      ],
                    ),
                    onPressed: () {
                      if (position > 3) {
                        Navigator.push(
                          context,
                            PageTransition(child: const Timer(), type: PageTransitionType.leftToRight)
                        );
                      } else if (position < 3) {
                        Navigator.push(
                            context,
                            PageTransition(child: const Timer(), type: PageTransitionType.rightToLeft)
                        );
                      }
                    },
                  ),
                ),
                Container(
                  width: 75,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: position == 4 ? const Color.fromRGBO(0, 34, 75, 0.5) : const Color.fromRGBO(0, 34, 75, 0.0),
                  ),
                  child: TextButton(
                    key: const Key('LeaderboardTab'),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget> [
                        Icon(
                          Icons.emoji_events_rounded,
                          color: Colors.white,
                        ),
                        Text(
                          'Leaderboard',
                          style: oswaldText,
                        )
                      ],
                    ),
                    onPressed: () {
                      if (position > 4) {
                        Navigator.push(
                          context,
                            PageTransition(child: const Leaderboard(), type: PageTransitionType.leftToRight)
                        );
                      } else if (position < 4) {
                        Navigator.push(
                            context,
                            PageTransition(child: const Leaderboard(), type: PageTransitionType.rightToLeft)
                        );
                      }
                    },
                  ),
                ),
                Container(
                  width: 65,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: position == 5 ? const Color.fromRGBO(0, 34, 75, 0.5) : const Color.fromRGBO(0, 34, 75, 0.0),
                  ),
                  child: TextButton(
                    key: const Key('MythicsTab'),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget> [
                        Icon(
                          Icons.pets_rounded,
                          color: Colors.white,
                        ),
                        Text(
                          'Mythics',
                          style: oswaldText,
                        )
                      ],
                    ),
                    onPressed: () {
                      if (position > 5) {
                        Navigator.push(
                          context,
                          PageTransition(child: const Mythics(), type: PageTransitionType.leftToRight)
                        );
                      } else if (position < 5) {
                        Navigator.push(
                            context,
                            PageTransition(child: const Mythics(), type: PageTransitionType.rightToLeft)
                        );
                      }
                    },
                  ),
                )
              ],
            ),
          )
      ),
    ]
  ),
);

appBar(context, uid) => PreferredSize(
  preferredSize: const Size.fromHeight(75),
  child: SafeArea(
    child: Container(
      color: Colors.transparent,
      height: 75.0,
      child: StreamBuilder<AppUser>(
        stream: DatabaseService(uid: uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            AppUser appUser = snapshot.data!;
            return Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                child: TextButton(
                  child: Row(
                    children: <Widget>[
                      Material(
                        elevation: 0,
                        shape: const CircleBorder(),
                        clipBehavior: Clip.hardEdge,
                        color: Colors.transparent,
                        child: Ink.image(
                          key: const Key('HomeProfilePicture'),
                          image: NetworkImage(appUser.url),
                          fit: BoxFit.cover,
                          width: 50.0,
                          height: 50.0,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            key: const Key('HomeUsername'),
                            appUser.username,
                            style: chewyTextStyle.copyWith(fontSize: 27.5),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EditProfile(
                            username: appUser.username,
                            url: appUser.url
                        ))
                    );
                  },
                ),
              ),
            );
          } else {
            return Container(
              color: whiteOpacity20,
              height: 75.0,
            );
          }
        }
      ),
    ),
  ),
);

topBarWithBackButton(context) => PreferredSize(
  preferredSize: const Size.fromHeight(75),
  child: SafeArea(
    child: Container(
      color: whiteOpacity20,
      height: 75.0,
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 5.0, bottom: 5.0),
            child: backIcon(context),
          ),
          const Expanded(
            child: SizedBox(),
          ),
        ],
      ),
    ),
  ),
);
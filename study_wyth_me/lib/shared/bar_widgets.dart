import 'package:flutter/material.dart';
import 'package:study_wyth_me/shared/constants.dart';

import '../models/app_user.dart';
import '../pages/loading.dart';
import '../services/database.dart';

const oswaldTextStyle = TextStyle(
  fontFamily: 'Oswald',
  fontSize: 12.5,
  color: Colors.white
);

navigationBar(context, position) => SafeArea(
  child: Row(
    children: <Widget> [
      Expanded(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            color: whiteOpacity20,
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget> [
                        Icon(
                          Icons.home,
                          color: Colors.white,
                        ),
                        Text(
                          'Home',
                          style: oswaldTextStyle,
                        )
                      ],
                    ),
                    onPressed: () {
                      if (position != 1) {
                        Navigator.pushNamed(context, '/home');
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget> [
                        Icon(
                          Icons.forum_rounded,
                          color: Colors.white,
                        ),
                        Text(
                          'Forum',
                          style: oswaldTextStyle,
                        )
                      ],
                    ),
                    onPressed: () {
                      if (position != 2) {
                        Navigator.pushNamed(context, '/forum');
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget> [
                        Icon(
                          Icons.timer,
                          color: Colors.white,
                        ),
                        Text(
                          'Study Timer',
                          style: oswaldTextStyle,
                        )
                      ],
                    ),
                    onPressed: () {
                      if (position != 3) {
                        Navigator.pushNamed(context, '/timer');
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget> [
                        Icon(
                          Icons.emoji_events_rounded,
                          color: Colors.white,
                        ),
                        Text(
                          'Leaderboard',
                          style: oswaldTextStyle,
                        )
                      ],
                    ),
                    onPressed: () {
                      if (position != 4) {
                        Navigator.pushNamed(context, '/leaderboard');
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget> [
                        Icon(
                          Icons.pets_rounded,
                          color: Colors.white,
                        ),
                        Text(
                          'Mythics',
                          style: oswaldTextStyle,
                        )
                      ],
                    ),
                    onPressed: () {
                      if (position != 5) {
                        Navigator.pushNamed(context, '/mythics');
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
      color: whiteOpacity20,
      height: 75.0,
      child: StreamBuilder<AppUser>(
        stream: DatabaseService(uid: uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            AppUser appUser = snapshot.data!;
            return Row(
              //mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget> [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: CircleAvatar(
                    radius: 25.0,
                    backgroundImage: NetworkImage(appUser.url),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      appUser.username,
                      style: chewyTextStyle.copyWith(fontSize: 27.5),
                    ),
                  ),
                ),
              ],
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
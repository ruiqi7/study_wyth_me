import 'package:flutter/material.dart';
import 'package:study_wyth_me/shared/constants.dart';

bottomBar(context, position) => Row(
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
                          style: TextStyle(
                              fontFamily: 'Oswald',
                              fontSize: 12.5,
                              color: Colors.white
                          ),
                        )
                      ],
                    ),
                    onPressed: () {  },
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
                          style: TextStyle(
                              fontFamily: 'Oswald',
                              fontSize: 12.5,
                              color: Colors.white
                          ),
                        )
                      ],
                    ),
                    onPressed: () {  },
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
                          style: TextStyle(
                              fontFamily: 'Oswald',
                              fontSize: 12.5,
                              color: Colors.white
                          ),
                        )
                      ],
                    ),
                    onPressed: () {  },
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
                          style: TextStyle(
                              fontFamily: 'Oswald',
                              fontSize: 12.5,
                              color: Colors.white
                          ),
                        )
                      ],
                    ),
                    onPressed: () {  },
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
                          style: TextStyle(
                              fontFamily: 'Oswald',
                              fontSize: 12.5,
                              color: Colors.white
                          ),
                        )
                      ],
                    ),
                    onPressed: () {  },
                  ),
                )
              ],
            ),
          )
      ),
    ]
);
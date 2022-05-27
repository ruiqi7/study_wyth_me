import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../shared/constants.dart';

class Leaderboard extends StatefulWidget {
  const Leaderboard({Key? key}) : super(key: key);

  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {

  final String uid = FirebaseAuth.instance.currentUser!.uid;
  final _position = 4;

  @override
  Widget build(BuildContext context) {
    return construction(context, uid, _position);
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../shared/constants.dart';

class Forum extends StatefulWidget {
  const Forum({Key? key}) : super(key: key);

  @override
  State<Forum> createState() => _ForumState();
}

class _ForumState extends State<Forum> {

  final String uid = FirebaseAuth.instance.currentUser!.uid;
  final _position = 2;

  @override
  Widget build(BuildContext context) {
    return construction(context, uid, _position);
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../shared/constants.dart';

class Mythics extends StatefulWidget {
  const Mythics({Key? key}) : super(key: key);

  @override
  State<Mythics> createState() => _MythicsState();
}

class _MythicsState extends State<Mythics> {

  final String uid = FirebaseAuth.instance.currentUser!.uid;
  final _position = 5;

  @override
  Widget build(BuildContext context) {
    return construction(context, uid, _position);
  }
}

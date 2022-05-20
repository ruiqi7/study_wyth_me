import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:study_wyth_me/shared/constants.dart';
import 'package:study_wyth_me/shared/bar_widgets.dart';
import 'package:study_wyth_me/services/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/app_user.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final int _position = 1; // used to identify which button in the bottom to darken
  //late DocumentSnapshot snapshot;
  //Future<DocumentSnapshot<Object?>> futureSnap = FirebaseFirestore.instance.collection('userDatabase')
  //    .doc(FirebaseAuth.instance.currentUser!.uid).get()
  //    .then((DocumentSnapshot snap) => (final snapshot = snap));
  // commented part below this line is from https://firebase.google.com/docs/firestore/query-data/get-data but i failed to duplicate
  //final DocumentReference docRef = FirebaseFirestore.instance.collection('userDatabase')
  //    .doc(FirebaseAuth.instance.currentUser!.uid);
  //docRef.get().then(
  //  (DocumentSnapshot doc) {
  //    final data = doc.data() as Map<String, dynamic>;
  //  };
  //another Idea I haven't explored is the identify the exact document from a string of snapshots

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlueBackground,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            Row(
              children: <Widget> [
                Expanded(
                  child: Container(
                    color: whiteOpacity20,
                    height: 75.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget> [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Container(
                            width: 80,
                            height: 40,
                            decoration: largeRadiusRoundedBox,
                            child: TextButton(
                              child: const Text('Logout'),
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.all(5.0),
                                primary: Colors.white,
                                textStyle: const TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.white,
                                    letterSpacing: 1.5,
                                    fontFamily: 'Chewy'
                                ),
                              ),
                              onPressed: () async {
                                await Authentication().customSignOut();
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ]
            ),
            gapBox,
            bottomBar(context, _position)
          ],
        )
      )
    );
  }
}
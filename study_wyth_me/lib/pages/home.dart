import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_wyth_me/pages/main_menu.dart';
import 'package:study_wyth_me/shared/constants.dart';
import 'package:study_wyth_me/shared/bar_widgets.dart';
import 'package:study_wyth_me/services/authentication.dart';
import 'package:fl_chart/fl_chart.dart';

import '../models/app_user.dart';
import '../models/custom_user.dart';
import '../services/database.dart';
import 'edit_profile.dart';
import 'loading.dart';

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

  // determines whether to display loading screen
  bool _loading = false;

  @override
  Widget build(BuildContext context) {

    //final CustomUser customUser = Provider.of<CustomUser>(context);
    final User? authUser = FirebaseAuth.instance.currentUser;
    if (authUser == null) {
      return const Loading();
    } else {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      return StreamBuilder<AppUser>(
        stream: DatabaseService(uid: uid).userData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              AppUser appUser = snapshot.data!;
              return Scaffold(
                backgroundColor: darkBlueBackground,
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SafeArea(
                      child: Container(
                        color: whiteOpacity20,
                        height: 75.0,
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Material(
                                elevation: 0,
                                shape: const CircleBorder(),
                                clipBehavior: Clip.hardEdge,
                                color: Colors.transparent,
                                child: Ink.image(
                                  image: NetworkImage(appUser.url),
                                  fit: BoxFit.cover,
                                  width: 50.0,
                                  height: 50.0,
                                  child: InkWell(
                                    splashColor: darkBlueBackground,
                                    onTap: () {
                                      Future.delayed(const Duration(milliseconds: 100), () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => EditProfile(url: appUser.url))
                                        );
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Text(
                                  appUser.username,
                                  style: chewyTextStyle.copyWith(fontSize: 27.5),
                                ),
                              ),
                            ),
                            appBarButton(
                              'Logout',
                              () async {
                                setState(() => _loading = true);
                                await Authentication().customSignOut();
                                Navigator.pushNamed(context, '/');
                              }
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 40.0),
                    Container(
                      width: 300,
                      height: 100,
                      decoration: smallRadiusRoundedBox,
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                          children: const <Widget>[
                            Text(
                              '1,576',
                              style: TextStyle(
                                  fontFamily: 'Norwester',
                                  fontSize: 35,
                                  color: Colors.white
                              ),
                            ),
                            SizedBox(height: 5.0),
                            Text(
                              'points',
                              style: TextStyle(
                                  fontFamily: 'Norwester',
                                  fontSize: 22.5,
                                  color: Colors.white
                              ),
                            )
                          ]
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 50.0),
                      child: const Text(
                        'My Week',
                        style: TextStyle(
                            fontFamily: 'Norwester',
                            fontSize: 19.5,
                            color: Colors.white
                        ),
                      ),
                    ),
                    Expanded(
                      child: PieChart(
                          PieChartData(
                            sectionsSpace: 0,
                            centerSpaceRadius: 80.0,
                            sections: [
                              PieChartSectionData(
                                radius: 70,
                                color: Colors.blue[500],
                                value: 2,
                                title: 'first section',
                                titleStyle: chewyTextStyle.copyWith(
                                    fontSize: 20.0),
                              ),
                              PieChartSectionData(
                                radius: 70,
                                color: Colors.blue[700],
                                value: 1,
                                title: 'second section',
                                titleStyle: chewyTextStyle.copyWith(
                                    fontSize: 20.0),
                              ),
                              PieChartSectionData(
                                radius: 70,
                                color: Colors.blue[900],
                                value: 3,
                                title: 'third section',
                                titleStyle: chewyTextStyle.copyWith(
                                    fontSize: 20.0),
                              )
                            ],
                          )
                      ),
                    ),
                  ],
                ),
                bottomNavigationBar: navigationBar(context, _position),
              );
            } else {
              return const MainMenu();
            }
          } else {
            return const Loading();
          }
        }
      );
    }

  }
}
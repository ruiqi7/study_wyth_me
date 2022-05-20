import 'package:flutter/material.dart';
import 'package:study_wyth_me/shared/constants.dart';
import 'package:study_wyth_me/shared/bar_widgets.dart';
import 'package:study_wyth_me/services/authentication.dart';
import 'package:fl_chart/fl_chart.dart';

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget> [
          SafeArea(
            child: Container(
              color: whiteOpacity20,
              height: 75.0,
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget> [
                  const Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage('https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg'),
                    ),
                  ),
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Username',
                        style: TextStyle(
                            fontSize: 27.5,
                            color: Colors.white,
                            letterSpacing: 1.5,
                            fontFamily: 'Chewy'
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Container(
                      width: 80,
                      height: 40,
                      decoration: largeRadiusRoundedBox,
                      child: TextButton(
                        child: const Text('Logout'),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.all(5.0),
                          primary: Colors.white,
                          textStyle: chewyTextStyle.copyWith(fontSize: 16.0),
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
          const SizedBox(height: 40.0),
          Container(
            width: 300,
            height: 100,
            decoration: smallRadiusRoundedBox,
            padding: const EdgeInsets.all(10.0),
            child: Column(
                children: const <Widget> [
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
                    titleStyle: chewyTextStyle.copyWith(fontSize: 20.0),
                  ),
                  PieChartSectionData(
                    radius: 70,
                    color: Colors.blue[700],
                    value: 1,
                    title: 'second section',
                    titleStyle: chewyTextStyle.copyWith(fontSize: 20.0),
                  ),
                  PieChartSectionData(
                    radius: 70,
                    color: Colors.blue[900],
                    value: 3,
                    title: 'third section',
                    titleStyle: chewyTextStyle.copyWith(fontSize: 20.0),
                  )
                ],
              )
            ),
          ),
          bottomBar(context, _position)
        ],
      )
    );
  }
}
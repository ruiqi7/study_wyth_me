import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:study_wyth_me/pages/main_menu.dart';
import 'package:study_wyth_me/shared/constants.dart';
import 'package:study_wyth_me/shared/bar_widgets.dart';
import 'package:study_wyth_me/services/authentication.dart';
import 'package:fl_chart/fl_chart.dart';

import '../models/app_user.dart';
import '../services/database.dart';
import 'edit_profile.dart';
import 'loading.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  // passed into navigation bar to identify which page we are on
  final int _position = 1;

  // determines whether to display loading screen
  bool _loading = false;

  List<PieChartSectionData> showSections(AppUser appUser) {
    List<PieChartSectionData> list = [];
    int index = 0;
    int hours = 0;
    appUser.map.forEach((key, value) {hours += (value as int); });
    int size = appUser.map.length;
    if (hours == 0) {
      list.add(PieChartSectionData(
        radius: 70,
        color: Colors.blue[700],
        value: 1,
        title: "Use Study Timer to get started!",
        titlePositionPercentageOffset: -1.15,
        titleStyle: chewyTextStyle.copyWith(fontSize: 20).apply(backgroundColor: whiteOpacity20)
      ));
    } else {
      double incrementer = (900 - 500) / (size - 1);
      for (MapEntry<String, dynamic> e in appUser.map.entries) {
        list.add(
            PieChartSectionData(
              radius: 70,
              color: Colors.blue[(500 + index * incrementer).ceil()],
              value: e.value.toDouble(),
              title: e.key,
              titleStyle: chewyTextStyle.copyWith(fontSize: 20.0),
            )
        );
        index++;
      }
    }
    return list;
  }

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
                          children: <Widget>[
                            Text(
                              appUser.points.toString(),
                              style: norwesterTextStyle.copyWith(fontSize: 35)
                            ),
                            const SizedBox(height: 5.0),
                            Text(
                              'points',
                              style: norwesterTextStyle.copyWith(fontSize: 22.5)
                            )
                          ]
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 50.0),
                      child: Text(
                        'My Week',
                        style: norwesterTextStyle.copyWith(fontSize: 19.5)
                      ),
                    ),
                    Expanded(
                      child: PieChart(
                        //dataMap: dataMap,
                        PieChartData(
                          sectionsSpace: 0,
                          centerSpaceRadius: 80.0,
                          sections: showSections(appUser),
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
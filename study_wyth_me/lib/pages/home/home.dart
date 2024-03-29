import 'package:auto_size_text/auto_size_text.dart';
import 'package:cron/cron.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:study_wyth_me/pages/menu/main_menu.dart';
import 'package:study_wyth_me/shared/constants.dart';
import 'package:study_wyth_me/shared/bar_widgets.dart';
import 'package:study_wyth_me/services/authentication.dart';
import 'package:study_wyth_me/models/app_user.dart';
import 'package:study_wyth_me/services/database.dart';
import 'package:study_wyth_me/pages/home/edit_profile.dart';
import 'package:study_wyth_me/pages/loading.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  // passed into navigation bar to identify which page we are on
  final int _position = 1;

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
    } else if (size == 1) {
      list.add(PieChartSectionData(
        radius: 70,
        color: Colors.blue[700],
        value: 1,
        title: appUser.map.keys.first,
        titleStyle: chewyTextStyle.copyWith(fontSize: 20),
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
    final User? authUser = FirebaseAuth.instance.currentUser;
    if (authUser == null) {
      return const Loading();
    } else {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      final DatabaseService databaseService = DatabaseService(uid: uid);

      // for the case when the user keeps the app running when Monday comes
      final Cron cron = Cron();
      cron.schedule(Schedule.parse('0 0 * * 1'), () async {
        databaseService.resetModule();
      });

      // for the case when the app is not running when Monday comes
      if (DateTime.now().weekday == DateTime.monday) {
        databaseService.resetModule();
      } else {
        databaseService.updateResetStatus();
      }

      return StreamBuilder<AppUser>(
        stream: databaseService.userData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              AppUser appUser = snapshot.data!;
              return Scaffold(
                appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(75.0),
                  child: Container(
                    color: whiteOpacity20,
                    child: SafeArea(
                      child: Container(
                        color: Colors.transparent,
                        height: 75.0,
                        child: Row(
                          children: <Widget>[
                            Expanded(
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
                                          padding: const EdgeInsets.only(left: 10.0),
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
                            ),
                            IconButton(
                              //icon: const Icon(Icons.help, color: whiteOpacity15),
                              icon: const Icon(Icons.help_outline_rounded, color: Colors.white),
                              iconSize: 25,
                              onPressed: () {
                                alertDialogue(
                                  context,
                                  'Accumulate points to claim mythical creatures and '
                                    'climb the leaderboards! You will receive 1 '
                                    'point per like on your posts or comments '
                                    'in the Forum and 1 point per minute clocked '
                                    'using the Study Timer, provided the duration '
                                    'is at least 30 minutes.'
                                );
                              },
                            ),
                            appBarButton(
                              'Logout',
                                  () async {
                                await Authentication().customSignOut();
                                Navigator.pushNamed(context, '/');
                              }
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                backgroundColor: darkBlueBackground,
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 40.0),
                    Container(
                      width: 300,
                      height: 100,
                      decoration: smallRadiusRoundedBox,
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                          children: <Widget>[
                            AutoSizeText(
                              key: const Key('HomePoints'),
                              appUser.points.toString(),
                              style: norwesterTextStyle.copyWith(fontSize: 35.0),
                              maxLines: 1,
                            ),
                            const SizedBox(height: 5.0),
                            AutoSizeText(
                              appUser.points != 1 ? 'points' : 'point',
                              style: norwesterTextStyle.copyWith(fontSize: 22.5),
                              maxLines: 1,
                            )
                          ]
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 50.0),
                      child: AutoSizeText(
                        'My Week',
                        style: norwesterTextStyle.copyWith(fontSize: 19.5),
                        maxLines: 1,
                      ),
                    ),
                    Expanded(
                      child: PieChart(
                        //dataMap: dataMap,
                        key: const Key('HomeRingChart'),
                        PieChartData(
                          sectionsSpace: 0,
                          centerSpaceRadius: 80.0,
                          sections: showSections(appUser),
                        )
                      ),
                    ),
                  ],
                ),
                bottomNavigationBar: Container(
                  color: whiteOpacity20,
                  child: navigationBar(context, _position),
                )
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
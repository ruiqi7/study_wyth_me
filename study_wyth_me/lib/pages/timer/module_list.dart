import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:study_wyth_me/pages/loading.dart';
import 'package:study_wyth_me/models/app_user.dart';
import 'package:study_wyth_me/services/database.dart';
import 'package:study_wyth_me/pages/timer/module_card.dart';

class ModuleList extends StatefulWidget {
  const ModuleList({Key? key}) : super(key: key);

  @override
  State<ModuleList> createState() => _ModuleListState();
}

class _ModuleListState extends State<ModuleList> {

  @override
  Widget build(BuildContext context) {
    final String uid = FirebaseAuth.instance.currentUser!.uid;
    return StreamBuilder<AppUser>(
      stream: DatabaseService(uid: uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          AppUser appUser = snapshot.data!;
          var list = [];
          appUser.map.forEach((k, v) => list.add(k));
          return ListView.builder(
            itemCount: list.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return ModuleCard(module: list[index], uid: uid);
            },
          );
        } else {
          return const Loading();
        }
      }
    );
  }
}

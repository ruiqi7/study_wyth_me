import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_wyth_me/pages/leaderboard/user_card.dart';

import '../../models/app_user.dart';

class LeaderboardList extends StatefulWidget {
  const LeaderboardList({Key? key}) : super(key: key);

  @override
  State<LeaderboardList> createState() => _LeaderboardListState();
}

class _LeaderboardListState extends State<LeaderboardList> {
  @override
  Widget build(BuildContext context) {
    final appUsers = Provider.of<List<AppUser>>(context);
    return ListView.builder(
      shrinkWrap: true,
      itemCount: appUsers.length <= 20 ? appUsers.length : 20,
      itemBuilder: (context, index) {
        return UserCard(appUser: appUsers[index], rank: index);
      }
    );
  }
}

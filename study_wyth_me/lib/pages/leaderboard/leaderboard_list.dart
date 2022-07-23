import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_wyth_me/pages/leaderboard/user_card.dart';
import 'package:study_wyth_me/models/app_user.dart';

class LeaderboardList extends StatefulWidget {

  final String username;

  const LeaderboardList({
    required this.username,
    Key? key
  }) : super(key: key);

  @override
  State<LeaderboardList> createState() => _LeaderboardListState();
}

class _LeaderboardListState extends State<LeaderboardList> {
  @override
  Widget build(BuildContext context) {
    final appUsers = Provider.of<List<AppUser>>(context);
    List<AppUser> list = [];
    for (var e in appUsers) {
      list.add(e);
    }
    list.sort((a, b) => b.compareTo(a));

    return ListView.builder(
      shrinkWrap: true,
      itemCount: list.length <= 20 ? list.length : 20,
      itemBuilder: (context, index) {
        return UserCard(appUser: list[index], rank: index, username: widget.username);
      }
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_wyth_me/pages/leaderboard/friend_card.dart';
import 'package:study_wyth_me/pages/loading.dart';
import 'package:study_wyth_me/services/database.dart';
import 'package:study_wyth_me/models/app_user.dart';

class FriendList extends StatefulWidget {

  const FriendList({
    Key? key,
  }) : super(key: key);

  @override
  State<FriendList> createState() => _FriendListState();
}

class _FriendListState extends State<FriendList> {
  @override
  Widget build(BuildContext context) {
    final String uid = FirebaseAuth.instance.currentUser!.uid;
    final users = Provider.of<List<AppUser>>(context);
    return StreamBuilder<AppUser>(
        stream: DatabaseService(uid: uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            AppUser appUser = snapshot.data!;
            var list = [];
            for (var v in appUser.friendsUsername) {
              list.add(v);
            }
            return ListView.builder(
              itemCount: users.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return FriendCard(username: users[index].username, profile: users[index].url, uid: uid, isFriend: list.contains(users[index].username));
              },
            );
          } else {
            return const Loading();
          }
        }
    );
  }
}

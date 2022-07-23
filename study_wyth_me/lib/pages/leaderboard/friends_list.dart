import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_wyth_me/pages/leaderboard/friend_card.dart';
import 'package:study_wyth_me/pages/loading.dart';
import 'package:study_wyth_me/services/database.dart';
import 'package:study_wyth_me/models/app_user.dart';

class FriendList extends StatefulWidget {
  const FriendList({Key? key}) : super(key: key);

  @override
  State<FriendList> createState() => _FriendListState();
}

class _FriendListState extends State<FriendList> {
  @override
  Widget build(BuildContext context) {
    final String _uid = FirebaseAuth.instance.currentUser!.uid;
    final _users = Provider.of<List<AppUser>>(context);
    return StreamBuilder<AppUser>(
        stream: DatabaseService(uid: _uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            AppUser appUser = snapshot.data!;

            return StreamBuilder<List<AppUser>>(
              stream: DatabaseService(uid: _uid).userLeaderboardStream(false, appUser.friendsId),
              builder: (BuildContext context, AsyncSnapshot<List<AppUser>> querySnapshot) {
                if (querySnapshot.hasData) {
                  return ListView.builder(
                    itemCount: _users.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return FriendCard(
                          username: _users[index].username,
                          profile: _users[index].url,
                          uid: _uid,
                          friendStatus: appUser.friendsId.contains(_users[index].uid)
                              ? 'Unfriend'
                              : appUser.friendRequestsReceived.contains(_users[index].uid)
                              ? 'Befriend'
                              : appUser.friendRequestsSent.contains(_users[index].uid)
                              ? 'Unrequest'
                              : 'Request',
                      );
                    },
                  );
                } else {
                  return const Loading();
                }
              }
            );
          } else {
            return const Loading();
          }
        }
    );
  }
}

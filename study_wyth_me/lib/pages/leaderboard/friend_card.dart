import 'package:flutter/material.dart';
import 'package:study_wyth_me/services/database.dart';
import 'package:study_wyth_me/shared/constants.dart';

class FriendCard extends StatelessWidget {
  final String username;
  final String uid;
  final bool isFriend;
  const FriendCard({
    Key? key,
    required this.username,
    required this.uid,
    required this.isFriend,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    username,
                    style: chewyTextStyle.copyWith(fontSize: 20.0),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Container(
                  width: 100,
                  height: 40,
                  decoration: largeRadiusRoundedBox,
                  child: TextButton(
                    child: Text(isFriend ? 'Remove' : 'Add'),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(5.0),
                      primary: Colors.white,
                      textStyle: chewyTextStyle.copyWith(fontSize: 20.0),
                    ),
                    onPressed: () async {
                      if (isFriend) {
                        await DatabaseService(uid: uid).removeFriend(username);
                      } else {
                        await DatabaseService(uid: uid).addFriend(username);
                      }
                    },
                  )
              ),
            ],
          ),
        ),
        horizontalDivider
      ],
    );
  }
}
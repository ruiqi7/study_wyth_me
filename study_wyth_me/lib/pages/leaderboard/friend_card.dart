import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:study_wyth_me/services/database.dart';
import 'package:study_wyth_me/shared/constants.dart';

class FriendCard extends StatelessWidget {
  final String username;
  final String profile;
  final String uid;
  final String friendStatus;
  const FriendCard({
    Key? key,
    required this.username,
    required this.profile,
    required this.uid,
    required this.friendStatus,
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
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: CircleAvatar(
                  radius: 25.0,
                  backgroundImage: NetworkImage(profile),
                ),
              ),
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
                    key: Key(friendStatus + 'Button'),
                    child: AutoSizeText(
                      friendStatus,
                      style: chewyTextStyle.copyWith(fontSize: 20.0),
                      maxLines: 1
                    ),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(5.0),
                    ),
                    onPressed: () async {
                      String message = await DatabaseService(uid: uid).updateFriendStatus(username, friendStatus);
                      if (message.isNotEmpty) {
                        alertDialogue(context, message);
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
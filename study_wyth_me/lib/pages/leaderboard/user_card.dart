import 'package:flutter/material.dart';

import '../../models/app_user.dart';
import '../../shared/constants.dart';

class UserCard extends StatelessWidget {
  final AppUser appUser;
  final int rank;
  const UserCard({
    Key? key,
    required this.appUser,
    required this.rank,
  }) : super(key: key);

  String getRank() {
    int adjustedRank = rank + 1;
    if (adjustedRank < 10) {
      return "0" + adjustedRank.toString();
    } else {
      return adjustedRank.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              //insert the three text widgets
              SizedBox(
                width: 40,
                child: Text(
                  getRank(),
                  style: norwesterTextStyle.copyWith(fontSize: 28),
                ),
              ),
              const SizedBox(width: 20),
              CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage(appUser.url),
              ),
              const SizedBox(width: 10),
              Text(
                appUser.username,
                style: chewyTextStyle.copyWith(fontSize: 20),
              ),
              const Spacer(),
              Text(
                appUser.points.toString(),
                style: norwesterTextStyle.copyWith(fontSize: 20),
              )
            ],
          ),
        ),
        horizontalDivider
      ],
    );
  }
}
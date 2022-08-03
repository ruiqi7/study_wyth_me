import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:study_wyth_me/models/app_user.dart';
import 'package:study_wyth_me/shared/constants.dart';

class UserCard extends StatelessWidget {
  final AppUser appUser;
  final int rank;
  final String username;
  const UserCard({
    Key? key,
    required this.appUser,
    required this.rank,
    required this.username,
  }) : super(key: key);

  String _getRank() {
    int adjustedRank = rank + 1;
    if (adjustedRank < 10) {
      return "0" + adjustedRank.toString();
    } else {
      return adjustedRank.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: appUser.username == username ? whiteOpacity15 : Colors.transparent,
      child: Column(
        children: <Widget>[
          gapBoxH10,
          SizedBox(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(width: 5),
                //insert the three text widgets
                SizedBox(
                  width: 40,
                  child: AutoSizeText(
                    _getRank(),
                    style: norwesterTextStyle.copyWith(fontSize: 28),
                    maxLines: 1,
                  ),
                ),
                const SizedBox(width: 20),
                CircleAvatar(
                  radius: 25.0,
                  backgroundImage: NetworkImage(appUser.url),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    appUser.username,
                    style: chewyTextStyle.copyWith(fontSize: 20),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                gapBox,
                AutoSizeText(
                  appUser.points.toString(),
                  style: norwesterTextStyle.copyWith(fontSize: 20),
                ),
                const SizedBox(width: 5),
              ],
            ),
          ),
          gapBoxH10,
          noHeightHorizontalDivider
        ],
      ),
    );
  }
}
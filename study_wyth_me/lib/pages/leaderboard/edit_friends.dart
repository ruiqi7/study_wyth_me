import 'package:flutter/material.dart';

import '../../shared/constants.dart';

class EditFriends extends StatefulWidget {
  const EditFriends({Key? key}) : super(key: key);

  @override
  State<EditFriends> createState() => _EditFriendsState();
}

class _EditFriendsState extends State<EditFriends> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlueBackground,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(75),
          child: SafeArea(
              child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
                  color: whiteOpacity20,
                  height: 75.0,
                  child: Row(
                    children: <Widget> [
                      backIcon(context),
                      Center(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(25, 10, 10, 10),
                            child: Text(
                              'Add a new friend!',
                              style: chewyTextStyle.copyWith(fontSize: 25.0),
                            ),
                          )
                      )
                    ],
                  )
              )
          )
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            children: <Widget> [
              gapBox,
              gapBox,
              Text(
                "in progress",
                style: chewyTextStyle.copyWith(fontSize: 30),
              ),
            ],
          )
        )
      ),
    );
  }
}

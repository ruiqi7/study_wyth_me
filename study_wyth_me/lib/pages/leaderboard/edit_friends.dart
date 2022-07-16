import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/app_user.dart';
import '../../services/database.dart';
import '../../shared/constants.dart';
import 'friends_list.dart';

class EditFriends extends StatefulWidget {
  const EditFriends({Key? key}) : super(key: key);

  @override
  State<EditFriends> createState() => _EditFriendsState();
}

class _EditFriendsState extends State<EditFriends> {

  final String uid = FirebaseAuth.instance.currentUser!.uid;
  String input = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlueBackground,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(75),
          child: Container(
            color: whiteOpacity20,
            child: SafeArea(
                child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
                    color: transparent,
                    height: 75.0,
                    child: Row(
                      children: <Widget> [
                        closeIcon(context),
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
            ),
          )
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget> [
              gapBox,
              gapBox,
              TextFormField(
                key: const Key('EditFriendsUsernameFormField'),
                initialValue: input,
                textAlignVertical: TextAlignVertical.center,
                decoration: const InputDecoration(
                  fillColor: whiteOpacity15,
                  filled: true,
                  hintStyle: TextStyle(color: whiteOpacity70),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: whiteOpacity15,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 2.0,
                    ),
                  ),
                  isDense: true,
                  contentPadding: EdgeInsets.all(10.0),
                  hintText: 'Enter a username',
                  prefixIcon: Icon(
                    Icons.search,
                    color: whiteOpacity70,
                    size: 30,
                  ),
                ),
                style: chewyTextStyle.copyWith(fontSize: 20, color: Colors.white),
                onFieldSubmitted: (value) {
                  setState(() {
                    input = value;
                  });
                },
              ),
              gapBox,
              horizontalDivider,
              input != "" ? Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget> [
                    StreamProvider<List<AppUser>>.value(
                      value: DatabaseService(uid: uid).searchUserStream(input),
                      initialData: const [],
                      child: const Flexible(
                        child: FriendList()
                      ),
                    ),
                  ],
                ),
              ) : const SizedBox(height: 1),
            ],
          )
        )
      ),
    );
  }
}

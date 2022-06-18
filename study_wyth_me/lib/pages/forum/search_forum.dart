import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_wyth_me/models/post.dart';
import 'package:study_wyth_me/pages/forum/search_list.dart';
import 'package:study_wyth_me/services/forum_database.dart';
import 'package:study_wyth_me/shared/constants.dart';

class SearchForum extends StatefulWidget {
  const SearchForum({Key? key}) : super(key: key);

  @override
  State<SearchForum> createState() => _SearchForumState();
}

class _SearchForumState extends State<SearchForum> {

  final String uid = FirebaseAuth.instance.currentUser!.uid;
  String input = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlueBackground,
      /*appBar: PreferredSize(
        preferredSize: const Size.fromHeight(75),
        child: SafeArea(
          child: Container(
            color: whiteOpacity20,
            height: 75.0,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 10.0),
                    child: TextFormField(
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
                        hintText: 'Search',
                        prefixIcon: Icon(
                          Icons.search,
                          color: whiteOpacity70,
                          size: 30,
                        ),
                      ),
                      style: oswaldTextStyle.copyWith(fontSize: 20, color: Colors.white),
                      onFieldSubmitted: (value) {
                        setState(() {
                          input = value;
                        });
                      },
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 10.0),
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Center(
                    child: IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 40,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),*/
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
                              'Search Post by Title!',
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
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              gapBox,
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: TextFormField(
                  key: const Key('SearchForumFormField'),
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
                    hintText: 'Search',
                    prefixIcon: Icon(
                      Icons.search,
                      color: whiteOpacity70,
                      size: 30,
                    ),
                  ),
                  style: oswaldTextStyle.copyWith(fontSize: 20, color: Colors.white),
                  onFieldSubmitted: (value) {
                    setState(() {
                      input = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: horizontalDivider
              ),
              const SizedBox(height: 10),
              input != "" ? Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget> [
                    StreamProvider<List<Post>>.value(
                      value: ForumDatabase().searchForumStream(input),
                      initialData: const [],
                      child: const Flexible(
                        child: SearchList(),
                      ),
                    ),
                  ],
                ),
              ) : const SizedBox(height: 1),
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:auto_size_text/auto_size_text.dart';
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

  String _input = "";

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
                    color: Colors.transparent,
                    height: 75.0,
                    child: Row(
                      children: <Widget> [
                        closeIcon(context),
                        Center(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(25, 10, 10, 10),
                              child: AutoSizeText(
                                'Search Post by Title!',
                                style: chewyTextStyle.copyWith(fontSize: 25.0),
                                maxLines: 1,
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
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              gapBox,
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: TextFormField(
                  key: const Key('SearchForumFormField'),
                  initialValue: _input,
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
                      _input = value;
                    });
                  },
                ),
              ),
              gapBoxH10,
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: horizontalDivider
              ),
              gapBoxH10,
              _input != "" ? Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget> [
                    StreamProvider<List<Post>>.value(
                      value: ForumDatabase().searchForumStream,
                      initialData: const [],
                      child: Flexible(
                        child: SearchList(input: _input),
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
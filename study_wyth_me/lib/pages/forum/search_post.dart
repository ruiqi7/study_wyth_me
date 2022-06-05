import 'package:flutter/material.dart';
import 'package:study_wyth_me/models/post.dart';
import 'package:study_wyth_me/pages/forum/forum_post.dart';
import 'package:study_wyth_me/pages/forum/search_history.dart';
import 'package:study_wyth_me/shared/constants.dart';

class SearchPost extends StatelessWidget {
  final String input;
  const SearchPost({Key? key, required this.input}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlueBackground,
      appBar: PreferredSize(
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
                        //setState(() => _searched = true);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => SearchPost(input: value))
                        );
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
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          input.isNotEmpty
              ? Expanded(
                  child: Scrollbar(
                    radius: const Radius.circular(10.0),
                    child: ListView.builder(
                      padding: const EdgeInsets.only(top: 15.0),
                      itemCount: 10,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ForumPost(
                            post: Post(
                              postId: '',
                              posterUsername: '1',
                              title: '3',
                              content: '5',
                              timestamp: 0,
                              likes: 0,
                              comments: 0,
                              directReplies: []
                            ),
                          profile: 'https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg',
                        );
                      },
                    ),
                  ),
                )
              : Expanded(
                  child: Column(
                    children: <Widget> [
                      const Divider(color: Colors.white, height: 0.0),
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.all(0.0),
                          itemCount: 13,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return const SearchHistory(content: 'IS1103');
                          },
                        ),
                      )
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
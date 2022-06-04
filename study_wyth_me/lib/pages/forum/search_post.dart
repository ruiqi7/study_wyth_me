import 'package:flutter/material.dart';
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
                      decoration: const InputDecoration(
                        fillColor: whiteOpacity15,
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey),
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
                          color: Colors.grey,
                          size: 35,
                        ),
                      ),
                      style: oswaldTextStyle.copyWith(fontSize: 20, color: Colors.grey),
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
                  child: IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Colors.grey,
                      size: 45,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
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
                        return const ForumPost();
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
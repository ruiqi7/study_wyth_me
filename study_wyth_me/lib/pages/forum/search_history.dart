import 'package:flutter/material.dart';
import 'package:study_wyth_me/pages/forum/search_post.dart';
import 'package:study_wyth_me/shared/constants.dart';

class SearchHistory extends StatelessWidget {
  final String content;
  const SearchHistory({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(0.0),
        fixedSize: const Size(0.0, 50.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget> [
          Row(
            children: <Widget> [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                child: Icon(
                  Icons.history,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              Expanded(
                child: Text(
                  content,
                  style: oswaldTextStyle.copyWith(fontSize: 20, color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          const Divider(color: Colors.white, height: 0.0),
        ],
      ),
      onPressed: () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => SearchPost(input: content))
        );
      },
    );
  }
}

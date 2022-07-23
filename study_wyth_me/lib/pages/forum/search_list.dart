import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_wyth_me/pages/forum/forum_post.dart';
import 'package:study_wyth_me/models/post.dart';

class SearchList extends StatefulWidget {
  final String input;
  const SearchList({Key? key, required this.input}) : super(key: key);

  @override
  State<SearchList> createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  @override
  Widget build(BuildContext context) {
    final posts = Provider.of<List<Post>>(context);
    List<Post> searchResults = posts.where((post) => post.title.toLowerCase().contains(widget.input.toLowerCase())).toList();

    return ListView.builder(
      itemCount: searchResults.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return ForumPost(post: searchResults[index]);
      },
    );
  }
}

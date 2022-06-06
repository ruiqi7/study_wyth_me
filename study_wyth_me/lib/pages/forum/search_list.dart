import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_wyth_me/pages/forum/forum_post.dart';

import '../../models/post.dart';

class SearchList extends StatefulWidget {
  const SearchList({Key? key}) : super(key: key);

  @override
  State<SearchList> createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  @override
  Widget build(BuildContext context) {
    final String uid = FirebaseAuth.instance.currentUser!.uid;
    final posts = Provider.of<List<Post>>(context);
    return ListView.builder(
      itemCount: posts.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return ForumPost(post: posts[index]);
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:study_wyth_me/models/post.dart';
import 'package:study_wyth_me/services/forum_database.dart';
import 'package:study_wyth_me/shared/constants.dart';

class MainPost extends StatefulWidget {
  final Post post;
  final String profile;
  final void Function() function;
  const MainPost({Key? key, required this.post, required this.profile, required this.function}) : super(key: key);

  @override
  State<MainPost> createState() => _MainPostState();
}

class _MainPostState extends State<MainPost> {
  final ForumDatabase forumDatabase = ForumDatabase();

  @override
  Widget build(BuildContext context) {
    print('main post rebuilt');
    return Container(
      decoration: const BoxDecoration(
        color: whiteOpacity10,
      ),
      child: Column(
        children: <Widget> [
          const SizedBox(height: 15.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget> [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: CircleAvatar(
                  radius: 25.0,
                  backgroundImage: NetworkImage(widget.profile),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget> [
                    Text(
                      widget.post.title,
                      style: oswaldTextStyle.copyWith(fontSize: 17.5, color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                    ),
                    RichText(
                      text: TextSpan(
                        style: oswaldTextStyle.copyWith(fontSize: 10, color: Colors.grey),
                        children: <TextSpan>[
                          const TextSpan(text: 'posted by'),
                          TextSpan(text: ' ' + widget.post.posterUsername + ' ', style: const TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: timeDifference(widget.post.timestamp)),
                        ],
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 12.0),
                      child: Text(
                        widget.post.content,
                        style: oswaldTextStyle.copyWith(fontSize: 12.5, color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(width: 5.0),
            ],
          ),
          noHeightHorizontalDivider,
          SizedBox(
            height: 35.0,
            child: Row(
              children: <Widget> [
                Container(
                  padding: const EdgeInsets.fromLTRB(6.0, 0.0, 0.0, 10.0),
                  height: 50.0,
                  width: 40.0,
                  child: IconButton(
                    icon: const Icon(Icons.chat_bubble_outline, color: Colors.grey),
                    iconSize: 20,
                    onPressed: () {}, // should not be a button
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 10.0),
                  child: Text(
                    '${widget.post.comments}',
                    style: oswaldTextStyle.copyWith(fontSize: 12.0, color: Colors.grey),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(6.0, 0.0, 0.0, 10.0),
                  height: 50.0,
                  width: 40.0,
                  child: IconButton(
                    icon: const Icon(Icons.thumb_up_alt_outlined, color: Colors.grey),
                    iconSize: 20,
                    onPressed: () async {
                      await forumDatabase.addLike(widget.post.postId);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 10.0),
                  child: Text(
                    '${widget.post.likes}',
                    style: oswaldTextStyle.copyWith(fontSize: 12.0, color: Colors.grey),
                  ),
                ),
                const Expanded(
                  child: SizedBox(),
                ),
                SizedBox(
                  width: 50.0,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(0.0),
                    ),
                    child: Text(
                      'Reply',
                      style: oswaldTextStyle.copyWith(fontSize: 12.0, color: Colors.grey),
                    ),
                    onPressed: widget.function,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
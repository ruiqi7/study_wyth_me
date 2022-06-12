import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:study_wyth_me/models/post.dart';
import 'package:study_wyth_me/pages/loading.dart';
import 'package:study_wyth_me/services/forum_database.dart';
import 'package:study_wyth_me/shared/constants.dart';

class MainPost extends StatefulWidget {
  final Post post;
  final String username;
  final String profile;
  final void Function() function;
  final bool enableLikeAndReply;
  const MainPost({
    Key? key,
    required this.post,
    required this.username,
    required this.profile,
    required this.function,
    required this.enableLikeAndReply
  }) : super(key: key);

  @override
  State<MainPost> createState() => _MainPostState();
}

class _MainPostState extends State<MainPost> {
  final String uid = FirebaseAuth.instance.currentUser!.uid;
  final ForumDatabase forumDatabase = ForumDatabase();

  @override
  Widget build(BuildContext context) {

    return IntrinsicHeight(
      child: StreamBuilder<Post>(
        stream: ForumDatabase().postData(widget.post.postId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Post post = snapshot.data!;
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
                                  TextSpan(text: ' ' + widget.username + ' ', style: const TextStyle(fontWeight: FontWeight.bold)),
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
                        widget.enableLikeAndReply && widget.post.uid != uid
                          ? Container(
                              padding: const EdgeInsets.fromLTRB(6.0, 0.0, 0.0, 10.0),
                              height: 50.0,
                              width: 40.0,
                              child: IconButton(
                                icon: Icon(
                                  post.likes.contains(uid) ? Icons.thumb_up_alt : Icons.thumb_up_alt_outlined,
                                  //Icons.thumb_up_alt_outlined, // _liked! ? Icons.thumb_up_alt : Icons.thumb_up_alt_outlined,
                                  color: Colors.grey
                                ),
                                iconSize: 20,
                                onPressed: () async {
                                  await forumDatabase.changeLikeStatus(widget.post.postId, uid);
                                  // setState(() => _liked = !_liked!);
                                },
                              )
                          )
                        : Container(
                            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 10.0),
                            height: 50.0,
                            width: 40.0,
                            child: Icon(
                              post.likes.contains(uid) ? Icons.thumb_up_alt : Icons.thumb_up_alt_outlined,
                              color: Colors.grey,
                              size: 20,
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 10.0),
                          child: Text(
                            '${post.likes.length}',
                            style: oswaldTextStyle.copyWith(fontSize: 12.0, color: Colors.grey),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 10.0),
                          height: 50.0,
                          width: 40.0,
                          child: const Icon(
                            Icons.chat_bubble_outline,
                            color: Colors.grey,
                            size: 20.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 10.0),
                          child: Text(
                            '${post.comments}',
                            style: oswaldTextStyle.copyWith(fontSize: 12.0, color: Colors.grey),
                          ),
                        ),
                        const Expanded(
                          child: SizedBox(),
                        ),
                        widget.enableLikeAndReply
                          ? SizedBox(
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
                            )
                          : const SizedBox(width: 5.0),
                      ],
                    ),
                  )
                ],
              ),
            );
          } else {
            return const Loading();
          }
        }
      ),
    );
  }
}
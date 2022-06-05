import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:study_wyth_me/models/app_user.dart';
import 'package:study_wyth_me/models/comment.dart';
import 'package:study_wyth_me/models/post.dart';
import 'package:study_wyth_me/pages/forum/thread_reply.dart';
import 'package:study_wyth_me/pages/loading.dart';
import 'package:study_wyth_me/services/database.dart';
import 'package:study_wyth_me/shared/constants.dart';

class ThreadResponse extends StatefulWidget {
  final int replyIndex;
  final String commentString;
  final int position;
  final Post post;
  const ThreadResponse({Key? key, required this.replyIndex, required this.commentString, required this.position, required this.post}) : super(key: key);

  @override
  State<ThreadResponse> createState() => _ThreadResponseState();
}

class _ThreadResponseState extends State<ThreadResponse> {

  final String uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    Comment comment = Comment.fromJsonString(widget.commentString);

    return StreamBuilder<AppUser>(
      stream: DatabaseService(uid: comment.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          AppUser commenter = snapshot.data!;

          return Column(
            children: [
              Container(
                margin: const EdgeInsets.all(0.0),
                decoration: BoxDecoration(
                  color: widget.position == 1 ? whiteOpacity10 : Colors.transparent,
                ),
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget> [
                      Container(
                        padding: widget.position == 1 ? const EdgeInsets.only(left: 10.0) : const EdgeInsets.only(left: 0.0),
                        decoration: const BoxDecoration(
                          //color: Colors.red,
                        ),
                        width: widget.position == 1 ? 50.0 : 40.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget> [
                            const SizedBox(height: 10.0),
                            CircleAvatar(
                              radius: 20.0,
                              backgroundImage: NetworkImage(commenter.url),
                            ),
                            const Expanded(
                              child: VerticalDivider(
                                color: Colors.grey,
                                width: 80.0,
                                thickness: 0.5,
                                indent: 10.0,
                                endIndent: 10.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                            //color: Colors.pink,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget> [
                              Container(
                                padding: const EdgeInsets.fromLTRB(10.0, 25.0, 5.0, 15.0),
                                child: RichText(
                                  text: TextSpan(
                                    style: oswaldTextStyle.copyWith(fontSize: 9.0, color: Colors.grey),
                                    children: <TextSpan>[
                                      TextSpan(text: commenter.username, style: const TextStyle(fontWeight: FontWeight.bold)),
                                      const TextSpan(text: ' replied '),
                                      TextSpan(text: timeDifference(comment.timestamp)),
                                    ],
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0, bottom: 5.0, right: 5.0),
                                child: Text(
                                  comment.content,
                                  style: oswaldTextStyle.copyWith(fontSize: 12.5, color: Colors.white),
                                ),
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  //color: Colors.deepPurpleAccent,
                                ),
                                height: 35.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget> [
                                    IconButton(
                                      padding: const EdgeInsets.fromLTRB(10.0, 2.0, 0.0, 0.0),
                                      constraints: const BoxConstraints(),
                                      icon: const Icon(Icons.thumb_up_alt_outlined, color: Colors.grey),
                                      iconSize: 20,
                                      onPressed: () {
                                        // increase count by 1
                                      },
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(5.0, 8.0, 12.0, 10.0),
                                      child: Text(
                                        '${comment.likes}',
                                        style: oswaldTextStyle.copyWith(fontSize: 12.0, color: Colors.grey),
                                      ),
                                    ),
                                    IconButton(
                                      padding: const EdgeInsets.fromLTRB(0.0, 2.0, 0.0, 0.0),
                                      constraints: const BoxConstraints(),
                                      icon: const Icon(Icons.chat_bubble_outline, color: Colors.grey),
                                      iconSize: 20,
                                      onPressed: () {
                                        // increase count by 1
                                      },
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(5.0, 8.0, 0.0, 10.0),
                                      child: Text(
                                        '${comment.comments}',
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
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(builder:
                                                (context) => ThreadReply(
                                                  post: widget.post,
                                                  replyPost: ThreadResponse(
                                                    replyIndex: widget.replyIndex,
                                                    commentString: widget.commentString,
                                                    position: 1,
                                                    post: widget.post,
                                                  ),
                                                  hasReplyPost: true,
                                                )
                                              )
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              widget.position == 5 && widget.replyIndex < comment.directReplies.length
                                  ? Container(
                                      height: 25.0,
                                      margin: const EdgeInsets.only(left: 10.0, bottom: 10.0),
                                      decoration: largeRadiusRoundedBox,
                                      child: TextButton(
                                        child: const Text('See more replies'),
                                        style: TextButton.styleFrom(
                                          padding: const EdgeInsets.all(5.0),
                                          primary: Colors.white,
                                          textStyle: oswaldTextStyle.copyWith(fontSize: 12.0),
                                        ),
                                        onPressed: () {
                                          // call Thread()
                                        },
                                      ),
                                    )
                                  : const SizedBox(width: 0.0, height: 0.0),
                              widget.replyIndex < comment.directReplies.length
                                ? ThreadResponse(
                                    replyIndex: widget.replyIndex,
                                    commentString: '',
                                    position: widget.position == 5 ? 1 : widget.position + 1,
                                    post: widget.post,
                                  )
                                : const SizedBox(width: 0.0, height: 0.0),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              widget.replyIndex >= comment.directReplies.length || widget.position != 1
                ? const SizedBox(width: 0.0, height: 0.0)
                : ThreadResponse(
                    replyIndex: widget.replyIndex + 1,
                    commentString: '',
                    position: widget.position,
                    post: widget.post,
                  ),
            ],
          );
        } else {
          return const Loading();
        }
      }
    );
  }
}

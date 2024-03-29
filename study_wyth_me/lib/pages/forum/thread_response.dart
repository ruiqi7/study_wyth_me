import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:study_wyth_me/models/app_user.dart';
import 'package:study_wyth_me/models/comment.dart';
import 'package:study_wyth_me/models/post.dart';
import 'package:study_wyth_me/pages/forum/thread.dart';
import 'package:study_wyth_me/pages/forum/thread_reply.dart';
import 'package:study_wyth_me/pages/loading.dart';
import 'package:study_wyth_me/services/comments_database.dart';
import 'package:study_wyth_me/services/database.dart';
import 'package:study_wyth_me/shared/constants.dart';

class ThreadResponse extends StatefulWidget {
  final int position;
  final List<dynamic> parentDirectReplies;
  final int replyIndex;
  final Post post;
  final bool enableLikeAndReply;
  const ThreadResponse({
    Key? key,
    required this.position,
    required this.parentDirectReplies,
    required this.replyIndex,
    required this.post,
    required this.enableLikeAndReply
  }) : super(key: key);

  @override
  State<ThreadResponse> createState() => _ThreadResponseState();
}

class _ThreadResponseState extends State<ThreadResponse> {

  final String _uid = FirebaseAuth.instance.currentUser!.uid;
  final CommentsDatabase _commentsDatabase = CommentsDatabase();

  @override
  Widget build(BuildContext context) {
    if (widget.position <= 5) {
      String commentId = widget.parentDirectReplies[widget.replyIndex];

      return IntrinsicHeight(
        child: StreamBuilder<Comment>(
            stream: _commentsDatabase.commentData(commentId),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Comment comment = snapshot.data!;

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
                                      width: widget.position == 1 ? 50.0 : 40.0,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget> [
                                          gapBoxH10,
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
                                          SizedBox(
                                            height: 35.0,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: <Widget> [
                                                widget.enableLikeAndReply && comment.uid != _uid
                                                  ? IconButton(
                                                      key: const Key('ThreadCommentThumbsUp'),
                                                      padding: const EdgeInsets.fromLTRB(10.0, 2.0, 0.0, 0.0),
                                                      constraints: const BoxConstraints(),
                                                      icon: Icon(
                                                        comment.likes.contains(_uid) ? Icons.thumb_up_alt : Icons.thumb_up_alt_outlined,
                                                        color: Colors.grey
                                                      ),
                                                      iconSize: 20,
                                                      onPressed: () async {
                                                        await _commentsDatabase.changeLikeStatus(commentId, _uid);
                                                      },
                                                    )
                                                  : Icon(
                                                      key: const Key('OwnThreadResponseThumbsUp'),
                                                      comment.likes.contains(_uid) ? Icons.thumb_up_alt : Icons.thumb_up_alt_outlined,
                                                      color: Colors.grey,
                                                      size: 20,
                                                    ),
                                                Padding(
                                                  padding: const EdgeInsets.fromLTRB(5.0, 8.0, 12.0, 10.0),
                                                  child: Text(
                                                    key: const Key('ThreadCommentLikes'),
                                                    '${comment.likes.length}',
                                                    style: oswaldTextStyle.copyWith(fontSize: 12.0, color: Colors.grey),
                                                  ),
                                                ),
                                                const Padding(
                                                  padding: EdgeInsets.only(top: 2.0),
                                                  child: Icon(
                                                    Icons.chat_bubble_outline,
                                                    color: Colors.grey,
                                                    size: 20.0,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.fromLTRB(5.0, 8.0, 0.0, 10.0),
                                                  child: Text(
                                                    key: const Key('ThreadResponseComments'),
                                                    '${comment.comments}',
                                                    style: oswaldTextStyle.copyWith(fontSize: 12.0, color: Colors.grey),
                                                  ),
                                                ),
                                                const Expanded(
                                                  child: SizedBox(),
                                                ),
                                                widget.enableLikeAndReply ? SizedBox(
                                                  width: 50.0,
                                                  child: TextButton(
                                                    key: const Key('CommentReplyButton'),
                                                    style: TextButton.styleFrom(
                                                      padding: const EdgeInsets.all(0.0),
                                                    ),
                                                    child: AutoSizeText(
                                                      'Reply',
                                                      style: oswaldTextStyle.copyWith(fontSize: 12.0, color: Colors.grey),
                                                      maxLines: 1,
                                                    ),
                                                    onPressed: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(builder:
                                                          (context) => ThreadReply(
                                                            post: widget.post,
                                                            replyPost: ThreadResponse(
                                                              position: 1,
                                                              parentDirectReplies: widget.parentDirectReplies,
                                                              replyIndex: widget.replyIndex,
                                                              post: widget.post,
                                                              enableLikeAndReply: false,
                                                            ),
                                                            commenter: commenter.username,
                                                            commentId: commentId,
                                                          )
                                                        )
                                                      );
                                                    },
                                                  ),
                                                ) : const SizedBox(width: 5.0),
                                              ],
                                            ),
                                          ),
                                          widget.position == 5 && comment.directReplies.isNotEmpty ? Container(
                                            height: 25.0,
                                            margin: const EdgeInsets.only(left: 10.0, bottom: 10.0, right: 10.0),
                                            decoration: largeRadiusRoundedBox,
                                            child: TextButton(
                                              child: const AutoSizeText(
                                                'See more replies',
                                                maxLines: 1,
                                              ),
                                              style: TextButton.styleFrom(
                                                padding: const EdgeInsets.all(5.0),
                                                primary: Colors.white,
                                                textStyle: oswaldTextStyle.copyWith(fontSize: 12.0),
                                              ),
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => Thread(
                                                          post: widget.post,
                                                          parentDirectReplies: widget.parentDirectReplies,
                                                          replyIndex: widget.replyIndex,
                                                        )
                                                    )
                                                );
                                              },
                                            ),
                                          ) : emptyBox,
                                          comment.directReplies.isNotEmpty ? ThreadResponse(
                                            position: widget.position + 1,
                                            parentDirectReplies: comment.directReplies,
                                            replyIndex: 0,
                                            post: widget.post,
                                            enableLikeAndReply: widget.enableLikeAndReply,
                                          )
                                            : emptyBox,
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            widget.replyIndex + 1 >= widget.parentDirectReplies.length || widget.position == 1 ? emptyBox : ThreadResponse(
                              position: widget.position,
                              parentDirectReplies: widget.parentDirectReplies,
                              replyIndex: widget.replyIndex + 1,
                              post: widget.post,
                              enableLikeAndReply: widget.enableLikeAndReply,
                            ),
                          ],
                        );
                      } else {
                        return const Loading();
                      }
                    }
                );
              } else {
                return const Loading();
              }
            }
        ),
      );
    } else {
      return emptyBox;
    }
  }
}

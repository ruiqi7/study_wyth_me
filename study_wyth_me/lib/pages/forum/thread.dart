import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:study_wyth_me/models/app_user.dart';
import 'package:study_wyth_me/models/post.dart';
import 'package:study_wyth_me/pages/forum/main_post.dart';
import 'package:study_wyth_me/pages/forum/thread_reply.dart';
import 'package:study_wyth_me/pages/forum/thread_response.dart';
import 'package:study_wyth_me/pages/loading.dart';
import 'package:study_wyth_me/services/database.dart';
import 'package:study_wyth_me/services/forum_database.dart';
import 'package:study_wyth_me/shared/bar_widgets.dart';
import 'package:study_wyth_me/shared/constants.dart';

class Thread extends StatefulWidget {
  final Post post;
  final List<dynamic> parentDirectReplies;
  final int replyIndex;
  const Thread({Key? key, required this.post, required this.parentDirectReplies, required this.replyIndex}) : super(key: key);

  @override
  State<Thread> createState() => _ThreadState();
}

class _ThreadState extends State<Thread> {
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: StreamBuilder<Post>(
        stream: ForumDatabase().postData(widget.post.postId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Post post = snapshot.data!;

            return StreamBuilder<AppUser>(
              stream: DatabaseService(uid: post.uid).userData,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    AppUser poster = snapshot.data!;

                    return Scaffold(
                      backgroundColor: darkBlueBackground,
                      appBar: topBarWithBackButton(context),
                      body: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Scrollbar(
                              radius: const Radius.circular(10.0),
                              child: ListView.builder(
                                padding: const EdgeInsets.all(15.0),
                                itemCount: widget.replyIndex == - 1 ? post.directReplies.length + 1 : 2,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  if (index == 0) {
                                    return MainPost(
                                      post: post,
                                      username: poster.username,
                                      profile: poster.url,
                                      function: () {
                                        Navigator.push(
                                          context,
                                          PageTransition(
                                            child: ThreadReply(
                                              post: post,
                                              replyPost: emptyBox,
                                              commenter: '',
                                              commentId: '',
                                            ),
                                              type: PageTransitionType.rightToLeft
                                          )
                                        );
                                      },
                                      enableLikeAndReply: true,
                                    );
                                  } else {
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 15.0),
                                      child: ThreadResponse(
                                        position: 1,
                                        parentDirectReplies: widget.replyIndex == - 1 ? post.directReplies : widget.parentDirectReplies,
                                        replyIndex: widget.replyIndex == - 1 ? index - 1 : widget.replyIndex,
                                        post: post,
                                        enableLikeAndReply: true,
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
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
  }
}

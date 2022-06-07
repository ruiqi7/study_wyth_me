import 'package:flutter/material.dart';
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

import 'forum.dart';

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
                      appBar: PreferredSize(
                        preferredSize: const Size.fromHeight(75),
                        child:   SafeArea(
                          child: Container(
                            color: whiteOpacity20,
                            height: 75.0,
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 5.0, bottom: 5.0),
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.arrow_back_ios,
                                      color: Colors.white,
                                      size: 35,
                                    ),
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                          context,
                                        MaterialPageRoute(builder: (context) => const Forum())
                                      );
                                    },
                                  ),
                                ),
                                const Expanded(
                                  child: SizedBox(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
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
                                          MaterialPageRoute(builder:
                                            (context) => ThreadReply(
                                              post: post,
                                              replyPost: const SizedBox(width: 0.0, height: 0.0),
                                              commenter: '',
                                              commentId: '',
                                            )
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

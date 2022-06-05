import 'package:flutter/material.dart';
import 'package:study_wyth_me/models/post.dart';
import 'package:study_wyth_me/pages/forum/main_post.dart';
import 'package:study_wyth_me/pages/forum/thread_reply.dart';
import 'package:study_wyth_me/pages/forum/thread_response.dart';
import 'package:study_wyth_me/pages/loading.dart';
import 'package:study_wyth_me/services/forum_database.dart';
import 'package:study_wyth_me/shared/bar_widgets.dart';
import 'package:study_wyth_me/shared/constants.dart';

class Thread extends StatefulWidget {
  final Post post;
  final String profile;
  const Thread({Key? key, required this.post, required this.profile}) : super(key: key);

  @override
  State<Thread> createState() => _ThreadState();
}

class _ThreadState extends State<Thread> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Post>(
      stream: ForumDatabase().postData(widget.post.postId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Post post = snapshot.data!;

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
                      itemCount: 3,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return MainPost(
                              post: widget.post,
                              profile: widget.profile,
                              function: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder:
                                      (context) => ThreadReply(
                                        post: widget.post,
                                        profile: widget.profile,
                                        replyPost: const SizedBox(width: 0.0, height: 0.0),
                                        hasReplyPost: false,
                                      )
                                    )
                                );
                              }
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: ThreadResponse(
                              post: widget.post,
                              profile: widget.profile,
                              threadLength: 5,
                              position: 1,
                              nextIsInner: true,
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
  }
}

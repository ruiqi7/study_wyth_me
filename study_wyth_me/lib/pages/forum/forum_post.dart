import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:study_wyth_me/models/app_user.dart';
import 'package:study_wyth_me/models/post.dart';
import 'package:study_wyth_me/pages/forum/thread.dart';
import 'package:study_wyth_me/pages/loading.dart';
import 'package:study_wyth_me/services/database.dart';
import 'package:study_wyth_me/services/forum_database.dart';
import 'package:study_wyth_me/shared/constants.dart';

class ForumPost extends StatefulWidget {
  final Post post;
  const ForumPost({Key? key, required this.post}) : super(key: key);

  @override
  State<ForumPost> createState() => _ForumPostState();
}

class _ForumPostState extends State<ForumPost> {
  final String _uid = FirebaseAuth.instance.currentUser!.uid;
  final ForumDatabase _forumDatabase = ForumDatabase();

  @override
  Widget build(BuildContext context) {

    return IntrinsicHeight(
      child: StreamBuilder<AppUser>(
        stream: DatabaseService(uid: widget.post.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            AppUser poster = snapshot.data!;

            return Container(
              margin: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                color: whiteOpacity10,
              ),
              child: Column(
                children: <Widget> [
                  gapBox,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget> [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: CircleAvatar(
                          radius: 25.0,
                          backgroundImage: NetworkImage(poster.url),
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
                                  TextSpan(text: ' ' + poster.username + ' ', style: const TextStyle(fontWeight: FontWeight.bold)),
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
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: 40.0,
                        padding: const EdgeInsets.only(top: 5.0),
                        child: IconButton(
                          key: const Key('RightPointingArrow'),
                          icon: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
                          iconSize: 25,
                          onPressed: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                  child: Thread(
                                    post: widget.post,
                                    parentDirectReplies: const [],
                                    replyIndex: -1,
                                  ),
                                  type: PageTransitionType.rightToLeft,
                                )
                            );
                          },
                        ),
                      )
                    ],
                  ),
                  noHeightHorizontalDivider,
                  Container(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    height: 35.0,
                    child: Row(
                      children: <Widget> [
                        widget.post.uid != _uid
                          ? Container(
                            padding: const EdgeInsets.fromLTRB(6.0, 0.0, 0.0, 0.0),
                            height: 50.0,
                            width: 40.0,
                            child: IconButton(
                              key: const Key('ForumPostThumbsUp'),
                              icon: Icon(
                                widget.post.likes.contains(_uid) ? Icons.thumb_up_alt : Icons.thumb_up_alt_outlined,
                                color: Colors.grey
                              ),
                              iconSize: 20,
                              onPressed: () async {
                                await _forumDatabase.changeLikeStatus(widget.post.postId, _uid);
                              },
                            ),
                          )
                          : Container(
                              padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 0.0),
                              height: 50.0,
                              width: 40.0,
                              child: Icon(
                                key: const Key('OwnPostThumbsUp'),
                                Icons.thumb_up_alt_outlined,
                                color: Colors.grey,
                                size: 20
                              ),
                            ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            key: const Key('ForumPostLikes'),
                            '${widget.post.likes.length}',
                            style: oswaldTextStyle.copyWith(fontSize: 12.0, color: Colors.grey),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 0.0),
                          height: 50.0,
                          width: 40.0,
                          child: const Icon(
                            Icons.chat_bubble_outline,
                            color: Colors.grey,
                            size: 20.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            '${widget.post.comments}',
                            style: oswaldTextStyle.copyWith(fontSize: 12.0, color: Colors.grey),
                          ),
                        )
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

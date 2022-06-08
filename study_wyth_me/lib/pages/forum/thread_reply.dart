import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:study_wyth_me/models/app_user.dart';
import 'package:study_wyth_me/models/post.dart';
import 'package:study_wyth_me/pages/forum/main_post.dart';
import 'package:study_wyth_me/pages/loading.dart';
import 'package:study_wyth_me/services/comments_database.dart';
import 'package:study_wyth_me/services/database.dart';
import 'package:study_wyth_me/services/forum_database.dart';
import 'package:study_wyth_me/shared/bar_widgets.dart';
import 'package:study_wyth_me/shared/constants.dart';

class ThreadReply extends StatefulWidget {
  final Post post;
  final Widget replyPost;
  final String commenter;
  final String commentId;
  const ThreadReply({Key? key, required this.post, required this.replyPost, required this.commenter, required this.commentId}) : super(key: key);

  @override
  State<ThreadReply> createState() => _ThreadReplyState();
}

class _ThreadReplyState extends State<ThreadReply> {

  final ForumDatabase forumDatabase = ForumDatabase();
  final CommentsDatabase commentsDatabase = CommentsDatabase();

  final String uid = FirebaseAuth.instance.currentUser!.uid;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // values of the form fields
  String _text = '';

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AppUser>(
      stream: DatabaseService(uid: widget.post.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          AppUser poster = snapshot.data!;

          return Scaffold(
            backgroundColor: darkBlueBackground,
            appBar: topBarWithBackButton(context),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  constraints: const BoxConstraints(
                    maxHeight: 230,
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: <Widget> [
                        MainPost(
                          post: widget.post,
                          username: poster.username,
                          profile: poster.url,
                          function: () {},
                          enableLikeAndReply: false,
                        ),
                        widget.commenter.isNotEmpty
                            ? Padding(
                                padding: const EdgeInsets.only(top: 15.0),
                                child: widget.replyPost,
                              )
                            : widget.replyPost,
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget> [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        height: 50.0,
                        color: whiteOpacity20,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: RichText(
                            text: TextSpan(
                              style: oswaldTextStyle.copyWith(fontSize: 14.5, color: Colors.white),
                              children: <TextSpan>[
                                const TextSpan(text: 'Replying to'),
                                widget.commenter.isNotEmpty
                                  ? TextSpan(text: ' ' + widget.commenter + ' ', style: const TextStyle(fontWeight: FontWeight.bold))
                                  : TextSpan(text: ' ' + poster.username + ' ', style: const TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Form(
                        key: _formKey,
                        child: Expanded(
                          child: Container(
                            color: whiteOpacity10,
                            child: Container(
                              margin: const EdgeInsets.all(8.0),
                              child: SingleChildScrollView(
                                child: TextFormField( // text
                                  maxLines: null,
                                  decoration: forumFormFieldDeco.copyWith(hintText: 'Add Text...'),
                                  style: oswaldTextStyle.copyWith(fontSize: 15.0, color: Colors.white),
                                  validator: (value) => value!.trim().isEmpty ? 'Enter your text' : null,
                                  onChanged: (value) {
                                    setState(() => _text = value.trim());
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        color: whiteOpacity10,
                        padding: const EdgeInsets.only(bottom: 20.0, right: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget> [
                            appBarButton(
                              'Reply',
                              () async {
                                if (_formKey.currentState!.validate()) {
                                  String newCommentId = await commentsDatabase.createNewComment(uid, _text);
                                  if (widget.commenter.isNotEmpty) {
                                    await commentsDatabase.addReply(widget.commentId, newCommentId);
                                    await forumDatabase.updateCommentCount(widget.post.postId);
                                  } else {
                                    await forumDatabase.addReply(widget.post.postId, newCommentId);
                                  }
                                  await DatabaseService(uid: uid).updatePoints();
                                  Navigator.pop(context);
                                }
                              }
                            ),
                          ],
                        ),
                      ),
                    ],
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

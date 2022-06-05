import 'package:flutter/material.dart';
import 'package:study_wyth_me/models/post.dart';
import 'package:study_wyth_me/pages/forum/main_post.dart';
import 'package:study_wyth_me/pages/loading.dart';
import 'package:study_wyth_me/shared/bar_widgets.dart';
import 'package:study_wyth_me/shared/constants.dart';

class ThreadReply extends StatefulWidget {
  final Post post;
  final String profile;
  final Widget replyPost;
  final bool hasReplyPost;
  const ThreadReply({Key? key, required this.post, required this.profile, required this.replyPost, required this.hasReplyPost}) : super(key: key);

  @override
  State<ThreadReply> createState() => _ThreadReplyState();
}

class _ThreadReplyState extends State<ThreadReply> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // values of the form fields
  String _text = '';

  // determines whether to display loading screen
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return _loading ? const Loading() : Scaffold(
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
                  MainPost(post: widget.post, profile: widget.profile, function: () {}),
                  widget.hasReplyPost
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
                   child: Text(
                     'Replying to AStudentBarelySurviving',
                     style: oswaldTextStyle.copyWith(fontSize: 14.5, color: Colors.white),
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
                        () {
                          if (_formKey.currentState!.validate()) {
                            // save _text to database
                            setState(() => _loading = true);
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
  }
}

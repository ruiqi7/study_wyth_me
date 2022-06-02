import 'package:flutter/material.dart';
import 'package:study_wyth_me/pages/loading.dart';
import 'package:study_wyth_me/shared/bar_widgets.dart';
import 'package:study_wyth_me/shared/constants.dart';

class ThreadReply extends StatefulWidget {
  final Container mainPost;
  final Widget replyPost;
  const ThreadReply({Key? key, required this.mainPost, required this.replyPost}) : super(key: key);

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          topBarWithBackButton(context),
          Container(
            constraints: const BoxConstraints(
              maxHeight: 330, // minimum width
            ),
            child: Scrollbar(
              radius: const Radius.circular(10.0),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: <Widget> [
                    widget.mainPost,
                    const SizedBox(height: 15.0),
                    widget.replyPost,
                  ],
                ),
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
                      color: const Color.fromRGBO(255, 255, 255, 0.10),
                      child: Container(
                        margin: const EdgeInsets.all(15.0),
                        child: SingleChildScrollView(
                          child: TextFormField( // text
                            maxLines: null,
                            decoration: formFieldDeco.copyWith(hintText: 'Add Text...'),
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
                  color: const Color.fromRGBO(255, 255, 255, 0.10),
                  padding: const EdgeInsets.only(bottom: 15.0, right: 5.0),
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

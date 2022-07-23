import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:study_wyth_me/services/forum_database.dart';
import 'package:study_wyth_me/shared/constants.dart';

class NewPost extends StatefulWidget {
  const NewPost({Key? key}) : super(key: key);

  @override
  State<NewPost> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {

  final String _uid = FirebaseAuth.instance.currentUser!.uid;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // values of the form fields
  String _title = '';
  String _text = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlueBackground,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(75),
        child: Container(
          color: whiteOpacity20,
          child: SafeArea(
            child: Container(
              color: Colors.transparent,
              height: 75.0,
              child: Row(
                children: <Widget>[
                  closeIcon(context),
                  const Expanded(
                    child: SizedBox(),
                  ),
                  appBarButton(
                    'Post',
                    () async {
                      if (_formKey.currentState!.validate()) {
                        await ForumDatabase().createNewPost(
                          _uid,
                          _title,
                          _text,
                          DateTime.now().millisecondsSinceEpoch,
                        );
                        Navigator.pop(context);
                      }
                    }
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Form(
            key: _formKey,
            child: Expanded(
              child: Container(
                margin: const EdgeInsets.all(15.0),
                color: whiteOpacity10,
                child: Column(
                  children: <Widget> [
                    Container(
                      margin: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 4.0),
                      child: TextFormField( // title
                        key: const Key('NewPostTitleFormField'),
                        decoration: forumFormFieldDeco.copyWith(hintText: 'Add Title'),
                        style: oswaldTextStyle.copyWith(fontSize: 23.5, color: Colors.white),
                        validator: (value) => value!.trim().isEmpty ? 'Enter your title' : null,
                        onChanged: (value) {
                          setState(() => _title = value.trim());
                        },
                      ),
                    ),
                    horizontalDivider,
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(12.0, 4.0, 12.0, 8.0),
                        child: SingleChildScrollView(
                          child: TextFormField( // text
                            key: const Key('NewPostTextFormField'),
                            maxLines: null,
                            decoration: forumFormFieldDeco.copyWith(hintText: 'Add Text...'),
                            style: oswaldTextStyle.copyWith(fontSize: 20.0, color: Colors.white),
                            validator: (value) => value!.trim().isEmpty ? 'Enter your text' : null,
                            onChanged: (value) {
                              setState(() => _text = value.trim());
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

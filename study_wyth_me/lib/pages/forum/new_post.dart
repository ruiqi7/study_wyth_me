import 'package:flutter/material.dart';
import 'package:study_wyth_me/pages/loading.dart';
import 'package:study_wyth_me/shared/constants.dart';

class NewPost extends StatefulWidget {
  const NewPost({Key? key}) : super(key: key);

  @override
  State<NewPost> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // values of the form fields
  String _title = '';
  String _text = '';

  // indicate error (if any) upon posting
  String _error = '';

  // determines whether to display loading screen
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return _loading ? const Loading() : Scaffold(
      backgroundColor: darkBlueBackground,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(75),
        child: SafeArea(
          child: Container(
            color: whiteOpacity20,
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
                        // save to database
                        /*
                          if (there is an error) {
                            setState(() => _error = message);
                          } else {
                            setState(() => _loading = true);
                            Navigator.pop(context);
                          }
                          */
                      }
                    }
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text(
              _error,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 10.0,
              ),
            ),
          ),
          Form(
            key: _formKey,
            child: Expanded(
              child: Container(
                margin: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 15.0),
                color: whiteOpacity10,
                child: Column(
                  children: <Widget> [
                    Container(
                      margin: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 4.0),
                      child: TextFormField( // title
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

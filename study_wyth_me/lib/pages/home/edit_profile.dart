import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:study_wyth_me/services/database.dart';
import 'package:study_wyth_me/services/storage.dart';
import 'package:study_wyth_me/shared/constants.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  final String username;
  final String url;
  const EditProfile({ Key? key, required this.username, required this.url }) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  final Storage _storage = Storage();

  bool _changedProfileBefore = false;
  bool _changedProfile = false;
  String? _currURL;
  XFile? _currImage;

  // to notify the user if the profile has been saved
  String _message = '';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _changedUsername = false;
  String? _currUsername;

  @override
  Widget build(BuildContext context) {
    final String _uid = FirebaseAuth.instance.currentUser!.uid;
    final DatabaseService _databaseService = DatabaseService(uid: _uid);

    if (!_changedProfileBefore) {
      _currURL = widget.url; // get the user's current profile picture
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: darkBlueBackground,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(75.0),
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
                      'Save',
                          () async {
                        String notification = 'No new changes.';

                        if (_changedProfile) {
                          notification = 'Saved!';
                          String newURL = await _storage.uploadFile(_currImage!, _uid, true);
                          await _databaseService.updatePicture(newURL);
                        }

                        if (_formKey.currentState!.validate()) {
                          if (_changedUsername) {
                            notification = await _databaseService.updateUsername(_currUsername!);
                          }
                        }

                        setState(() {
                          _message = notification;
                          _changedUsername = false;
                          _changedProfile = false;
                        });
                        Future.delayed(const Duration(seconds: 2), () {
                          if (mounted) {
                            setState(() => _message = '');
                          }
                        });
                      }
                    ),
                  ],
                ),
              ),
            ),
          )
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          gapBoxH10,
          Container(
            height: 38.0,
            padding: const EdgeInsets.symmetric(horizontal: 55.0),
            child: AutoSizeText(
              _message,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 16.0,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: AutoSizeText(
              'Edit Username',
              style: chewyTextStyle.copyWith(fontSize: 40.0),
              maxLines: 1,
            ),
          ),
          const SizedBox(height: 25.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
              key: _formKey,
              child: TextFormField( // username
                initialValue: widget.username,
                textAlign: TextAlign.center,
                decoration: forumFormFieldDeco,
                style: chewyTextStyle.copyWith(fontSize: 27.5),
                validator: (value) => value!.trim().isEmpty ? 'Enter your username' : null,
                onChanged: (value) {
                  setState(() {
                    _currUsername = value.trim();
                    _changedUsername = true;
                  });
                },
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: noHeightHorizontalDivider,
          ),
          const SizedBox(height: 40.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: AutoSizeText(
              'Edit Profile',
              style: chewyTextStyle.copyWith(fontSize: 40.0),
              maxLines: 1,
            ),
          ),
          const SizedBox(height: 40.0),
          CircleAvatar(
            radius: 60.0,
            backgroundImage: NetworkImage(_currURL!),
          ),
          const SizedBox(height: 35.0),
          Container(
              height: 60.0,
              width: 270.0,
              decoration: largeRadiusRoundedBox,
              child: TextButton(
                child: AutoSizeText(
                  'Choose from Library',
                  style: chewyTextStyle.copyWith(fontSize: 25.0),
                  maxLines: 1,
                ),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(10.0),
                ),
                onPressed: () async {
                  // open gallery to select an image
                  XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);

                  if (image != null) { // image selected
                    String newURL = await _storage.uploadFile(image, _uid, false);
                    setState(() {
                      _changedProfileBefore = true;
                      _changedProfile = true;
                      _currURL = newURL;
                      _currImage = image;
                    });
                  }
                },
              )
          ),
        ],
      ),
    );
  }
}
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

  final Storage storage = Storage();

  bool _changedProfileBefore = false;
  bool _changedProfile = false;
  String? _currURL;
  XFile? _currImage;

  // to notify the user if the profile has been saved
  String message = '';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _changedUsername = false;
  String? _currUsername;

  @override
  Widget build(BuildContext context) {
    final String uid = FirebaseAuth.instance.currentUser!.uid;
    final DatabaseService databaseService = DatabaseService(uid: uid);

    if (!_changedProfileBefore) {
      _currURL = widget.url; // get the user's current profile picture
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: darkBlueBackground,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SafeArea(
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
                      'Save',
                      () async {
                        String notification = 'No new changes.';

                        if (_changedProfile) {
                          notification = 'Saved!';
                          String newURL = await storage.uploadFile(_currImage!, uid, true);
                          await databaseService.updatePicture(newURL);
                        }

                        if (_formKey.currentState!.validate()) {
                          if (_changedUsername) {
                            notification = await databaseService.updateUsername(_currUsername!);
                          }
                        }

                        setState(() {
                          message = notification;
                          _changedUsername = false;
                          _changedProfile = false;
                        });
                        Future.delayed(const Duration(seconds: 2), () {
                          if (mounted) {
                            setState(() => message = '');
                          }
                        });
                      }
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          Container(
            height: 38.0,
            padding: const EdgeInsets.symmetric(horizontal: 55.0),
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 16.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Text(
            'Edit Username',
            style: chewyTextStyle.copyWith(fontSize: 40.0),
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
          Text(
            'Edit Profile',
            style: chewyTextStyle.copyWith(fontSize: 40.0),
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
                child: const Text('Choose from Library'),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(5.0),
                  primary: Colors.white,
                  textStyle: chewyTextStyle.copyWith(fontSize: 25.0),
                ),
                onPressed: () async {
                  // open gallery to select an image
                  XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);

                  if (image != null) { // image selected
                    String newURL = await storage.uploadFile(image, uid, false);
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
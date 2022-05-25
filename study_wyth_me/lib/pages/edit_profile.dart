import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:study_wyth_me/services/database.dart';
import 'package:study_wyth_me/services/storage.dart';
import 'package:study_wyth_me/shared/constants.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  final String url;
  const EditProfile({ Key? key, required this.url }) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  final Storage storage = Storage();

  bool _changedBefore = false;
  bool _changedProfile = false;
  String? _currURL;
  XFile? _currImage;

  // to notify the user if the profile has been saved
  String message = '';

  @override
  Widget build(BuildContext context) {
    final String uid = FirebaseAuth.instance.currentUser!.uid;
    if (!_changedBefore) {
      _currURL = widget.url; // get the user's current profile picture
    }

    return Scaffold(
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
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: backIcon(context),
                  ),
                  const Expanded(
                    child: SizedBox(),
                  ),
                  appBarButton(
                      'Save',
                      () async {
                        String notification;
                        if (_changedProfile) {
                          notification = 'Saved!';
                          String newURL = await storage.uploadFile(_currImage!, uid, true);
                          await DatabaseService(uid: uid).updatePicture(newURL);
                        } else {
                          notification = 'No new image selected.';
                        }
                        setState(() {
                          message = notification;
                          _changedProfile = false;
                        });
                        Future.delayed(const Duration(seconds: 1), () {
                          setState(() => message = '');
                        });
                      }
                  ),
                ],
              ),
            ),
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
                      _changedBefore = true;
                      _changedProfile = true;
                      _currURL = newURL;
                      _currImage = image;
                    });
                  }
                },
              )
          ),
          gapBox,
          Text(
            message,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 16.0,
            ),
          )
        ],
      ),
    );
  }
}
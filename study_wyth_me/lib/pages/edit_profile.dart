import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:study_wyth_me/models/app_user.dart';
import 'package:study_wyth_me/pages/loading.dart';
import 'package:study_wyth_me/services/database.dart';
import 'package:study_wyth_me/shared/constants.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    final String uid = FirebaseAuth.instance.currentUser!.uid;

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
                      () {}
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
          StreamBuilder<AppUser>(
            stream: DatabaseService(uid: uid).userData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text('Loading...');
              } else {
                print(snapshot);
                AppUser appUser = snapshot.data!;
                return CircleAvatar(
                  radius: 60.0,
                  backgroundImage: NetworkImage(appUser.url),
                );
              }
            }
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

                  // image url
                  String url = image!.path;

                  // update url in firebase
                  await DatabaseService(uid: uid).updatePicture(url);
                },
              )
          )
        ],
      ),
    );
  }

  /*
  @override
  Widget build(BuildContext context) {
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
                    () {

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
          const CircleAvatar(
            radius: 60.0,
            backgroundImage: NetworkImage(
            'https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg'),
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
              onPressed: () {

              },
            )
          )
        ],
      ),
    );
  }
   */
}
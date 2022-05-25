import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/app_user.dart';

class DatabaseService {

  final String uid;

  DatabaseService({ required this.uid });

  //collection reference
  final CollectionReference userDatabaseCollection = FirebaseFirestore.instance
      .collection('userDatabase');

  Future createNewUser(String username) async {
    return await userDatabaseCollection.doc(uid).set({
      'username': username,
      'map': {
        "Study": 0
      },
      'url': 'https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg',
      'points' : 0,
    });
  }

  // update timer
  Future updateNewModule(String module) async {
    return await userDatabaseCollection.doc(uid).update({
      'map.$module': 0,
    });
  }

  // update user's profile picture
  Future updatePicture(String url) async {
    return await userDatabaseCollection.doc(uid).update({
      'url': url,
    });
  }

  //get userDatabase stream
  Stream<QuerySnapshot> get userDatabaseStream {
    return userDatabaseCollection.snapshots();
  }

//void updateAppUser(AppUser appUser) async {
  //  await userDatabaseCollection.doc(appUser.referenceId).update(appUser.toJson());
  //}
  // 5
  //void deleteAppUser(AppUser appUser) async {
  //  await userDatabaseCollection.doc(appUser.referenceId).delete();
  //}

  //get user document stream
  Stream<AppUser> get userData {
    return userDatabaseCollection.doc(uid).snapshots().map<AppUser>(
        _userDataFromSnapshot);
  }

  //userData from snapshot
  AppUser _userDataFromSnapshot(DocumentSnapshot snapshot) {
    snapshot = snapshot as DocumentSnapshot<Map<String, dynamic>>;
    final data = snapshot.data();
    return AppUser(
      uid: uid,
      username: data?['username'],
      map: data?['map'],
      url: data?['url'],
      points: data?['points']
    );
  }

//read current userData
//AppUser getAppUser() {
//  final docRef = userDatabaseCollection.doc(uid);
//  AppUser appUser;
//  docRef.get().then(
//    (DocumentSnapshot doc) {
//      final data = doc.data() as Map<String, dynamic>;
//      return AppUser(
//        username: data['username'],
//      );
//    }, onError: (e) => print("Error getting document: $e"),
//  );
//  return appUser;
//}
}
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
    });
  }

  Future updateUserData(String username, Map<String, int> map) async {
    return await userDatabaseCollection.doc(uid).set({
      'username': username,
      'map' : map,
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
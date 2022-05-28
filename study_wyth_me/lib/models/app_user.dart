import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:study_wyth_me/main.dart';

class AppUser {

  final String uid;
  final String username;
  final Map<String, dynamic> map; // stores module : minutes in this format
  final String url;
  final dynamic points;
  final dynamic duration;

  AppUser({
    required this.uid,
    required this.username,
    required this.map,
    required this.url,
    required this.points,
    required this.duration
  });

//obtain user data from Firestore as AppUser Object
//factory AppUser.fromFirestore(
//    DocumentSnapshot<Map<String, dynamic>> snapshot,
//    SnapshotOptions? options,
//    ) {
//  final data = snapshot.data();
//  return AppUser(
//    username: data?['username'],
//  );
//}

//Map<String, dynamic> toFirestore() {
//  return {
//    "username": username,
//  };
//}

}
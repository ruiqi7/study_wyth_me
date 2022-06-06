// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'dart:convert';

class Comment {

  final String uid;
  final dynamic timestamp;
  final String content;
  final dynamic likes;
  final dynamic comments;
  final List<dynamic> directReplies;

  Comment({
    required this.uid,
    required this.timestamp,
    required this.content,
    required this.likes,
    required this.comments,
    required this.directReplies,
  });

  // https://stackoverflow.com/questions/60124063/is-it-possible-to-pass-parameter-on-onselectnotification-for-flutter-local-notif
  // https://docs.flutter.dev/development/data-and-backend/json#manual-encoding

  /*
  factory Comment.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Comment(
      posterUsername: data?['posterUsername'],
      timestamp: data?['timestamp'],
      content: data?['content'],
      likes: data?['likes'],
      thumbs: data?['thumbs'],
      directReplies: List.from(data?['directReplies']),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "posterUsername": posterUsername,
      "timestamp": timestamp,
      "content": content,
      "likes": likes,
      "thumbs": thumbs,
      "directReplies": directReplies,
    };
  }
  */

}
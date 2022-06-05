import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

class Comment {

  final String posterUsername;
  final String timestamp;
  final String content;
  final dynamic likes;
  final dynamic thumbs;
  final List<dynamic> directReplies;

  Comment({
    required this.posterUsername,
    required this.timestamp,
    required this.content,
    required this.likes,
    required this.thumbs,
    required this.directReplies,
  });

  factory Comment.fromJsonString(String str) => Comment._fromJson(jsonDecode(str));

  String toJsonString() => jsonEncode(_toJson());

  factory Comment._fromJson(Map<String, dynamic> json) => Comment(
    posterUsername: json['posterUsername'],
    timestamp: json['timestamp'],
    content: json['content'],
    likes: json['likes'],
    thumbs: json['thumbs'],
    directReplies: json['directReplies'],
  );


  Map<String, dynamic> _toJson() => {
    'posterUsername': posterUsername,
    'timestamp': timestamp,
    'content': content,
    'likes': likes,
    'thumbs': thumbs,
    'directReplies': directReplies,
  };

  String jsonString() {
    return toJsonString();
  }

  // Comment comment = Comment.fromJsonString(jsonString());
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
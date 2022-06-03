import 'package:cloud_firestore/cloud_firestore.dart';

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

}
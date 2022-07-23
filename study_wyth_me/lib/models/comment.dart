class Comment {

  final String uid;
  final dynamic timestamp;
  final String content;
  final List<dynamic> likes;
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
}
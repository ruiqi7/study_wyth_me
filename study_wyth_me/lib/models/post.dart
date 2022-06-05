class Post {

  final String postId;
  final String posterUsername;
  final String title;
  final String content;
  final dynamic timestamp;
  final dynamic comments;
  final dynamic likes;
  final List<dynamic> directReplies;

  Post({
    required this.postId,
    required this.posterUsername,
    required this.title,
    required this.content,
    required this.timestamp,
    required this.comments,
    required this.likes,
    required this.directReplies,
  });
}
class Post {

  final String postId;
  final String title;
  final String posterUsername;
  final String timestamp;
  final String content;
  final dynamic likes;
  final dynamic thumbs;
  final List<dynamic> directReplies;

  Post({
    required this.postId,
    required this.title,
    required this.posterUsername,
    required this.timestamp,
    required this.content,
    required this.likes,
    required this.thumbs,
    required this.directReplies,
  });
}
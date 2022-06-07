class Post {

  final String postId;
  final String uid;
  final String title;
  final String content;
  final dynamic timestamp;
  final dynamic comments;
  final List<dynamic> likes;
  final List<dynamic> directReplies;

  Post({
    required this.postId,
    required this.uid,
    required this.title,
    required this.content,
    required this.timestamp,
    required this.comments,
    required this.likes,
    required this.directReplies,
  });

  int compareTo(Post post) {
    if (timestamp < post.timestamp) {
      return -1;
    } else if (timestamp > post.timestamp) {
      return 1;
    } else {
      return 0;
    }
  }
}
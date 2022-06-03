import 'package:cloud_firestore/cloud_firestore.dart';

class ForumDatabase {

  //collection reference
  final CollectionReference forumDatabaseCollection = FirebaseFirestore.instance
      .collection('forumDatabase');

  Future createNewPost(String title, String posterUsername, String timestamp, String content) async {
    return await forumDatabaseCollection.add({
      'title': title,
      'posterUsername': posterUsername,
      'timestamp': timestamp,
      'content': content,
      'likes': 0,
      'thumbs': 0,
      'directReplies': [],
    });
  }

  Future addLike(String postId) async {
    return await forumDatabaseCollection.doc(postId).update({
      "likes" : FieldValue.increment(1),
    });
  }

  Future addThumb(String postId) async {
    return await forumDatabaseCollection.doc(postId).update({
      "thumbs" : FieldValue.increment(1),
    });
  }

  Future addReply(String postId, List<dynamic> list) async {
    return await forumDatabaseCollection.doc(postId).update({
      "directReplies" : list,
    });
  }

}
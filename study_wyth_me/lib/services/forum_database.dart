import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:study_wyth_me/models/post.dart';

class ForumDatabase {

  //collection reference
  final CollectionReference forumDatabaseCollection = FirebaseFirestore.instance
      .collection('forumDatabase');

  //get forumDatabase stream
  Stream<QuerySnapshot> get forumDatabaseStream {
    return forumDatabaseCollection.snapshots();
  }

  List<Post> forumPostListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Post(
        postId: doc.reference.id,
        posterUsername: doc.data().toString().contains('posterUsername') ? doc.get('posterUsername'): '',
        title: doc.data().toString().contains('title') ? doc.get('title'): '',
        content: doc.data().toString().contains('content') ? doc.get('content'): '',
        timestamp: doc.data().toString().contains('timestamp') ? doc.get('timestamp'): 0,
        likes: doc.data().toString().contains('likes') ? doc.get('likes'): 0,
        comments: doc.data().toString().contains('comments') ? doc.get('comments'): 0,
        directReplies: doc.data().toString().contains('directReplies') ? doc.get('directReplies'): [],
      );
    }).toList();
  }

  //get post document stream
  Stream<Post> postData(String postId) {
    return forumDatabaseCollection.doc(postId).snapshots().map<Post>(_postDataFromSnapshot);
  }

  // post data from snapshot
  Post _postDataFromSnapshot(DocumentSnapshot snapshot) {
    snapshot = snapshot as DocumentSnapshot<Map<String, dynamic>>;
    final data = snapshot.data();
    print(snapshot.id);
    return Post(
      postId: snapshot.id,
      posterUsername: data?['posterUsername'],
      title: data?['title'],
      content: data?['content'],
      timestamp: data?['timestamp'],
      likes: data?['likes'],
      comments: data?['comments'],
      directReplies: data?['directReplies'],
    );
  }

  Future createNewPost(String posterUsername, String title, String content, int timestamp) async {
    return await forumDatabaseCollection.add({
      'posterUsername': posterUsername,
      'title': title,
      'content': content,
      'timestamp': timestamp,
      'likes': 0,
      'comments': 0,
      'directReplies': [],
    });
  }

  Future addLike(String postId) async {
    return await forumDatabaseCollection.doc(postId).update({
      "likes" : FieldValue.increment(1),
    });
  }

  Future addComment(String postId) async {
    return await forumDatabaseCollection.doc(postId).update({
      "comments" : FieldValue.increment(1),
    });
  }

  Future addReply(String postId, List<dynamic> list) async {
    return await forumDatabaseCollection.doc(postId).update({
      "directReplies" : list,
    });
  }

}
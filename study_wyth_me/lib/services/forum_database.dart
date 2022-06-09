import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:study_wyth_me/models/post.dart';
import 'package:study_wyth_me/services/database.dart';

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
        uid: doc.data().toString().contains('uid') ? doc.get('uid'): '',
        title: doc.data().toString().contains('title') ? doc.get('title'): '',
        content: doc.data().toString().contains('content') ? doc.get('content'): '',
        timestamp: doc.data().toString().contains('timestamp') ? doc.get('timestamp'): 0,
        likes: doc.data().toString().contains('likes') ? doc.get('likes'): [],
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
    return Post(
      postId: snapshot.id,
      uid: data?['uid'],
      title: data?['title'],
      content: data?['content'],
      timestamp: data?['timestamp'],
      likes: data?['likes'],
      comments: data?['comments'],
      directReplies: data?['directReplies'],
    );
  }

  Future createNewPost(String uid, String title, String content, int timestamp) async {
    return await forumDatabaseCollection.add({
      'uid': uid,
      'title': title,
      'content': content,
      'timestamp': timestamp,
      'likes': [],
      'comments': 0,
      'directReplies': [],
    });
  }

  /*
  Future<bool> hasLiked(String postId, String uid) async {
    DocumentReference document = forumDatabaseCollection.doc(postId);
    Post post = await document.get().then((snapshot) => _postDataFromSnapshot(snapshot));

    return post.likes.contains(uid);
  }
  */

  Future changeLikeStatus(String postId, String uid) async {
    DocumentReference document = forumDatabaseCollection.doc(postId);
    Post post = await document.get().then((snapshot) => _postDataFromSnapshot(snapshot));

    DatabaseService databaseService = DatabaseService(uid: post.uid);

    List<dynamic> usersWhoLiked = post.likes;
    if (usersWhoLiked.contains(uid)) {
      usersWhoLiked.remove(uid);
      databaseService.deductPoint();
    } else {
      usersWhoLiked.add(uid);
      databaseService.addPoint();
    }
    await forumDatabaseCollection.doc(postId).update({
      'likes' : usersWhoLiked,
    });
  }

  Future addReply(String postId, String commentId) async {
    DocumentReference document = forumDatabaseCollection.doc(postId);
    Post post = await document.get().then((snapshot) => _postDataFromSnapshot(snapshot));

    post.directReplies.add(commentId);

    return await document.update({
      'comments' : FieldValue.increment(1),
      'directReplies' : post.directReplies,
    });
  }

  Future updateCommentCount(String postId) async {
    DocumentReference document = forumDatabaseCollection.doc(postId);
    return await document.update({
      'comments' : FieldValue.increment(1),
    });
  }

  Stream<List<Post>> searchForumStream(String input) {
    return forumDatabaseCollection
        .where('title', isGreaterThanOrEqualTo: input, isLessThan: input.substring(0, input.length-1) + String.fromCharCode(input.codeUnitAt(input.length - 1) + 1))
        .snapshots()
        .map(forumPostListFromSnapshot);
  }

}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:study_wyth_me/models/comment.dart';
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
        uid: doc.data().toString().contains('uid') ? doc.get('uid'): '',
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

  Future addReply(String uid, String postId, String content) async {
    DocumentReference document = forumDatabaseCollection.doc(postId);
    Post post = await document.get().then((snapshot) => _postDataFromSnapshot(snapshot));

    String commentString = Comment(
      uid: uid,
      timestamp: DateTime.now().millisecondsSinceEpoch,
      content: content,
      likes: 0,
      comments: 0,
      directReplies: []
    ).toJsonString();

    post.directReplies.add(commentString);

    return await document.update({
      "comments" : FieldValue.increment(1),
      "directReplies" : post.directReplies,
    });
  }

  /*
  Future updateReplyLikes(String postId, String commentString) async {
    DocumentReference document = forumDatabaseCollection.doc(postId);
    Post post = await document.get().then((snapshot) => _postDataFromSnapshot(snapshot));

    bool found = false;
    Comment? parentComment;
    List<dynamic> directReplies = post.directReplies;
    while (!found) {
      for (String directReply in directReplies) {
        if (directReply == commentString) {
          found = true;
          break;
        } else if (directReply.contains(commentString)) {
          parentComment = Comment.fromJsonString(directReply);
          directReplies = parentComment.directReplies;
        }
      }
    }

    Comment currComment = Comment.fromJsonString(commentString);
    String newCommentString = Comment(
        uid: currComment.uid,
        timestamp: currComment.timestamp,
        content: currComment.content,
        likes: currComment.likes + 1,
        comments: 0,
        directReplies: currComment.directReplies
    ).toJsonString();

    if (parentComment == null) { // parent is the post
      post.directReplies.replaceRange(start, end, replacements)
    } else { // parent is a comment

    }


    post.directReplies.add(commentString);

    return await document.update({
      "comments" : FieldValue.increment(1),
      "directReplies" : post.directReplies,
    });
  }
  */

}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:study_wyth_me/models/comment.dart';
import 'package:study_wyth_me/services/database.dart';

class CommentsDatabase {

  //collection reference
  final CollectionReference commentsDatabaseCollection = FirebaseFirestore.instance
      .collection('commentsDatabase');

  //get comment document stream
  Stream<Comment> commentData(String commentId) {
    return commentsDatabaseCollection.doc(commentId).snapshots().map<Comment>(_commentDataFromSnapshot);
  }

  // comment data from snapshot
  Comment _commentDataFromSnapshot(DocumentSnapshot snapshot) {
    snapshot = snapshot as DocumentSnapshot<Map<String, dynamic>>;
    final data = snapshot.data();
    return Comment(
      uid: data?['uid'],
      content: data?['content'],
      timestamp: data?['timestamp'],
      likes: data?['likes'],
      comments: data?['comments'],
      directReplies: data?['directReplies'],
    );
  }

  Future createNewComment(String uid, String content) async {
    DocumentReference document = await commentsDatabaseCollection.add({
      'uid': uid,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'content': content,
      'likes': [],
      'comments': 0,
      'directReplies': [],
    });
    return document.id;
  }

  Future changeLikeStatus(String commentId, String uid) async {
    DocumentReference document = commentsDatabaseCollection.doc(commentId);
    Comment comment = await document.get().then((snapshot) => _commentDataFromSnapshot(snapshot));
    DatabaseService databaseService = DatabaseService(uid: comment.uid);
    List<dynamic> usersWhoLiked = comment.likes;
    if (usersWhoLiked.contains(uid)) {
      usersWhoLiked.remove(uid);
      databaseService.deductPoint();
    } else {
      usersWhoLiked.add(uid);
      databaseService.addPoint();
    }
    await commentsDatabaseCollection.doc(commentId).update({
      'likes' : usersWhoLiked,
    });
  }

  Future addReply(String commentId, String newCommentId) async {
    DocumentReference document = commentsDatabaseCollection.doc(commentId);
    Comment comment = await document.get().then((snapshot) => _commentDataFromSnapshot(snapshot));
    comment.directReplies.add(newCommentId);
    await document.update({
      'comments' : FieldValue.increment(1),
      'directReplies' : comment.directReplies,
    });
    return await updateCommentCount(commentId);
  }

  Future updateCommentCount(String commentId) async {
    final parentComments = await commentsDatabaseCollection.where('directReplies', arrayContains: commentId).get();
    if (parentComments.docs.isEmpty) return;
    QueryDocumentSnapshot snapshot = parentComments.docs.first;
    await snapshot.reference.update({
      'comments': FieldValue.increment(1),
    });
    await updateCommentCount(snapshot.id);
  }

}
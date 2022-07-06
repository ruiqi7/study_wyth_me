import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/app_user.dart';

class DatabaseService {

  final String uid;

  DatabaseService({ required this.uid });

  //collection reference
  final CollectionReference userDatabaseCollection = FirebaseFirestore.instance.collection('userDatabase');

  Future createNewUser(String username) async {
    return await userDatabaseCollection.doc(uid).set({
      'verified': false,
      'username': username,
      'map': {},
      'resetMap': false,
      'url': 'https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg',
      'points': 0,
      'duration': 30,
      'friendsId': [uid],
      'friendRequestsSent': [],
      'friendRequestsReceived': [],
      'mythics': {
        'Chimera': false,
        'Kraken': false,
        'Phoenix': false,
        'Dragon': false,
        'Manticore': false,
        'Unicorn': false,
        'Catfish': false,
        'Griffin': false,
        'Kitsune': false,
        'Pegasus': false,
      },
    });
  }

  Future updateStatusToVerified() async {
    return await userDatabaseCollection.doc(uid).update({
      'verified': true,
    });
  }

  Future<String> updateNewModule(String module) async {
    DocumentSnapshot snapshot = await userDatabaseCollection.doc(uid).get();
    Map <String, dynamic> data = snapshot.data() as Map <String, dynamic>;
    if (!data['map'].containsKey(module)) {
      await userDatabaseCollection.doc(uid).update({
        'map.$module': 0,
      });
      return 'Added!';
    } else {
      return 'Module has already been added.';
    }
  }

  Future removeModule(String module) async {
    return await userDatabaseCollection.doc(uid).update({
      'map.$module': FieldValue.delete(),
    });
  }

  // update user's profile picture
  Future updatePicture(String url) async {
    return await userDatabaseCollection.doc(uid).update({
      'url': url,
    });
  }

  // update user's username
  Future updateUsername(String username) async {
    bool usernameUsed = false;
    Query query = userDatabaseCollection.where('username', isEqualTo: username);
    await query.get().then((result) => usernameUsed = result.size != 0);

    if (usernameUsed) {
      return 'This username has been taken up by you or another user.';
    } else {
      await userDatabaseCollection.doc(uid).update({
        'username': username,
      });
      return 'Saved!';
    }
  }

  Future updateModule(String module, int hours) async {
    if (hours >= 30) {
      await userDatabaseCollection.doc(uid).update({
        'points' : FieldValue.increment(hours),
      });
    }

    return await userDatabaseCollection.doc(uid).update({
      'map.$module': FieldValue.increment(hours),
    });
  }

  Future resetModule() async {
    DocumentSnapshot snapshot = await userDatabaseCollection.doc(uid).get();
    Map <String, dynamic> data = snapshot.data() as Map <String, dynamic>;

    if (!data['resetMap']) {
      Map <String, dynamic> currData = data['map'];
      currData.updateAll((key, value) => value = 0);

      await userDatabaseCollection.doc(uid).update({
        'map': currData,
        'resetMap': true,
      });
    }
  }

  Future updateResetStatus() async {
    await userDatabaseCollection.doc(uid).update({
      'resetMap': false,
    });
  }

  Future updateDuration(int minutes) async {
    return await userDatabaseCollection.doc(uid).update({
      'duration': minutes,
    });
  }

  Future updateFriendStatus(String username, String status) async {
    QuerySnapshot? snapshot;
    Query query = userDatabaseCollection.where('username', isEqualTo: username);
    await query.get().then((result) => snapshot = result);

    AppUser friend = userDataListFromSnapshot(snapshot!).single;

    if (uid == friend.uid) { // prevent users from removing themselves as friends
      return 'Das you';
    }

    if (status == "Unfriend") {
      await userDatabaseCollection.doc(uid).update({
        'friendsId': FieldValue.arrayRemove([friend.uid]),
        'friendRequestsReceived': FieldValue.arrayUnion([friend.uid]),
      });

      await userDatabaseCollection.doc(friend.uid).update({
        'friendsId': FieldValue.arrayRemove([uid]),
        'friendRequestsSent': FieldValue.arrayUnion([uid]),
      });
    } else if (status == "Befriend") {
      await userDatabaseCollection.doc(uid).update({
        'friendRequestsReceived': FieldValue.arrayRemove([friend.uid]),
        'friendsId': FieldValue.arrayUnion([friend.uid]),
      });

      await userDatabaseCollection.doc(friend.uid).update({
        'friendRequestsSent': FieldValue.arrayRemove([uid]),
        'friendsId': FieldValue.arrayUnion([uid]),
      });
    } else if (status == "Unrequest") {
      await userDatabaseCollection.doc(uid).update({
        'friendRequestsSent': FieldValue.arrayRemove([friend.uid]),
      });

      await userDatabaseCollection.doc(friend.uid).update({
        'friendRequestsReceived': FieldValue.arrayRemove([uid]),
      });
    } else {
      await userDatabaseCollection.doc(uid).update({
        'friendRequestsSent': FieldValue.arrayUnion([friend.uid]),
      });

      await userDatabaseCollection.doc(friend.uid).update({
        'friendRequestsReceived': FieldValue.arrayUnion([uid]),
      });
    }

    return '';
  }

  Future claimMythic(String mythic) async {
    return await userDatabaseCollection.doc(uid).update({
      'mythics.$mythic': true,
    });
  }

  Future addPoint() async {
    return await userDatabaseCollection.doc(uid).update({
      'points': FieldValue.increment(1),
    });
  }

  Future deductPoint() async {
    return await userDatabaseCollection.doc(uid).update({
      'points': FieldValue.increment(-1),
    });
  }

  //get userDatabase stream
  Stream<QuerySnapshot> get userDatabaseStream {
    return userDatabaseCollection.snapshots();
  }

  //get userDatabase stream of top 20 users within the community
  Stream<List<AppUser>> userLeaderboardStream(bool isCommunity, List<dynamic> list) {
    if (isCommunity) {
      return userDatabaseCollection
          .where('verified', isEqualTo: true)
          .snapshots()
          .map(userDataListFromSnapshot);
    } else {
      return userDatabaseCollection
          .where(FieldPath.documentId, whereIn: list)
          .where('verified', isEqualTo: true)
          .snapshots()
          .map(userDataListFromSnapshot);
    }
  }

  Stream<List<AppUser>> searchUserStream(String input) {
    return userDatabaseCollection
        .where('username', isGreaterThanOrEqualTo: input, isLessThan: input.substring(0, input.length-1) + String.fromCharCode(input.codeUnitAt(input.length - 1) + 1))
        .where('verified', isEqualTo: true)
        .snapshots()
        .map(userDataListFromSnapshot);
  }

  List<AppUser> userDataListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return AppUser(
        uid: doc.id,
        username: doc.get('username'),
        map: doc.get('map'),
        url: doc.get('url'),
        points: doc.data().toString().contains('points') ? doc.get('points') : '',
        duration: doc.get('duration'),
        friendsId: doc.data().toString().contains('friendsId') ? doc.get('friendsId'): [doc.id],
        friendRequestsSent: doc.data().toString().contains('friendRequestsSent') ? doc.get('friendRequestsSent'): [],
        friendRequestsReceived: doc.data().toString().contains('friendRequestsReceived') ? doc.get('friendRequestsReceived'): [],
        mythics: doc.get('mythics'),
      );
    }).toList();
  }

  //get user document stream
  Stream<AppUser> get userData {
    return userDatabaseCollection.doc(uid).snapshots().map<AppUser>(
        _userDataFromSnapshot);
  }

  //userData from snapshot
  AppUser _userDataFromSnapshot(DocumentSnapshot snapshot) {
    snapshot = snapshot as DocumentSnapshot<Map<String, dynamic>>;
    final data = snapshot.data();
    return AppUser(
      uid: snapshot.id,
      username: data?['username'],
      map: data?['map'],
      url: data?['url'],
      points: data?['points'],
      duration: data?['duration'],
      friendsId: data?['friendsId'],
      friendRequestsSent: data?['friendRequestsSent'],
      friendRequestsReceived: data?['friendRequestsReceived'],
      mythics: data?['mythics'],
    );
  }

  Future deleteUserDocument() async {
    return await FirebaseFirestore.instance.runTransaction((transaction) async =>
      transaction.delete(userDatabaseCollection.doc(uid)));
  }
}
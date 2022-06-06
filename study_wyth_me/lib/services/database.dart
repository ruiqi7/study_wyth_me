import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/app_user.dart';

class DatabaseService {

  final String uid;

  DatabaseService({ required this.uid });

  //collection reference
  final CollectionReference userDatabaseCollection = FirebaseFirestore.instance
      .collection('userDatabase');

  Future createNewUser(String username) async {
    return await userDatabaseCollection.doc(uid).set({
      'username': username,
      'map': {},
      'url': 'https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg',
      'points': 0,
      'duration': 30,
      'friendsUsername': [username],
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

  Future updateModule(String module, int hours) async {
    return await userDatabaseCollection.doc(uid).update({
      'map.$module': FieldValue.increment(hours),
      'points' : FieldValue.increment(hours),
    });
  }

  Future updateDuration(int minutes) async {
    return await userDatabaseCollection.doc(uid).update({
      'duration': minutes,
    });
  }

  Future addFriend(String username) async {
    List<dynamic> list = [username];
    return await userDatabaseCollection.doc(uid).update({
      'friendsUsername': FieldValue.arrayUnion(list),
    });
  }

  Future removeFriend(String username) async {
    List<dynamic> list = [username];
    return await userDatabaseCollection.doc(uid).update({
      'friendsUsername': FieldValue.arrayRemove(list),
    });
  }

  Future claimMythic(String mythic) async {
    return await userDatabaseCollection.doc(uid).update({
      'mythics.$mythic': true,
    });
  }

  //get userDatabase stream
  Stream<QuerySnapshot> get userDatabaseStream {
    return userDatabaseCollection.snapshots();
  }

  //get userDatabase stream of top 20 users within the community
  Stream<List<AppUser>> userLeaderboardStream(bool isCommunity, List<String> list) {
    if (isCommunity) {
      return userDatabaseCollection
          .orderBy("points", descending: true)
          .limit(20)
          .snapshots()
          .map(_userDataListFromSnapshot);
    } else {
      return userDatabaseCollection
          .where("username", whereIn: list)
          .orderBy("points", descending: true)
          .limit(20)
          .snapshots()
          .map(_userDataListFromSnapshot);
    }
  }

  Stream<List<AppUser>> searchUserStream(String input) {
    return userDatabaseCollection
        .where('username', isGreaterThanOrEqualTo: input, isLessThan: input.substring(0, input.length-1) + String.fromCharCode(input.codeUnitAt(input.length - 1) + 1))
        .snapshots()
        .map(_userDataListFromSnapshot);
  }

  List<AppUser> _userDataListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return AppUser(
        uid: doc.data().toString().contains('uid') ? doc.get('uid') : '',
        username: doc.get('username'),
        map: doc.get('map'),
        url: doc.get('url'),
        points: doc.data().toString().contains('points') ? doc.get('points') : '',
        duration: doc.get('duration'),
        friendsUsername: doc.data().toString().contains('friendsUsername') ? doc.get('friendsUsername'): [],
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
      uid: uid,
      username: data?['username'],
      map: data?['map'],
      url: data?['url'],
      points: data?['points'],
      duration: data?['duration'],
      friendsUsername: data?['friendsUsername'],
      mythics: data?['mythics'],
    );
  }
}
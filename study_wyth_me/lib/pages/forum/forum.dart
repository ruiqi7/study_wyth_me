import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:study_wyth_me/models/app_user.dart';
import 'package:study_wyth_me/pages/forum/forum_post.dart';
import 'package:study_wyth_me/pages/forum/new_post.dart';
import 'package:study_wyth_me/pages/forum/search_forum.dart';
import 'package:study_wyth_me/pages/loading.dart';
import 'package:study_wyth_me/services/database.dart';
import 'package:study_wyth_me/services/forum_database.dart';
import 'package:study_wyth_me/shared/bar_widgets.dart';
import '../../shared/constants.dart';

class Forum extends StatefulWidget {
  const Forum({Key? key}) : super(key: key);

  @override
  State<Forum> createState() => _ForumState();
}

class _ForumState extends State<Forum> {

  final String uid = FirebaseAuth.instance.currentUser!.uid;
  final _position = 2;

  final ForumDatabase forumDatabase = ForumDatabase();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: forumDatabase.forumDatabaseStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> querySnapshot) {
          if (querySnapshot.hasData) {
            List postList = forumDatabase.forumPostListFromSnapshot(querySnapshot.data!);
            postList.sort((a, b) => b.compareTo(a));

            return StreamBuilder<AppUser>(
                stream: DatabaseService(uid: uid).userData,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    AppUser appUser = snapshot.data!;

                    return Scaffold(
                      appBar: PreferredSize(
                            preferredSize: const Size.fromHeight(75.0),
                            child: Container(
                              color: whiteOpacity20,
                              child: SafeArea(
                                child: Container(
                                  color: transparent,
                                  height: 75.0,
                                  child: Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10.0),
                                        child: CircleAvatar(
                                          radius: 25.0,
                                          backgroundImage: NetworkImage(appUser.url),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          child: Text(
                                            appUser.username,
                                            style: chewyTextStyle.copyWith(fontSize: 27.5),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        key: const Key('CreateNewPostButton'),
                                        padding: const EdgeInsets.only(right: 0.0),
                                        icon: const Icon(Icons.add, color: Colors.white),
                                        iconSize: 45,
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              PageTransition(child: const NewPost(), type: PageTransitionType.bottomToTop)
                                          );
                                        },
                                      ),
                                      IconButton(
                                        key: const Key('SearchPostButton'),
                                        padding: const EdgeInsets.only(right: 10.0),
                                        icon: const Icon(Icons.search, color: Colors.white),
                                        iconSize: 40,
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              PageTransition(child: const SearchForum(), type: PageTransitionType.bottomToTop)
                                          );
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                        ),
                      backgroundColor: darkBlueBackground,
                      body: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Scrollbar(
                              radius: const Radius.circular(10.0),
                              child: ListView.builder(
                                padding: const EdgeInsets.only(top: 15.0),
                                itemCount: postList.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return ForumPost(post: postList[index]);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      bottomNavigationBar: Container(
                        color: whiteOpacity20,
                        child: navigationBar(context, _position),
                      )
                    );
                  } else {
                    return const Loading();
                  }
                }
            );
          } else {
            return const Loading();
          }
        }
    );
  }
}

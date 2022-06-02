import 'package:flutter/material.dart';
import 'package:study_wyth_me/pages/forum/thread.dart';
import 'package:study_wyth_me/shared/constants.dart';

class ForumPost extends StatefulWidget {
  const ForumPost({Key? key}) : super(key: key);

  @override
  State<ForumPost> createState() => _ForumPostState();
}

class _ForumPostState extends State<ForumPost> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 25.0),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        color: Color.fromRGBO(255, 255, 255, 0.10),
      ),
      child: Column(
        children: <Widget> [
          const SizedBox(height: 15.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget> [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: CircleAvatar(
                  radius: 25.0,
                  backgroundImage: NetworkImage('https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg'),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget> [
                    Text(
                      'Time to pray to IS1103 god',
                      style: oswaldTextStyle.copyWith(fontSize: 17.5, color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'posted by AStudentBarelySurviving 5 hours ago',
                      style: oswaldTextStyle.copyWith(fontSize: 10, color: Colors.grey),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 12.0),
                      child: Text(
                        'Has anyone ever prayed to the IS1103 god and been',
                        style: oswaldTextStyle.copyWith(fontSize: 12.5, color: Colors.white),
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: 40.0,
                padding: const EdgeInsets.only(top: 5.0),
                child: IconButton(
                  icon: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
                  iconSize: 25,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Thread())
                    );
                  },
                ),
              )
            ],
          ),
          const Divider(color: Colors.white, height: 0.0),
          Container(
            padding: const EdgeInsets.only(bottom: 10.0),
            height: 35.0,
            child: Row(
              children: <Widget> [
                Container(
                  padding: const EdgeInsets.fromLTRB(6.0, 0.0, 0.0, 0.0),
                  height: 50.0,
                  width: 40.0,
                  child: IconButton(
                    icon: const Icon(Icons.chat_bubble_outline, color: Colors.grey),
                    iconSize: 20,
                    onPressed: () {
                      // increase count by 1
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    '2',
                    style: oswaldTextStyle.copyWith(fontSize: 12.0, color: Colors.grey),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(6.0, 0.0, 0.0, 0.0),
                  height: 50.0,
                  width: 40.0,
                  child: IconButton(
                    icon: const Icon(Icons.thumb_up_alt_outlined, color: Colors.grey),
                    iconSize: 20,
                    onPressed: () {
                      // increase count by 1
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    '5',
                    style: oswaldTextStyle.copyWith(fontSize: 12.0, color: Colors.grey),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

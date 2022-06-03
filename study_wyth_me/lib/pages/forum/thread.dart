import 'package:flutter/material.dart';
import 'package:study_wyth_me/pages/forum/thread_reply.dart';
import 'package:study_wyth_me/pages/forum/thread_response.dart';
import 'package:study_wyth_me/shared/bar_widgets.dart';
import 'package:study_wyth_me/shared/constants.dart';

class Thread extends StatefulWidget {
  const Thread({Key? key}) : super(key: key);

  @override
  State<Thread> createState() => _ThreadState();
}

_mainPost(context) => Container(
  decoration: const BoxDecoration(
    color: whiteOpacity10,
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
                    'Has anyone ever prayed to the IS1103 god and been successful',
                    style: oswaldTextStyle.copyWith(fontSize: 12.5, color: Colors.white),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(width: 5.0),
        ],
      ),
      noHeightHorizontalDivider,
      SizedBox(
        height: 35.0,
        child: Row(
          children: <Widget> [
            Container(
              padding: const EdgeInsets.fromLTRB(6.0, 0.0, 0.0, 10.0),
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
              padding: const EdgeInsets.only(top: 8.0, bottom: 10.0),
              child: Text(
                '2',
                style: oswaldTextStyle.copyWith(fontSize: 12.0, color: Colors.grey),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(6.0, 0.0, 0.0, 10.0),
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
              padding: const EdgeInsets.only(top: 8.0, bottom: 10.0),
              child: Text(
                '5',
                style: oswaldTextStyle.copyWith(fontSize: 12.0, color: Colors.grey),
              ),
            ),
            const Expanded(
              child: SizedBox(),
            ),
            SizedBox(
              width: 50.0,
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(0.0),
                ),
                child: Text(
                  'Reply',
                  style: oswaldTextStyle.copyWith(fontSize: 12.0, color: Colors.grey),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder:
                      (context) => ThreadReply(
                          mainPost: _mainPost(context),
                          replyPost: const SizedBox(width: 0.0, height: 0.0),
                          hasReplyPost: false,
                      )
                    )
                  );
                },
              ),
            ),
          ],
        ),
      )
    ],
  ),
);

class _ThreadState extends State<Thread> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlueBackground,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          topBarWithBackButton(context),
          Expanded(
            child: Scrollbar(
              radius: const Radius.circular(10.0),
              child: ListView.builder(
                padding: const EdgeInsets.all(15.0),
                itemCount: 3,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return _mainPost(context);
                  } else {
                    return Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: ThreadResponse(
                        threadLength: 5,
                        position: 1,
                        nextIsInner: true,
                        mainPost: _mainPost(context),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

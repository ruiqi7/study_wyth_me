import 'package:flutter/material.dart';
import 'package:study_wyth_me/models/post.dart';
import 'package:study_wyth_me/pages/forum/thread_reply.dart';
import 'package:study_wyth_me/shared/constants.dart';

class ThreadResponse extends StatefulWidget {
  final Post post;
  final String profile;
  final int threadLength;
  final int position;
  final bool nextIsInner;
  const ThreadResponse({Key? key, required this.post, required this.profile, required this.threadLength, required this.position, required this.nextIsInner}) : super(key: key);

  @override
  State<ThreadResponse> createState() => _ThreadResponseState();
}

class _ThreadResponseState extends State<ThreadResponse> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(0.0),
          decoration: BoxDecoration(
            color: widget.position == 1 ? whiteOpacity10 : Colors.transparent,
          ),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget> [
                Container(
                  padding: widget.position == 1 ? const EdgeInsets.only(left: 10.0) : const EdgeInsets.only(left: 0.0),
                  decoration: const BoxDecoration(
                    //color: Colors.red,
                  ),
                  width: widget.position == 1 ? 50.0 : 40.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const <Widget> [
                      SizedBox(height: 10.0),
                      CircleAvatar(
                        radius: 20.0,
                        backgroundImage: NetworkImage('https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg'),
                      ),
                      Expanded(
                        child: VerticalDivider(
                          color: Colors.grey,
                          width: 80.0,
                          thickness: 0.5,
                          indent: 10.0,
                          endIndent: 10.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      //color: Colors.pink,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget> [
                        Container(
                          padding: const EdgeInsets.fromLTRB(10.0, 25.0, 5.0, 15.0),
                          child: Text(
                            'AStudentWhoSurvived replied 1 hour ago',
                            style: oswaldTextStyle.copyWith(fontSize: 9.0, color: Colors.grey),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, bottom: 5.0, right: 5.0),
                          child: Text(
                            'Has anyone ever prayed to the IS1103 god and been successful',
                            style: oswaldTextStyle.copyWith(fontSize: 12.5, color: Colors.white),
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            //color: Colors.deepPurpleAccent,
                          ),
                          height: 35.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget> [
                              IconButton(
                                padding: const EdgeInsets.fromLTRB(10.0, 2.0, 0.0, 0.0),
                                constraints: const BoxConstraints(),
                                icon: const Icon(Icons.chat_bubble_outline, color: Colors.grey),
                                iconSize: 20,
                                onPressed: () {
                                  // increase count by 1
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(5.0, 8.0, 12.0, 10.0),
                                child: Text(
                                  '2',
                                  style: oswaldTextStyle.copyWith(fontSize: 12.0, color: Colors.grey),
                                ),
                              ),
                              IconButton(
                                padding: const EdgeInsets.fromLTRB(0.0, 2.0, 0.0, 0.0),
                                constraints: const BoxConstraints(),
                                icon: const Icon(Icons.thumb_up_alt_outlined, color: Colors.grey),
                                iconSize: 20,
                                onPressed: () {
                                  // increase count by 1
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(5.0, 8.0, 0.0, 10.0),
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
                                              post: widget.post,
                                              profile: widget.profile,
                                              replyPost: ThreadResponse(
                                                  post: widget.post,
                                                  profile: widget.profile,
                                                  threadLength: 1,
                                                  position: 1,
                                                  nextIsInner: true,
                                              ),
                                              hasReplyPost: true,
                                          )
                                        )
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        widget.nextIsInner && widget.position == 5 && widget.threadLength > 1
                          ? Container(
                              height: 25.0,
                              margin: const EdgeInsets.only(left: 10.0, bottom: 10.0),
                              decoration: largeRadiusRoundedBox,
                              child: TextButton(
                                child: const Text('See more replies'),
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.all(5.0),
                                  primary: Colors.white,
                                  textStyle: oswaldTextStyle.copyWith(fontSize: 12.0),
                                ),
                                onPressed: () {
                                  // call Thread()
                                },
                              ),
                            )
                          : const SizedBox(width: 0.0, height: 0.0),
                        widget.nextIsInner && widget.threadLength > 1
                          ? ThreadResponse(
                              post: widget.post,
                              profile: widget.profile,
                              threadLength: widget.threadLength - 1,
                              position: widget.position == 5 ? 1 : widget.position + 1,
                              nextIsInner: false,
                            )
                          : const SizedBox(width: 0.0, height: 0.0),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        widget.nextIsInner
          ? const SizedBox(width: 0.0, height: 0.0)
          : ThreadResponse(
              post: widget.post,
              profile: widget.profile,
              threadLength: widget.threadLength,
              position: widget.position,
              nextIsInner: true,
        ),
      ],
    );
  }
}

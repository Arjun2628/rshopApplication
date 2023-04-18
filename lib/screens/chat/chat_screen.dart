import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_project/chatModels/chat_room_model.dart';
import 'package:first_project/chatModels/message_model.dart';
import 'package:first_project/chatModels/user_model.dart';
import 'package:first_project/main.dart';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ChatScreen extends StatefulWidget {
  // final UserMOdel targetUser;
  // Future<UserMOdel> targetUser;
  UserMOdel? targetUser;
  final ChatRoomModel chatroom;
  UserMOdel? usermodel;
  User? user;
  ChatScreen({
    super.key,
    required this.targetUser,
    required this.chatroom,
    this.usermodel,
    this.user,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String a = '';
  String? month;
  User? firebaseUser = FirebaseAuth.instance.currentUser;

  TextEditingController messageController = TextEditingController();

  ScrollController _scrollController = ScrollController();

  dynamic timeData;

  void sendMessage() async {
    String message = messageController.text.trim();
    messageController.clear();

    if (message != '') {
      MessageModel newMessage = MessageModel(
          messageId: uuid.v1(),
          sender: firebaseUser!.uid,
          creatDon: DateTime.now(),
          text: message,
          seen: false);

      FirebaseFirestore.instance
          .collection('chatrooms')
          .doc(widget.chatroom.chatroomId)
          .collection('messages')
          .doc(newMessage.messageId)
          .set(newMessage.toMap());

      widget.chatroom.lastMessage = message;
      widget.chatroom.creatDon = DateTime.now();
      FirebaseFirestore.instance
          .collection('chatrooms')
          .doc(widget.chatroom.chatroomId)
          .set(widget.chatroom.toMap());

      log('message send!');
    }
  }

  DateTime? lastday;

  Future<void> lsmMessage() async {
    timeData = await FirebaseFirestore.instance
        .collection('chatrooms')
        .doc(widget.chatroom.chatroomId)
        .get();

    lastday = timeData.creatDon.toDate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(1),
                child: CircleAvatar(
                  backgroundColor: Colors.black,
                  backgroundImage:
                      NetworkImage(widget.targetUser!.photo.toString()),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(widget.targetUser!.name.toString())
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('lib/assets/images/chatBg.jpg'))),
        child: SafeArea(
            child: Column(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('chatrooms')
                    .doc(widget.chatroom.chatroomId)
                    .collection('messages')
                    .orderBy(
                      'creatDon',
                    )
                    .snapshots(),
                builder: ((context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.hasData) {
                      QuerySnapshot dataSnapshot =
                          snapshot.data as QuerySnapshot;

                      DateTime? lastTime;
                      SchedulerBinding.instance
                          .addPostFrameCallback((timeStamp) {
                        _scrollController
                            .jumpTo(_scrollController.position.maxScrollExtent);
                      });
                      return ListView.builder(
                        // reverse: true,
                        controller: _scrollController,
                        itemCount: dataSnapshot.docs.length,
                        itemBuilder: ((context, index) {
                          MessageModel currentMessage = MessageModel.fromMap(
                              dataSnapshot.docs[index].data()
                                  as Map<String, dynamic>);

                          if (currentMessage.creatDon!.toLocal().month == 1) {
                            month = 'January';
                          } else if (currentMessage.creatDon!.toLocal().month ==
                              2) {
                            month = 'February';
                          } else if (currentMessage.creatDon!.toLocal().month ==
                              3) {
                            month = 'March';
                          } else if (currentMessage.creatDon!.toLocal().month ==
                              4) {
                            month = ' April';
                          } else if (currentMessage.creatDon!.toLocal().month ==
                              5) {
                            month = 'May';
                          } else if (currentMessage.creatDon!.toLocal().month ==
                              6) {
                            month = 'June';
                          } else if (currentMessage.creatDon!.toLocal().month ==
                              7) {
                            month = 'July';
                          } else if (currentMessage.creatDon!.toLocal().month ==
                              8) {
                            month = 'August';
                          } else if (currentMessage.creatDon!.toLocal().month ==
                              9) {
                            month = 'September';
                          } else if (currentMessage.creatDon!.toLocal().month ==
                              10) {
                            month = ' October';
                          } else if (currentMessage.creatDon!.toLocal().month ==
                              11) {
                            month = 'November';
                          } else {
                            month = 'December';
                          }
                          if (lastTime == null ||
                              lastTime!
                                      .difference(currentMessage.creatDon!)
                                      .inDays !=
                                  0) {
                            lastTime = currentMessage.creatDon;
                            return Column(
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade400,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                          '$month ${currentMessage.creatDon!.toLocal().day.toString()} ${currentMessage.creatDon!.toLocal().year.toString()}'),
                                    )),
                                Row(
                                  mainAxisAlignment:
                                      currentMessage.sender == firebaseUser!.uid
                                          ? MainAxisAlignment.end
                                          : MainAxisAlignment.start,
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 2),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 10),
                                          decoration: BoxDecoration(
                                              color: currentMessage.sender ==
                                                      firebaseUser!.uid
                                                  ? Colors.blue
                                                  : Colors.grey,
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: currentMessage
                                                            .sender ==
                                                        firebaseUser!.uid
                                                    ? const Radius.circular(10)
                                                    : const Radius.circular(0),
                                                topLeft:
                                                    const Radius.circular(10),
                                                topRight:
                                                    const Radius.circular(10),
                                                bottomRight: currentMessage
                                                            .sender ==
                                                        firebaseUser!.uid
                                                    ? const Radius.circular(0)
                                                    : const Radius.circular(10),
                                              )),
                                          child: Column(
                                            children: [
                                              Text(
                                                currentMessage.text.toString(),
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          right: 5,
                                          bottom: 2,
                                          child: Text(
                                            '${currentMessage.creatDon!.toLocal().hour.toString()}:${currentMessage.creatDon!.toLocal().minute.toString()}',
                                            style: const TextStyle(
                                                fontSize: 10,
                                                color: Colors.black38),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            );
                          } else {
                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      currentMessage.sender == firebaseUser!.uid
                                          ? MainAxisAlignment.end
                                          : MainAxisAlignment.start,
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 2),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 10),
                                          decoration: BoxDecoration(
                                              color: currentMessage.sender ==
                                                      firebaseUser!.uid
                                                  ? Colors.blue
                                                  : Colors.grey,
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: currentMessage
                                                            .sender ==
                                                        firebaseUser!.uid
                                                    ? const Radius.circular(10)
                                                    : const Radius.circular(0),
                                                topLeft:
                                                    const Radius.circular(10),
                                                topRight:
                                                    const Radius.circular(10),
                                                bottomRight: currentMessage
                                                            .sender ==
                                                        firebaseUser!.uid
                                                    ? const Radius.circular(0)
                                                    : const Radius.circular(10),
                                              )),
                                          child: Column(
                                            children: [
                                              Text(
                                                currentMessage.text.toString(),
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          right: 5,
                                          bottom: 2,
                                          child: Text(
                                            '${currentMessage.creatDon!.toLocal().hour.toString()}:${currentMessage.creatDon!.toLocal().minute.toString()}',
                                            style: const TextStyle(
                                                fontSize: 10,
                                                color: Colors.black38),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }

                          // return Text('hello');
                        }),
                      );
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: Text(
                            'An error occued! check your internet connection'),
                      );
                    } else {
                      return const Center(
                        child: Text('Say hai to your friend'),
                      );
                    }
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
              ),
            )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: const Color.fromARGB(255, 160, 157, 157),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                  child: Row(
                    children: [
                      Flexible(
                        child: TextField(
                          style: const TextStyle(color: Colors.white),
                          maxLines: null,
                          controller: messageController,
                          decoration: InputDecoration(
                              hintText: 'Type here',
                              prefixIcon: Icon(
                                Icons.emoji_emotions_outlined,
                                color: Colors.black.withOpacity(0.5),
                              ),
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide.none)),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            sendMessage();
                          },
                          icon: const Icon(
                            Icons.send,
                            color: Colors.black,
                          ))
                    ],
                  ),
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}

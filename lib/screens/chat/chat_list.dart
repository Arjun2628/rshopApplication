import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:first_project/chatModels/chat_room_model.dart';
import 'package:first_project/chatModels/user_model.dart';
import 'package:first_project/functions/firebase_helper.dart';
import 'package:first_project/screens/chat/chat_screen.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ChatList extends StatefulWidget {
  UserMOdel? usermodel;
  dynamic data;
  User? user;
  ChatList({super.key, this.user, this.usermodel, this.data});

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  @override
  Widget build(BuildContext context) {
    User? firebaseUser = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
        actions: [
          CircleAvatar(
            backgroundImage: NetworkImage(widget.data['photo']),
            // widget.usermodel!.photo.toString()
          ),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body: SafeArea(
          child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chatrooms')
            .where('participants.${firebaseUser!.uid}', isEqualTo: true)

            // .where('particiapants.${firebaseUser!.uid}', isEqualTo: true)
            .snapshots(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              QuerySnapshot chatRoomSnapshot = snapshot.data as QuerySnapshot;
              log(chatRoomSnapshot.docs.length.toString());
              return ListView.builder(
                itemCount: chatRoomSnapshot.docs.length,
                itemBuilder: (context, index) {
                  ChatRoomModel chatRoomModel = ChatRoomModel.fromMap(
                      chatRoomSnapshot.docs[index].data()
                          as Map<String, dynamic>);

                  // String a = chatRoomModel.lastMessage.toString();

                  Map<String, dynamic> participants =
                      chatRoomModel.participants!;

                  List<String> participantKeys = participants.keys.toList();
                  participantKeys.remove(firebaseUser.uid);

                  return FutureBuilder(
                    future: FirebaseHelper.getUserNameById(participantKeys[0]),
                    builder: (context, userData) {
                      if (userData.connectionState == ConnectionState.done) {
                        if (userData.data != null) {
                          UserMOdel targetUser = userData.data as UserMOdel;
                          return Column(
                            children: [
                              ListTile(
                                onTap: (() {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: ((context) {
                                    return ChatScreen(
                                      targetUser: targetUser,
                                      chatroom: chatRoomModel,
                                      user: widget.user,
                                      usermodel: widget.usermodel,
                                    );
                                  })));
                                }),
                                leading: CircleAvatar(
                                  radius: 35,
                                  backgroundImage:
                                      NetworkImage(targetUser.photo.toString()),
                                ),
                                title: Text(
                                  targetUser.name.toString(),
                                  style: const TextStyle(color: Colors.black),
                                ),
                                subtitle: Text(
                                  chatRoomModel.lastMessage.toString(),
                                  maxLines: 1,
                                ),
                                trailing: Text(
                                    '${chatRoomModel.creatDon!.toLocal().hour.toString()}:${chatRoomModel.creatDon!.toLocal().minute.toString()}'),
                              ),
                              const Divider()
                            ],
                          );
                        } else {
                          return Container();
                        }
                      } else {
                        return Container();
                      }
                    },
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              return const Center(
                child: Text('No chats'),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
      )),
    );
  }
}

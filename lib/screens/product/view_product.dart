import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:first_project/chatModels/chat_room_model.dart';
import 'package:first_project/main.dart';
import 'package:first_project/screens/chat/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../chatModels/user_model.dart';

// ignore: must_be_immutable
class ViewProduct extends StatefulWidget {
  dynamic data;
  UserMOdel? usermodel;
  User? user;
  ViewProduct({super.key, this.data, this.user, this.usermodel});

  @override
  State<ViewProduct> createState() => _ViewProductState();
}

class _ViewProductState extends State<ViewProduct> {
  UserMOdel? userInfo2;
  double? latitude;

  double? longitude;

  User? firebaseUser = FirebaseAuth.instance.currentUser;
  Future<ChatRoomModel?> getChatRoomModel(dynamic data) async {
    ChatRoomModel? chatRoom;

    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('chatrooms')
        .where("participants.${firebaseUser!.uid}", isEqualTo: true)
        .where('participants.${userInfo2?.uid}', isEqualTo: true)
        .get();

    if (snapshot.docs.isNotEmpty) {
      var docData = snapshot.docs[0].data();
      ChatRoomModel existingChatroom =
          ChatRoomModel.fromMap(docData as Map<String, dynamic>);

      chatRoom = existingChatroom;
    } else {
      ChatRoomModel newChatroom = ChatRoomModel(
          chatroomId: uuid.v1(),
          lastMessage: '',
          participants: {
            firebaseUser!.uid: true,
            userInfo2!.uid.toString(): true,
          },
          users: [firebaseUser!.uid, userInfo2!.uid.toString()],
          creatDon: DateTime.now());
      await FirebaseFirestore.instance
          .collection('chatrooms')
          .doc(newChatroom.chatroomId)
          .set(newChatroom.toMap());

      chatRoom = newChatroom;
    }

    return chatRoom;
  }

  Future<void> userFetching(dynamic data) async {
    String userdata = widget.data.user;

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final userInfo = await firestore.collection('user').doc(userdata).get();

    userInfo2 = UserMOdel.fromMap(userInfo.data()!);
    setState(() {
      latitude = userInfo2!.latitude ?? 11.4429;
      longitude = userInfo2!.longitude ?? 75.6976;
    });
  }

  @override
  void initState() {
    super.initState();

    userFetching(widget.data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SafeArea(
              child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              height: 220,
              decoration: BoxDecoration(
                border: Border.all(width: 0.5, color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child:
                  Image(fit: BoxFit.cover, image: NetworkImage(widget.data.ph)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                  border: Border.all(width: 0.5, color: Colors.grey),
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 15, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.data.user,
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(widget.data.details,
                        style: const TextStyle(fontSize: 20))
                  ],
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(15, 8, 8, 8),
            child: Text(
              'Type',
              style: TextStyle(fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                  border: Border.all(width: 0.5, color: Colors.grey),
                  borderRadius: BorderRadius.circular(15)),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(15, 8, 8, 8),
            child: Text(
              'Details',
              style: TextStyle(fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                  border: Border.all(width: 0.5, color: Colors.grey),
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 15, 0, 0),
                child: Text(widget.data.prize),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(15, 8, 8, 8),
            child: Text(
              'Location',
              style: TextStyle(fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: latitude == null
                ? Container(
                    width: double.infinity,
                    height: 150,
                    decoration: BoxDecoration(
                        border: Border.all(width: 0.5, color: Colors.grey),
                        borderRadius: BorderRadius.circular(15)),
                    child: const Center(child: CircularProgressIndicator()),
                  )
                : Container(
                    width: double.infinity,
                    height: 150,
                    decoration: BoxDecoration(
                        border: Border.all(width: 0.5, color: Colors.grey),
                        borderRadius: BorderRadius.circular(15)),
                    child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                            target: LatLng(latitude!, longitude!), zoom: 14)),
                  ),
          ),
        ],
      ))),
      floatingActionButton: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 20, 20),
        child: SizedBox(
          height: 80,
          width: 80,
          child: FloatingActionButton(
            onPressed: () async {
              ChatRoomModel? chatRoomModel =
                  await getChatRoomModel(widget.data);

              if (chatRoomModel != null) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) => ChatScreen(
                          user: firebaseUser,
                          usermodel: widget.usermodel,
                          targetUser: userInfo2,
                          chatroom: chatRoomModel,
                        ))));
              }
            },
            child: Column(
              children: const [
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Icon(Icons.forum_outlined),
                ),
                Text('Chat')
              ],
            ),
          ),
        ),
      ),
    );
  }
}

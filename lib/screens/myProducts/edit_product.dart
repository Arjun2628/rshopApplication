import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_project/chatModels/chat_room_model.dart';
import 'package:first_project/chatModels/user_model.dart';
import 'package:first_project/screens/myProducts/edit_and_add_product.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../main.dart';
import '../chat/chat_screen.dart';

class EditProduct extends StatefulWidget {
  dynamic data;
  UserMOdel? usermodel;
  User? user;
  // dynamic user;
  EditProduct({super.key, this.data, this.user, this.usermodel});

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  UserMOdel? userInfo2;
  double? latitude;
  // 11.4429;
  double? longitude;

  Future<ChatRoomModel?> getChatRoomModel(dynamic data) async {
    ChatRoomModel? chatRoom;

    User? firebaseUser = FirebaseAuth.instance.currentUser;

    print(widget.usermodel?.uid);
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('chatrooms')
        .where("participants.${firebaseUser!.uid}", isEqualTo: true)
        .where('participants.${userInfo2?.uid}', isEqualTo: true)
        .get();

    if (snapshot.docs.isNotEmpty) {
      // fetching existing chatroom
      var docData = snapshot.docs[0].data();
      ChatRoomModel existingChatroom =
          ChatRoomModel.fromMap(docData as Map<String, dynamic>);

      chatRoom = existingChatroom;
      print('user existing');
    } else {
      // creating new chatroom

      ChatRoomModel newChatroom = ChatRoomModel(
          chatroomId: uuid.v1(),
          lastMessage: '',
          participants: {
            // widget.usermodel!.uid.toString(): true,
            firebaseUser.uid: true,
            userInfo2!.uid.toString(): true,
          },
          users: [firebaseUser.uid, userInfo2!.uid.toString()],
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
    // ignore: unused_local_variable
    UserMOdel userModelInfo;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final userInfo = await firestore.collection('user').doc(userdata).get();

    userModelInfo = UserMOdel.fromMap(userInfo.data()!);

    // return userModelInfo;
    setState(() {
      // userInfo2 = userModelInfo;
      latitude = userInfo2!.latitude ?? 11.4429;
      longitude = userInfo2!.longitude ?? 75.6976;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Future<UserMOdel> targetUser =
    userFetching(widget.data);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product details'),
        centerTitle: true,
      ),
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
                      widget.data.productname,
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text("₹${widget.data.prize}",
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
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(widget.data.type)),
              ),
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
                child: Text(widget.data.details),
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => UpdateProduct(
                              data: widget.data,
                            ))));
              },
              child: const Text('Edit product'))
        ],
      ))),
    );
  }
}

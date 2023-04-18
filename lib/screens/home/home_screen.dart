import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_project/chatModels/user_model.dart';

import 'package:first_project/models/model_list.dart';
import 'package:first_project/screens/chat/chat_list.dart';

import 'package:first_project/screens/home/search/search_list.dart';
import 'package:first_project/screens/home/widgets/bikes.dart';
import 'package:first_project/screens/home/widgets/cars.dart';
import 'package:first_project/screens/home/widgets/electronics.dart';
import 'package:first_project/screens/home/widgets/fashion.dart';
import 'package:first_project/screens/home/widgets/jobs.dart';
import 'package:first_project/screens/home/widgets/mobiles.dart';
import 'package:first_project/screens/home/widgets/others.dart';
import 'package:first_project/screens/home/widgets/property.dart';

import 'package:first_project/screens/profile/view_profile.dart';
import 'package:first_project/screens/sell/category_selection.dart';
import 'package:first_project/screens/wish_list/wishlist_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../functions/functions.dart';

class HomeScreen extends StatefulWidget {
  UserMOdel? usermodel;
  User? user;
  HomeScreen({super.key, this.usermodel, this.user});

  @override
  State<HomeScreen> createState() =>
      // ignore: no_logic_in_create_state
      _HomeScreenState(usermodel: usermodel, users: user);
}

class _HomeScreenState extends State<HomeScreen> {
  UserMOdel? usermodel;
  User? users;
  _HomeScreenState({this.users, this.usermodel});
  String? profilePhoto;
  User? firebaseUser = FirebaseAuth.instance.currentUser;
  bool _showFirstImage = true;

  @override
  void initState() {
    super.initState();
    userDetails();
    receiveProducts();
    Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        _showFirstImage = !_showFirstImage;
      });
    });
  }

  late dynamic user;

  String photo =
      'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png';
  Future<void> userDetails() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      final data =
          await firestore.collection('user').doc(auth.currentUser!.uid).get();
      profilePhoto = data['photo'];
      setState(() {
        user = data;
      });
    }
  }

  TextEditingController _homeSearchController = TextEditingController();

  int curentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light
          .copyWith(statusBarColor: Theme.of(context).primaryColor),
      child: Scaffold(
        backgroundColor: Colors.blue.shade50,
        body: SafeArea(
          child: ListView(
            children: [
              SizedBox(
                width: double.infinity,
                height: 440,
                // color: Colors.green,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: AnimatedContainer(
                        duration: const Duration(seconds: 4),
                        decoration: BoxDecoration(
                            // color: Colors.amber,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(_showFirstImage
                                    ? 'lib/assets/images/bg1.jpg'
                                    : 'lib/assets/images/bg2.webp'))),
                        height: 300,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(
                            10,
                            140,
                            10,
                            60,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Colors.indigo,
                                image: const DecorationImage(
                                    opacity: 0.7,
                                    fit: BoxFit.cover,
                                    image:
                                        //  NetworkImage(
                                        //     'https://t3.ftcdn.net/jpg/03/15/64/40/360_F_315644043_FwH6bRLTdwdzycDnglSkpI0IhGEs8AUE.jpg')
                                        AssetImage(
                                            'lib/assets/images/homeBarBg.jpg'))),
                            height: 150,
                            width: double.infinity,
                            child: Row(
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: IconButton(
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ChatList(
                                                              user: users,
                                                              usermodel:
                                                                  usermodel,
                                                              data: user,
                                                            )));
                                              },
                                              icon: const Icon(
                                                Icons.mark_as_unread_sharp,
                                                color: Colors.white,
                                                size: 35,
                                              )),
                                        ),
                                        const Text(
                                          'Chat',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 17),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: IconButton(
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .push(MaterialPageRoute(
                                                        builder: ((context) =>
                                                            // WishList()
                                                            const WishList())));
                                              },
                                              icon: const Icon(
                                                Icons.favorite_border,
                                                size: 35,
                                                color: Colors.white,
                                              )),
                                        ),
                                        const Text(
                                          'Wish list',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 17),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 10),
                                            child: IconButton(
                                                onPressed: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: ((context) =>
                                                              CategoriesSelection(
                                                                user: user,
                                                              ))));
                                                },
                                                icon: const Icon(
                                                  Icons
                                                      .add_circle_outline_rounded,
                                                  color: Colors.white,
                                                  size: 35,
                                                )),
                                          ),
                                          const Text(
                                            'Sell',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontSize: 17),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        top: 250,
                        left: 10,
                        right: 10,
                        bottom: 10,
                        child: Container(
                          decoration: BoxDecoration(boxShadow: const [
                            BoxShadow(
                                color: Colors.white, offset: Offset(0.5, 0.5))
                          ], borderRadius: BorderRadius.circular(15)),
                          height: double.infinity,
                          width: double.infinity,
                          child: Column(
                            children: [
                              Flexible(
                                  flex: 1,
                                  child: SizedBox(
                                      height: double.infinity,
                                      width: double.infinity,
                                      child: Row(
                                        children: const [
                                          Flexible(flex: 1, child: Property()),
                                          Flexible(flex: 1, child: MObiles()),
                                          Flexible(flex: 1, child: JObes()),
                                          Flexible(flex: 1, child: Cars()),
                                        ],
                                      ))),
                              Flexible(
                                  flex: 1,
                                  child: SizedBox(
                                      height: double.infinity,
                                      width: double.infinity,
                                      child: Row(
                                        children: const [
                                          Flexible(flex: 1, child: Bikes()),
                                          Flexible(
                                              flex: 1, child: Electronics()),
                                          Flexible(flex: 1, child: Fashion()),
                                          Flexible(flex: 1, child: Others()),
                                        ],
                                      ))),
                            ],
                          ),
                        )),
                    Positioned(
                      top: 85,
                      left: 20,
                      right: 20,
                      child: GestureDetector(
                        onTap: () {
                          showSearch(
                              context: context, delegate: SearchWidget());
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 0),
                          child: Container(
                            height: 35,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              children: [
                                Flexible(flex: 1, child: Container()),
                                Flexible(
                                  flex: 1,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.white,
                                    ),
                                    child: Row(
                                      children: [
                                        Flexible(
                                          flex: 1,
                                          child: SizedBox(
                                            width: double.infinity,
                                            height: double.infinity,
                                            child: Icon(
                                              Icons.search,
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          flex: 2,
                                          child: SizedBox(
                                            width: double.infinity,
                                            height: double.infinity,
                                            child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Search',
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      color: Colors.black
                                                          .withOpacity(0.5),
                                                      fontStyle:
                                                          FontStyle.italic),
                                                )),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Positioned(
                      top: 30,
                      left: 35,
                      child: SizedBox(
                        height: 35,
                        width: 100,
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            )),
                      ),
                    ),
                    Positioned(
                      top: 15,
                      right: 30,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) =>
                                      //  ProfileScreen(
                                      //       user: user,
                                      //     )
                                      ViewProfile(
                                        user: user,
                                        currentUser: firebaseUser!,
                                        //  users!,
                                      ))));
                        },
                        child: CircleAvatar(
                          radius: 29,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 28,
                            backgroundColor: Colors.indigo,
                            // foregroundImage: NetworkImage(user['photo'],),
                            backgroundImage: profilePhoto == null
                                ? const NetworkImage(
                                    'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png')
                                : NetworkImage(profilePhoto.toString()),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ListModel(user: users, usermodel: usermodel),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_project/screens/sell/screen_sell.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../chatModels/user_model.dart';

class CategoriesSelection extends StatelessWidget {
  final dynamic user;
  UserMOdel? usermodel;
  User? users;
  CategoriesSelection({super.key, this.user, this.users, this.usermodel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        centerTitle: true,
      ),
      body: SafeArea(
          child: GridView.count(
        crossAxisCount: 2,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: ((context) => SellScreen(
                        types: 1,
                        user: user,
                        users: users,
                        usermodel: usermodel,
                      ))));
            },
            child: Padding(
              padding: const EdgeInsets.all(3),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                width: double.infinity,
                height: 250,
                child: Card(
                  child: Column(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Icon(
                          Icons.home_work_sharp,
                          size: 70,
                        ),
                      ),
                      Text('Properties')
                    ],
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: ((context) => SellScreen(
                        types: 2,
                        users: users,
                        usermodel: usermodel,
                      ))));
            },
            child: Padding(
              padding: const EdgeInsets.all(3),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                width: double.infinity,
                height: 250,
                child: Card(
                  child: Column(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Icon(
                          Icons.phone_android_rounded,
                          size: 70,
                        ),
                      ),
                      Text('Mobiles')
                    ],
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: ((context) => SellScreen(
                        types: 3,
                        users: users,
                        usermodel: usermodel,
                      ))));
            },
            child: Padding(
              padding: const EdgeInsets.all(3),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                width: double.infinity,
                height: 250,
                child: Card(
                  child: Column(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Icon(
                          Icons.badge,
                          size: 70,
                        ),
                      ),
                      Text('Jobs')
                    ],
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: ((context) => SellScreen(
                        types: 4,
                        users: users,
                        usermodel: usermodel,
                      ))));
            },
            child: Padding(
              padding: const EdgeInsets.all(3),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                width: double.infinity,
                height: 250,
                child: Card(
                  child: Column(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Icon(
                          Icons.drive_eta_rounded,
                          size: 70,
                        ),
                      ),
                      Text('Cars')
                    ],
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: ((context) => SellScreen(
                        types: 5,
                        users: users,
                        usermodel: usermodel,
                      ))));
            },
            child: Padding(
              padding: const EdgeInsets.all(3),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                width: double.infinity,
                height: 250,
                child: Card(
                  child: Column(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Icon(
                          Icons.directions_bike,
                          size: 70,
                        ),
                      ),
                      Text('Bikes')
                    ],
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: ((context) => SellScreen(
                        types: 6,
                        users: users,
                        usermodel: usermodel,
                      ))));
            },
            child: Padding(
              padding: const EdgeInsets.all(3),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                width: double.infinity,
                height: 250,
                child: Card(
                  child: Column(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Icon(
                          Icons.computer_outlined,
                          size: 70,
                        ),
                      ),
                      Text('Electronics')
                    ],
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: ((context) => SellScreen(
                        types: 7,
                        users: users,
                        usermodel: usermodel,
                      ))));
            },
            child: Padding(
              padding: const EdgeInsets.all(3),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                width: double.infinity,
                height: 250,
                child: Card(
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Icon(
                          Icons.shopify_outlined,
                          size: 70,
                        ),
                      ),
                      const Text('Fashion')
                    ],
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: ((context) => SellScreen(
                        types: 8,
                        users: users,
                        usermodel: usermodel,
                      ))));
            },
            child: Padding(
              padding: const EdgeInsets.all(3),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                width: double.infinity,
                height: 250,
                child: Card(
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Icon(
                          Icons.shopping_bag_rounded,
                          size: 70,
                        ),
                      ),
                      const Text('Others')
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}

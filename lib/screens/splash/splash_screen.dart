import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_project/screens/authentication/login_screen.dart';
import 'package:flutter/material.dart';

import '../../chatModels/user_model.dart';

import '../home/home_screen.dart';

// ignore: must_be_immutable
class SplashScreen extends StatelessWidget {
  UserMOdel? usermodel;
  User? user;
  final int chechNumber;
  SplashScreen(
      {super.key, required this.chechNumber, this.user, this.usermodel});

  Future<void> checkNumber(BuildContext context) async {
    if (chechNumber == 1) {
      Timer(const Duration(seconds: 2), () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: ((context) => const LoginScreen())));
      });
    } else {
      Timer(const Duration(seconds: 2), () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: ((context) => HomeScreen(
                      user: user,
                      usermodel: usermodel,
                    ))));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    checkNumber(context);
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              opacity: 0.7,
              fit: BoxFit.cover,
              image:
                  //  NetworkImage(
                  //     'https://i.ytimg.com/vi/QCTFRiEwV1g/maxresdefault.jpg')
                  AssetImage('lib/assets/images/splashBg.jpg')),
        ),
        child: Center(
          child: Container(
            height: 130,
            width: 130,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('lib/assets/images/logo2.png'))),
          ),
        ),
      ),
    );
  }
}

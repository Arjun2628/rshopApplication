import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_project/functions/functions.dart';
import 'package:first_project/functions/hive_function.dart';
import 'package:first_project/models/model_wishlist_card.dart';
import 'package:flutter/material.dart';

import '../chatModels/user_model.dart';

class WishListModel2 extends StatefulWidget {
  UserMOdel? usermodel;
  User? user;
  WishListModel2({super.key, this.user, this.usermodel});

  @override
  State<WishListModel2> createState() => _ListModelState1();
}

class _ListModelState1 extends State<WishListModel2> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: wishItems,
      builder: (context, value, child) {
        return ModelWishCArd(
          value: value,
        );
      },
    );
  }
}

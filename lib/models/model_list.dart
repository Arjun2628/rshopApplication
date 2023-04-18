import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_project/functions/functions.dart';
import 'package:first_project/models/model_card.dart';
import 'package:flutter/material.dart';

import '../chatModels/user_model.dart';

class ListModel extends StatefulWidget {
  UserMOdel? usermodel;
  User? user;
  ListModel({super.key, this.usermodel, this.user});

  @override
  State<ListModel> createState() =>
      _ListModelState(user: user, usermodel: usermodel);
}

class _ListModelState extends State<ListModel> {
  UserMOdel? usermodel;
  User? user;
  _ListModelState({required this.usermodel, required this.user});
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: carditems,
      builder: (context, value, child) {
        return ModelCArd(
          value: value,
        );
        // List<CardModel> items = [];
        // for (var element in value) {
        //   items.add(element);
        // }
        // return ListView.builder(
        //   itemCount: items.length,
        //   itemBuilder: (context, index) {
        //     return Text(items[index].productname);
        //   },
        // );
      },
    );
  }
}

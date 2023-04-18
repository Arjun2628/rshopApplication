import 'package:first_project/functions/hive_function.dart';

import 'package:flutter/material.dart';

import '../../models/model_wishlist_list.dart';

class WishList extends StatefulWidget {
  const WishList({super.key});

  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  @override
  void initState() {
    super.initState();
    HiveDb.getHive();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Wishlist'),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            WishListModel2(),
          ],
        ));
  }
}

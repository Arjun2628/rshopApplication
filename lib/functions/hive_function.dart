import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:first_project/functions/functions.dart';
import 'package:first_project/models/model_wishlist.dart';
import 'package:hive_flutter/adapters.dart';

class HiveDb {
  // final db = Hive.box('wishlist');

  static Future<void> addHive(value) async {
    var hiveDb = Hive.box('wishlist1');

    hiveDb.put(value, value);
  }

  // static Future<void> deleteHIve() async {}

  static Future<void> getHive() async {
    var hiveDb = Hive.box('wishlist1');

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final data = firestore.collection('products');
    wishItems.value.clear();
    for (var element in hiveDb.values) {
      var getmap = await data.doc(element).get();
      Map<String, dynamic> mapvalues = getmap.data() as Map<String, dynamic>;
      // Map<String, dynamic> mapvalues = getmap.data() as Map<String, dynamic>;

      final wishCard = WishlistModel(
          productname: mapvalues['productname'],
          details: mapvalues['details'],
          prize: mapvalues['prize'],
          ph: mapvalues['image'],
          uid: mapvalues['uid'],
          user: mapvalues['user'],
          type: mapvalues['type']);

      wishItems.value.add(wishCard);
    }

    wishItems.notifyListeners();
  }

  static Future<void> deleteItem(String id) async {
    var hiveDb = Hive.box('wishlist1');
    hiveDb.delete(id);
    // await getHive();
    // wishItems.value.clear();
    // wishItems.value.addAll(hiveDb.values.)
  }
}

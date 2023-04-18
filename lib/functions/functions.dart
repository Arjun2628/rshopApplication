import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_project/functions/hive_function.dart';
import 'package:first_project/models/model_wishlist.dart';

import 'package:flutter/cupertino.dart';

import '../models/model_home.dart';

ValueNotifier<List<CardModel>> arry = ValueNotifier([]);

addProduct(CardModel value) {
  arry.value.add(value);
  arry.notifyListeners();
}

// Product fetching

ValueNotifier<List<CardModel>> carditems = ValueNotifier([]);
Future<void> receiveProducts() async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final data = await firestore.collection('products').get();
  carditems.value.clear();
  for (var document in data.docs) {
    var poductData = CardModel.fromMap(document.data());
    final cardmodels = CardModel(
        productname: poductData.productname,
        details: poductData.details,
        prize: poductData.prize,
        ph: poductData.ph,
        type: poductData.type,
        user: poductData.user,
        uid: document.id);
    carditems.value.add(cardmodels);
  }
}

productAdd(CardModel value) {
  carditems.value.add(value);
  carditems.notifyListeners();
}

ValueNotifier<List<WishlistModel>> wishItems = ValueNotifier([]);
// ValueNotifier<bool> like = ValueNotifier(false);

Future<bool> onLikeButtonTapped(
    bool isLiked, dynamic data, int index, String id) async {
  /// send your request here
  // final bool success= await sendRequest();

  /// if failed, you can do nothing
  // return success? !isLiked:isLiked;
  // final carditem = WishlistModel(
  //     details: data.prize,
  //     ph: data.ph,
  //     prize: data.details,
  //     productname: data.productname);
  // wishItems.value.add(carditem);
  if (isLiked) {
    HiveDb.deleteItem(data.uid);
  } else {
    if (id != '0') {
      HiveDb.addHive(id);
    } else {
      HiveDb.addHive(data.uid);
    }
  }
  return !isLiked;
}

Future<bool> onWishListLikeButtonTapped(
  bool isLiked,
  dynamic data,
  int index,
) async {
  if (isLiked) {
    HiveDb.deleteItem(data.uid);
  }

  return !isLiked;
}

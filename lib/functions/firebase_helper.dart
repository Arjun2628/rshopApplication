import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_project/chatModels/user_model.dart';

class FirebaseHelper {
  static Future<UserMOdel?> getUserNameById(String uid) async {
    UserMOdel? userMOdel;

    DocumentSnapshot docs =
        await FirebaseFirestore.instance.collection('user').doc(uid).get();

    if (docs.data() != null) {
      userMOdel = UserMOdel.fromMap(docs.data() as Map<String, dynamic>);
    }

    return userMOdel;
  }
}

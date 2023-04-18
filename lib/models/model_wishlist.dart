class WishlistModel {
  final String productname;
  final String details;
  final String prize;
  final String ph;
  final String uid;
  final String type;
  final String user;
  WishlistModel(
      {required this.productname,
      required this.details,
      required this.prize,
      required this.ph,
      required this.uid,
      required this.type,
      required this.user});

  Map<String, dynamic> toMap() {
    return {
      'productname': productname,
      'prize': prize,
      'details': details,
      'image': ph,
      'type': type,
      'user': user,
      'uid': user,
    };
  }

  factory WishlistModel.fromMap(Map<String, dynamic> map) {
    return WishlistModel(
      productname: map['productname'] ?? '',
      details: map['details'] ?? '',
      prize: map['prize'] ?? '',
      ph: map['image'] ?? '',
      type: map['type'] ?? '',
      user: map['user'],
      uid: map['uid'],
    );
  }
}

class CardModel {
  final String productname;
  final String details;
  final String prize;
  final String ph;
  final String type;
  final String user;
  // final String? address;
  String? uid;

  CardModel(
      {required this.productname,
      required this.details,
      required this.prize,
      required this.ph,
      required this.type,
      required this.user,
      this.uid});

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

  factory CardModel.fromMap(Map<String, dynamic> map) {
    return CardModel(
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

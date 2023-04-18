class UserMOdel {
  String? phone;
  String? name;
  String? age;
  String? photo;
  String? uid;
  String? address;
  double? latitude;
  double? longitude;
  // List<String>? location;

  UserMOdel(
      {this.age,
      this.name,
      this.photo,
      this.phone,
      this.uid,
      this.address,
      this.latitude,
      this.longitude});

  UserMOdel.fromMap(Map<String, dynamic> map) {
    age = map['age'];
    phone = map['phone'];
    name = map['name'];
    photo = map['photo'];
    address = map['address'];
    uid = map['uid'];
    latitude = map['latitude'];
    longitude = map['longitude'];
  }

  Map<String, dynamic> toMap() {
    return {
      'age': age,
      'name': name,
      'phone': phone,
      'photo': photo,
      'uid': uid,
      'latitude': latitude,
      'longitude': longitude,
      'address': address
    };
  }
}

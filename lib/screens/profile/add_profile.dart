import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:first_project/chatModels/user_model.dart';
import 'package:first_project/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_cropper/image_cropper.dart';

import 'package:image_picker/image_picker.dart';

class AddProfile extends StatefulWidget {
  const AddProfile({
    super.key,
  });

  @override
  State<AddProfile> createState() => _AddProfileState();
}

class _AddProfileState extends State<AddProfile> {
  late DatabaseReference dbref;

  String imageUri = '';

  // map
  late GoogleMapController googleMapController;

  double? latitude;
  double? longitude;

  final _formKey = GlobalKey<FormState>();

  LatLng latLngUser = const LatLng(11.4429, 75.6976);

  List<String> location = [];

  static const CameraPosition initialPosition =
      CameraPosition(target: LatLng(11.4429, 75.6976), zoom: 14.0);

  Set<Marker> markers = {};

  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  File? photo;

  Future getImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      final phototemp = File(image.path);
      setState(() {
        photo = phototemp;
      });
    } else {
      return;
    }
  }

  Future addUser(String name, int age, int phone) async {
    await FirebaseFirestore.instance
        .collection('users')
        .add({'name': name, 'age': age, 'phone': phone});
  }

  @override
  void initState() {
    super.initState();
    // dbref = FirebaseDatabase.instance.ref().child('Buy&Sell');
  }

  String? getUserId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Profile'),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Form(
        key: _formKey,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectPhoto();
                  });
                },
                child: photo == null
                    ? CircleAvatar(
                        backgroundColor: Colors.grey.shade300,
                        radius: 60,
                        child: const CircleAvatar(
                            radius: 55,
                            backgroundImage:
                                //  NetworkImage(
                                //     'https://www.pngkit.com/png/detail/126-1262807_instagram-default-profile-picture-png.png'),
                                AssetImage('lib/assets/images/addProfile.png')),
                      )
                    : CircleAvatar(
                        backgroundColor: Colors.grey.shade300,
                        radius: 60,
                        child: CircleAvatar(
                          radius: 55,
                          backgroundImage: FileImage(File(photo!.path)),
                        ),
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  validator: (value) {
                    if (value == '') {
                      return 'Enter name';
                    } else if (value!.length < 2) {
                      return 'minimum 2 characters';
                    } else if (value.length > 10) {
                      return 'maximum 10 characters';
                    }
                    return null;
                  },
                  enableSuggestions: true,
                  controller: _nameController,
                  // decoration: InputDecoration(border: InputBorder.none),
                  decoration: const InputDecoration(
                    label: Text('Name :'),
                    labelStyle: TextStyle(),

                    // prefixText: 'Name : ',
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  validator: (value) {
                    if (value == '') {
                      return 'Enter age';
                    } else if (int.parse(value!) > 110 ||
                        int.parse(value) < 15) {
                      return 'Age between 15-110';
                    } else if (value.length > 10) {
                      return 'maximum 10 characters';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  enableSuggestions: true,
                  controller: _ageController,
                  // decoration: InputDecoration(border: InputBorder.none),
                  decoration: const InputDecoration(
                    label: Text('Age :'),
                    labelStyle: TextStyle(),

                    // prefixText: 'Name : ',
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  validator: (value) {
                    if (value == '') {
                      return 'Enter phone number';
                    } else if (value!.length != 10) {
                      return 'Enter valid phone number';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  enableSuggestions: true,
                  controller: _phoneController,
                  // decoration: InputDecoration(border: InputBorder.none),
                  decoration: const InputDecoration(
                    label: Text('Phone :'),
                    labelStyle: TextStyle(),

                    // prefixText: 'Name : ',
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  validator: (value) {
                    if (value == '') {
                      return 'Enter address';
                    }
                    return null;
                  },
                  maxLines: 6,

                  enableSuggestions: true,
                  controller: _addressController,
                  // decoration: InputDecoration(border: InputBorder.none),
                  decoration: InputDecoration(
                      label: const Text('Address :'),
                      labelStyle: const TextStyle(),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(width: 0.5)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 0.5, color: Colors.grey.shade400))

                      // prefixText: 'Name : ',
                      ),
                ),
              ),
            ),
            Row(
              children: [
                const Flexible(
                  flex: 1,
                  child: SizedBox(
                    height: 55,
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.only(left: 30),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Add Location')),
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: SizedBox(
                    height: 55,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                      child: SizedBox(
                          height: double.infinity,
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () async {
                                Position position = await _determinePosition();
                                googleMapController.animateCamera(
                                    CameraUpdate.newCameraPosition(
                                        CameraPosition(
                                            target: LatLng(position.latitude,
                                                position.longitude),
                                            zoom: 14)));

                                markers.clear();

                                markers.add(Marker(
                                    markerId: const MarkerId('currentPosition'),
                                    position: LatLng(position.latitude,
                                        position.longitude)));

                                setState(() {
                                  latitude = position.latitude;
                                  longitude = position.longitude;
                                });
                              },
                              child: const Text('Add'))),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 20, 30, 10),
              child: Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(width: 0.5, color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(5)),
                child: GoogleMap(
                  initialCameraPosition: initialPosition,
                  markers: markers,
                  zoomControlsEnabled: false,
                  mapType: MapType.normal,
                  onMapCreated: (controller) {
                    googleMapController = controller;
                  },
                ),
              ),
            ),
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: SizedBox(
                    height: 55,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                      child: SizedBox(
                          height: double.infinity,
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  await cloudAdd(photo!);

                                  await getUid();
                                  UserMOdel users = UserMOdel(
                                      age: _ageController.text,
                                      name: _nameController.text,
                                      phone: _phoneController.text,
                                      photo: imageUri,
                                      uid: getUserId,
                                      address: _addressController.text,
                                      latitude: latitude,
                                      longitude: longitude);

                                  userDetailes(users);
                                  userDetail();

                                  // ignore: use_build_context_synchronously
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) => HomeScreen())),
                                      (route) => false);
                                }
                              },
                              child: const Text('Submit'))),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      )),
    );
  }

  Future<void> userDetailes(UserMOdel user) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;

      firestore.collection('user').doc(auth.currentUser!.uid).set(user.toMap());
    }
  }

  Future<void> userDetail() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      final data =
          await firestore.collection('user').doc(auth.currentUser!.uid).get();
      // ignore: unused_local_variable
      String age = data['age'];
      // print(age);
    }
  }

  Future<void> cloudAdd(File file) async {
    final Reference storageref = FirebaseStorage.instance
        .ref()
        .child('images/${DateTime.now().millisecondsSinceEpoch}');

    final UploadTask uploadTask = storageref.putFile(file);
    TaskSnapshot snap = await uploadTask;

    final String downloadUrl = await snap.ref.getDownloadURL();
    imageUri = downloadUrl;
  }

  Future<dynamic> selectPhoto() async {
    await showModalBottomSheet(
        context: context,
        builder: ((context) => BottomSheet(
            onClosing: () {},
            builder: ((context) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: const Icon(Icons.camera),
                    title: const Text('Camara'),
                    onTap: () async {
                      Navigator.of(context).pop();
                      getImage(ImageSource.camera);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.filter),
                    title: const Text('Gallery'),
                    onTap: () async {
                      Navigator.of(context).pop();
                      getImage(ImageSource.gallery);
                    },
                  )
                ],
              );
            }))));
  }

  Future<void> getUid() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    setState(() {
      getUserId = auth.currentUser!.uid;
    });
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location service is disabled');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied) {
      return Future.error('Location permission denied');
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permission is permanantly denied');
    }

    Position position = await Geolocator.getCurrentPosition();

    return position;
  }
}

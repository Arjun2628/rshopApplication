import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:first_project/functions/functions.dart';
import 'package:first_project/main.dart';
import 'package:first_project/models/model_home.dart';
import 'package:first_project/screens/home/home_screen.dart';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import '../../chatModels/user_model.dart';

// ignore: must_be_immutable
class SellScreen extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final types;
  final dynamic user;
  UserMOdel? usermodel;
  User? users;
  SellScreen(
      {super.key, required this.types, this.user, this.users, this.usermodel});

  @override
  // ignore: no_logic_in_create_state
  State<SellScreen> createState() => _SellScreenState(type: types);
}

class _SellScreenState extends State<SellScreen> {
  // ignore: prefer_typing_uninitialized_variables
  final type;
  _SellScreenState({this.type});
  File? _photo;
  String imageUri = '';
  String productType = '';
  bool imageVisivle = false;

  TextEditingController _nameController = TextEditingController();

  TextEditingController _prizeController = TextEditingController();

  TextEditingController _detailsController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      final phototemp = File(image.path);
      setState(() {
        _photo = phototemp;
      });
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add product details'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: ListView(children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 210,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Flexible(
                            flex: 3,
                            child: SizedBox(
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: _photo == null
                                    ? Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(width: 0.5),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        height: double.infinity,
                                        width: double.infinity,
                                        child: const Center(
                                            child: Text('no image')),
                                      )
                                    : Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(width: 0.5),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        height: double.infinity,
                                        width: double.infinity,
                                        child: Image(
                                            fit: BoxFit.cover,
                                            image:
                                                FileImage(File(_photo!.path))),
                                      ),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 2,
                            child: SizedBox(
                              width: double.infinity,
                              child: Center(
                                  child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    getImage();
                                  });
                                },
                                child: const Text(
                                  'Add Photo',
                                  style: TextStyle(fontSize: 20),
                                ),
                              )),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: imageVisivle,
                    child: const Text(
                      'Image is null',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        // Padding(
                        //   padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                        //   child: Align(
                        //       alignment: Alignment.centerLeft,
                        //       child: Text('Product Name :')),
                        // ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                              decoration: BoxDecoration(
                                  // border: Border.all(width: 0.5),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: TextFormField(
                                  maxLines: 1,
                                  validator: (value) {
                                    if (value == '') {
                                      return 'Enter productName';
                                    } else if (value!.length > 10) {
                                      return 'Maximum 10 letters';
                                    } else if (value.length < 2) {
                                      return 'Minimumn 2 letters';
                                    }
                                    return null;
                                  },
                                  controller: _nameController,
                                  decoration: const InputDecoration(
                                      // enabledBorder: OutlineInputBorder(
                                      //     borderSide: BorderSide(
                                      //         width: 0.5,)),
                                      labelText: 'Enter product Name'),
                                ),
                              )),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                              decoration: BoxDecoration(
                                  // border: Border.all(width: 0.5),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == '') {
                                      return 'Enter Prize';
                                    } else if (int.parse(value!) > 100000) {
                                      return 'Maxinum limit is 100000';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.number,
                                  controller: _prizeController,
                                  decoration:
                                      const InputDecoration(labelText: 'Prize'),
                                ),
                              )),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                              height: MediaQuery.of(context).size.height * 0.2,
                              decoration: BoxDecoration(
                                  border: Border.all(width: 0.5),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == '') {
                                      return 'Enter Details';
                                    } else if (value!.length < 5) {
                                      return 'minimum length 5';
                                    }
                                    return null;
                                  },
                                  controller: _detailsController,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      labelText: 'Details'),
                                  maxLines: 7,
                                ),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                  onPressed: () async {
                                    if (_photo != null) {
                                      if (_formKey.currentState!.validate()) {
                                        showDialog(
                                            context: context,
                                            builder: ((context) {
                                              return const Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            }));
                                        await typecheck(type);
                                        await cloudAdd(_photo!);
                                        dynamic idUU = uuid.v1();
                                        FirebaseAuth auth =
                                            FirebaseAuth.instance;
                                        Map<String, dynamic> products = {
                                          'productname': _nameController.text,
                                          'prize': _prizeController.text,
                                          'details': _detailsController.text,
                                          'image': imageUri,
                                          'type': productType,
                                          'user': auth.currentUser!.uid,
                                          // 'address': widget.user.address,
                                          'uid': idUU
                                        };
                                        await userDetailes(products, idUU);

                                        final carddetails = CardModel(
                                            productname: _nameController.text,
                                            prize: _prizeController.text,
                                            details: _detailsController.text,
                                            ph: imageUri,
                                            type: productType,
                                            // address: widget.user.address,
                                            user: auth.currentUser!.uid,
                                            uid: idUU);
                                        setState(() {
                                          productAdd(carddetails);
                                          carditems.value.clear();

                                          receiveProducts();
                                        });

                                        // ignore: use_build_context_synchronously
                                        Navigator.pop(context);
                                        // ignore: use_build_context_synchronously
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: ((context) =>
                                                    HomeScreen(
                                                      user: widget.users,
                                                      usermodel:
                                                          widget.usermodel,
                                                    ))));
                                      }
                                      // setState(() {
                                      //   imageVisivle = false;
                                      // });
                                    } else {
                                      setState(() {
                                        imageVisivle = true;
                                      });
                                    }
                                  },
                                  child: const Text('Add'))),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ]),
        ));
  }

  Future<void> userDetailes(Map<String, dynamic> products, dynamic idUU) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    firestore.collection('products').doc(idUU).set(products);
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

  Future<void> typecheck(int type) async {
    if (type == 1) {
      productType = 'Property';
    } else if (type == 2) {
      productType = 'Mobiles';
    } else if (type == 3) {
      productType = 'Jobes';
    } else if (type == 4) {
      productType = 'Cares';
    } else if (type == 5) {
      productType = 'Bikes';
    } else if (type == 6) {
      productType = 'Electronics';
    } else if (type == 7) {
      productType = 'Fashion';
    } else {
      productType = 'Others';
    }
  }
}

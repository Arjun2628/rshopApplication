import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:first_project/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../functions/functions.dart';

// ignore: must_be_immutable
class UpdateProduct extends StatefulWidget {
  // final types;
  dynamic data;
  UpdateProduct({super.key, this.data});

  @override
  State<UpdateProduct> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateProduct> {
  // final type;

  File? _photo;
  String imageUri = '';
  String productType = '';

  TextEditingController _nameController = TextEditingController();

  TextEditingController _prizeController = TextEditingController();

  TextEditingController _detailsController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool imageChanged = false;

  Future getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      final phototemp = File(image.path);
      setState(() {
        _photo = phototemp;
        imageChanged = true;
      });
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    _nameController.text = widget.data.productname;
    _prizeController.text = widget.data.prize;
    _detailsController.text = widget.data.details;
    imageUri = widget.data.ph;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Edit product details'),
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
                                              BorderRadius.circular(10),
                                        ),
                                        height: double.infinity,
                                        width: double.infinity,
                                        child: Image(
                                            fit: BoxFit.cover,
                                            image:
                                                NetworkImage(widget.data.ph)),
                                      )
                                    : Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(width: 0.5),
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                  'Edit Photo',
                                  style: TextStyle(fontSize: 20),
                                ),
                              )),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
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
                                      return 'productname is empty';
                                    } else if (value!.length > 10) {
                                      return 'Maximum 10 letters';
                                    } else if (value.length < 2) {
                                      return 'Minimumn 2 letters';
                                    }
                                    return null;
                                  },
                                  controller: _nameController,
                                  decoration: const InputDecoration(
                                      labelText: 'Enter productname'),
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
                                  decoration: const InputDecoration(
                                    labelText: 'Enter p  prize',
                                  ),
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
                                      labelText: 'Enter details',
                                      border: InputBorder.none),
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
                                    // await typecheck(widget.data.type);
                                    if (_formKey.currentState!.validate()) {
                                      if (imageChanged == true) {
                                        await cloudAdd(_photo!);
                                      }
                                      FirebaseAuth auth = FirebaseAuth.instance;
                                      Map<String, dynamic> products = {
                                        'productname': _nameController.text,
                                        'prize': _prizeController.text,
                                        'details': _detailsController.text,
                                        'image': imageUri,
                                        'type': widget.data.type,
                                        'user': auth.currentUser!.uid,
                                        'uid': widget.data.uid
                                      };
                                      await userDetailes(products);
                                      carditems.value.clear();
                                      await receiveProducts();

                                      // ignore: use_build_context_synchronously
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: ((context) =>
                                                  HomeScreen())));
                                    }
                                  },
                                  child: const Text('Submit'))),
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

  Future<void> userDetailes(Map<String, dynamic> products) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    firestore.collection('products').doc(widget.data.uid).set(products);
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

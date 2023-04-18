import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_project/models/model_home.dart';
import 'package:first_project/screens/myProducts/edit_product.dart';
import 'package:flutter/material.dart';

class MyProducts extends StatelessWidget {
  final User user;
  // dynamic userDetails;
  MyProducts({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My products'),
        centerTitle: true,
      ),
      body: SafeArea(
          child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('products')
            .where('user', isEqualTo: user.uid)
            .snapshots(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              QuerySnapshot categorrySnapshot = snapshot.data as QuerySnapshot;
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: categorrySnapshot.docs.length,
                itemBuilder: (context, index) {
                  CardModel categoryProducts = CardModel.fromMap(
                      categorrySnapshot.docs[index].data()
                          as Map<String, dynamic>);

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditProduct(
                              data: categoryProducts,
                              user: user,
                            ),
                          ));
                    },
                    child: Card(
                      child: Column(
                        children: [
                          Expanded(
                            // flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image:
                                            NetworkImage(categoryProducts.ph))),
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text('₹${categoryProducts.prize}')),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(15, 0, 0, 5),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        '${categoryProducts.productname}')),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              return const Center(
                child: Text('No products'),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
      )),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_project/models/model_home.dart';
import 'package:flutter/material.dart';

class AllProducts extends StatelessWidget {
  const AllProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('products')
            // .where('type', isEqualTo: type)
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

                  return Card(
                    child: Column(
                      children: [
                        Flexible(
                          flex: 2,
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
                        Flexible(
                            flex: 1,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child:
                                          Text('₹${categoryProducts.prize}')),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                          '₹${categoryProducts.productname}')),
                                ),
                              ],
                            )),
                      ],
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

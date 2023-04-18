import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:first_project/models/model_home.dart';
import 'package:first_project/screens/product/view_product.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

import '../../functions/functions.dart';

class Categories extends StatelessWidget {
  final String type;
  const Categories({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(type),
        centerTitle: true,
      ),
      body: SafeArea(
          child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('products')
            .where('type', isEqualTo: type)
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
                    onTap: (() async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => ViewProduct(
                                    data: categoryProducts,
                                    // user: ,
                                  ))));
                    }),
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
                              Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                              '₹${categoryProducts.prize}')),
                                    ),
                                  ),
                                  LikeButton(
                                    onTap: ((isLiked) {
                                      return onLikeButtonTapped(
                                          isLiked,
                                          snapshot,
                                          index,
                                          categorrySnapshot.docs[index].id);
                                    }),
                                    // onTap: onLikeButtonTapped,
                                    circleColor: const CircleColor(
                                        start: Color(0xff00ddff),
                                        end: Color(0xff0099cc)),
                                    bubblesColor: const BubblesColor(
                                      dotPrimaryColor: Color(0xff33b5e5),
                                      dotSecondaryColor: Color(0xff0099cc),
                                    ),
                                    likeBuilder: (bool isLiked) {
                                      return Icon(
                                        Icons.favorite,
                                        size: 25,
                                        color: isLiked
                                            ? Colors.deepPurpleAccent
                                            : Colors.grey,
                                      );
                                    },
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  )
                                ],
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

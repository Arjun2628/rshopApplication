import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_project/functions/functions.dart';
import 'package:first_project/functions/hive_function.dart';

import 'package:first_project/screens/product/view_product.dart';

import 'package:flutter/material.dart';

import 'package:like_button/like_button.dart';

import '../chatModels/user_model.dart';

class ModelCArd extends StatefulWidget {
  final value;
  UserMOdel? usermodel;
  User? user;
  ModelCArd({super.key, this.usermodel, this.user, this.value});

  @override
  State<ModelCArd> createState() => _ModelCArdState(value: value);
}

class _ModelCArdState extends State<ModelCArd> {
  final value;
  UserMOdel? usermodel;
  User? user;
  _ModelCArdState({
    required this.value,
    this.usermodel,
    this.user,
  });

  HiveDb hivedb = HiveDb();

  String? age;
  @override
  Widget build(BuildContext context) {
    bool fav = true;
    return GridView(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 0,
          mainAxisSpacing: 0,
        ),
        children: List.generate(
          value.length,
          (index) {
            final data = value[index];
            // productDetail();

            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) => ViewProduct(
                          data: data,
                        ))));
              },
              child: Card(
                elevation: 1,
                child: Column(children: [
                  Expanded(
                    // flex: 2,
                    child: SizedBox(
                      // height: 100,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              border: Border.all(
                                  width: 0.5, color: Colors.grey.shade300)),
                          height: double.infinity,
                          width: double.infinity,
                          child: Image(
                              fit: BoxFit.cover,
                              image:
                                  //  FileImage(File(data.ph))
                                  NetworkImage(data.ph)),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: Column(
                      children: [
                        // Padding(
                        //   padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                        //   child: Align(
                        //       alignment: Alignment.centerLeft,
                        //       child: Text(
                        //         '₹${data.productname}',
                        //         style: TextStyle(fontSize: 17),
                        //       )),
                        // ),
                        Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: Container(
                                width: double.infinity,
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        '₹${data.prize}',
                                        style: TextStyle(fontSize: 17),
                                      )),
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: Container(
                                  height: 30,
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 0),
                                    // child:
                                    //  IconButton(
                                    //     onPressed: () {
                                    //       final carditem = WishlistModel(
                                    //           details: data.prize,
                                    //           ph: data.ph,
                                    //           prize: data.details,
                                    //           productname:
                                    //               data.productname);
                                    //       wishItems.value.add(carditem);
                                    //       // like.value = !like.value;

                                    //       // print(like);
                                    //     },
                                    //     icon: Padding(
                                    //       padding: const EdgeInsets.only(
                                    //           right: 0),
                                    //       child: Align(
                                    //         alignment:
                                    //             Alignment.centerRight,
                                    //         // child: ValueListenableBuilder(
                                    //         //   valueListenable: like,
                                    //         //   builder:
                                    //         //       (context, value, child) =>
                                    //         //           Icon(
                                    //         //     Icons.favorite,
                                    //         //     color: value
                                    //         //         ? Colors.amber
                                    //         //         : Colors.blue,
                                    //         //   ),
                                    //         // )

                                    //         //  fav == false
                                    //         //     ? Icon(Icons.favorite_border)
                                    //         //     : Icon(
                                    //         //         Icons.favorite,
                                    //         //         color: Colors.red,
                                    //         //       ),
                                    //       ),
                                    //     )),
                                    child: LikeButton(
                                      onTap: ((isLiked) {
                                        // if(isLiked==true){
                                        //       hivedb.addHive(data.uid);

                                        // }
                                        // if(isLiked==false){

                                        // }

                                        // // print(data.uid);
                                        // return onLikeButtonTapped(
                                        //     isLiked, data,hivedb);
                                        return onLikeButtonTapped(
                                            isLiked, data, index, '0');
                                      }),
                                      // onTap: onLikeButtonTapped,
                                      circleColor: CircleColor(
                                          start: Color(0xff00ddff),
                                          end: Color(0xff0099cc)),
                                      bubblesColor: BubblesColor(
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
                                  )),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(15, 0, 0, 10),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(data.productname)),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            );
          },
        ));
  }
}

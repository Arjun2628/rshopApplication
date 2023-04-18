import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_project/functions/hive_function.dart';
import 'package:first_project/screens/product/view_product.dart';

import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

import '../chatModels/user_model.dart';
import '../functions/functions.dart';

class ModelWishCArd extends StatefulWidget {
  final value;
  const ModelWishCArd({super.key, this.value});

  @override
  State<ModelWishCArd> createState() => _ModelCArdState(value: value);
}

class _ModelCArdState extends State<ModelWishCArd> {
  final value;
  UserMOdel? usermodel;
  User? user;
  _ModelCArdState({this.value, this.user, this.usermodel});
  int count = 1;
  String? age;
  // User? firebaseUser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    bool like = true;
    return GridView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 0,
          mainAxisSpacing: 10,
        ),
        children: List.generate(
          value.length,
          (index) {
            final data = value[index];
            // productDetail();
            count = 1;
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) => ViewProduct(
                          data: data,
                          // user:user,
                        ))));
              },
              child: Card(
                child: Column(children: [
                  Expanded(
                    // flex: 2,
                    child: SizedBox(
                      height: 100,
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
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
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
                              child: SizedBox(
                                  height: 30,
                                  width: double.infinity,
                                  child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          HiveDb.deleteItem(data.uid);
                                        });
                                        print(like);
                                      },
                                      icon: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: count % 2 == 0
                                              ? const Icon(
                                                  Icons.favorite_border)
                                              : const Icon(
                                                  Icons.favorite,
                                                  color: Colors.red,
                                                ),
                                        ),
                                      ))
                                  //     LikeButton(
                                  //   onTap: ((isLiked) {
                                  //     // if(isLiked==true){
                                  //     //       hivedb.addHive(data.uid);

                                  //     // }
                                  //     // if(isLiked==false){

                                  //     // }

                                  //     // // print(data.uid);
                                  //     // return onLikeButtonTapped(
                                  //     //     isLiked, data,hivedb);
                                  //     return onLikeButtonTapped(
                                  //       isLiked,
                                  //       data,
                                  //       index,
                                  //       '0'
                                  //     );
                                  //   }),
                                  //   // onTap: onLikeButtonTapped,
                                  //   circleColor: CircleColor(
                                  //       start: Color(0xff00ddff),
                                  //       end: Color(0xff0099cc)),
                                  //   bubblesColor: BubblesColor(
                                  //     dotPrimaryColor: Color(0xff33b5e5),
                                  //     dotSecondaryColor: Color(0xff0099cc),
                                  //   ),
                                  //   likeBuilder: (bool isLiked) {
                                  //     return Icon(
                                  //       Icons.favorite,
                                  //       size: 25,
                                  //       color: isLiked
                                  //           ? Colors.deepPurpleAccent
                                  //           : Colors.grey,
                                  //     );
                                  //   },
                                  // ),
                                  ),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 10),
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

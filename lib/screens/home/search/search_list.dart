import 'package:first_project/functions/functions.dart';
import 'package:first_project/models/model_home.dart';

import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

import '../../product/view_product.dart';

class SearchWidget extends SearchDelegate {
  @override
  String get searchFieldLabel => "Search products,category";

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: carditems,
      builder:
          ((BuildContext context, List<CardModel> studentList, Widget? child) {
        List<CardModel> searchItems = [];

        for (var element in studentList) {
          if (element.type.toLowerCase().contains(query.toLowerCase().trim()) ||
              element.productname
                  .toLowerCase()
                  .contains(query.toLowerCase().trim())) {
            searchItems.add(element);
          }
        }
        return searchItems.isNotEmpty
            ? GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: ((context, index) {
                  final data = searchItems[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: ((context) => ViewProduct(
                                data: data,
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
                                        width: 0.5,
                                        color: Colors.grey.shade300)),
                                height: double.infinity,
                                width: double.infinity,
                                child: Image(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(data.ph)),
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
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              '₹${data.prize}',
                                              style:
                                                  const TextStyle(fontSize: 17),
                                              maxLines: 1,
                                            )),
                                      ),
                                    ),
                                  ),
                                  const Flexible(
                                    flex: 1,
                                    child: SizedBox(
                                      height: 20,
                                      width: double.infinity,
                                    ),
                                  ),
                                  LikeButton(
                                    onTap: ((isLiked) {
                                      return onLikeButtonTapped(
                                          isLiked, data, index, '0');
                                    }),
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
                                    child: Text(data.productname)),
                              ),
                            ],
                          ),
                        ),
                      ]),
                    ),
                  );
                }),
                itemCount: searchItems.length,
              )
            : const Center(
                child: Text('No data'),
              );
      }),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: carditems,
      builder:
          ((BuildContext context, List<CardModel> studentList, Widget? child) {
        List<CardModel> searchItems = [];

        for (var element in studentList) {
          if (element.type.toLowerCase().contains(query.toLowerCase().trim()) ||
              element.productname
                  .toLowerCase()
                  .contains(query.toLowerCase().trim())) {
            searchItems.add(element);
          }
        }
        return searchItems.isNotEmpty
            ? GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: ((context, index) {
                  final data = searchItems[index];
                  // if (data.type.toLowerCase().contains(query.toLowerCase().trim())) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: ((context) => ViewProduct(
                                data: data,
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
                                        width: 0.5,
                                        color: Colors.grey.shade300)),
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
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              '₹${data.prize}',
                                              style:
                                                  const TextStyle(fontSize: 17),
                                              maxLines: 1,
                                            )),
                                      ),
                                    ),
                                  ),
                                  const Flexible(
                                    flex: 1,
                                    child: SizedBox(
                                      height: 20,
                                      width: double.infinity,
                                    ),
                                  ),
                                  LikeButton(
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
                                    child: Text(data.productname)),
                              ),
                            ],
                          ),
                        ),
                      ]),
                    ),
                  );
                }),
                itemCount: searchItems.length,
              )
            : const Center(
                child: Text('No data'),
              );

        // ListModel();
      }),
    );
  }
}

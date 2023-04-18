import 'package:flutter/material.dart';

import '../../categories/categories.dart';

class Others extends StatelessWidget {
  const Others({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 2),
              child: Text(
                'Others',
                style: TextStyle(fontSize: 10),
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: ((context) {
                  return const Categories(
                    type: 'Others',
                  );
                })));
              },
              child: Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.grey, //New
                            blurRadius: 1.0,
                            offset: Offset(0.5, 0.5))
                      ]),
                  child:
                      //  IconButton(
                      //     onPressed: () {},
                      //     icon: Icon(
                      //       Icons.shopping_bag_rounded,
                      //       color: Colors.white,
                      //     )),
                      const Image(
                          fit: BoxFit.cover,
                          image:
                              //  NetworkImage(
                              //     'http://global.appmifile.com/webfile/globalimg/in/cms/EDC6B3CD-5D62-5298-9828-E1A0127ECAD0.jpg'),
                              AssetImage('lib/assets/images/others.jpg'))),
            ),
          ],
        ),
      ),
    );
  }
}

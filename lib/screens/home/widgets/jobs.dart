import 'package:flutter/material.dart';

import '../../categories/categories.dart';

class JObes extends StatelessWidget {
  const JObes({super.key});

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
                'Jobs',
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
                    type: 'Jobes',
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
                      //       Icons.badge,
                      //       color: Colors.white,
                      //     )),
                      const Image(
                          fit: BoxFit.cover,
                          image:
                              //  NetworkImage(
                              //     'https://3.imimg.com/data3/WW/KY/MY-3839487/office-bag-500x500.jpg'),
                              AssetImage('lib/assets/images/jobs.webp'))),
            ),
          ],
        ),
      ),
    );
  }
}

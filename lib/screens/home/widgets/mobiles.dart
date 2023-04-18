import 'package:flutter/material.dart';

import '../../categories/categories.dart';

class MObiles extends StatelessWidget {
  const MObiles({super.key});

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
                'Mobiles',
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
                    type: 'Mobiles',
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
                      //       Icons.phone_android_rounded,
                      //       color: Colors.white,
                      //     )),
                      const Padding(
                    padding: EdgeInsets.all(3.0),
                    child: Image(
                        fit: BoxFit.cover,
                        image:
                            //  NetworkImage(
                            //     'https://thumbor.forbes.com/thumbor/fit-in/900x510/https://www.forbes.com/uk/advisor/wp-content/uploads/2020/11/phones-switch-apps.jpg'),
                            AssetImage('lib/assets/images/mobiles.jpg')),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

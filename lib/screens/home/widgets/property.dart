import 'package:flutter/material.dart';

import '../../categories/categories.dart';

class Property extends StatelessWidget {
  const Property({super.key});

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
                'Propererties',
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
                    type: 'Property',
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
                      //       Icons.home_work_sharp,
                      //       color: Colors.white,
                      //     )),
                      const Padding(
                    padding: EdgeInsets.all(3.0),
                    child: Image(
                        fit: BoxFit.cover,
                        image:
                            //  NetworkImage(
                            //     'https://images.livemint.com/rf/Image-621x414/LiveMint/Period1/2014/12/16/Photos/house-ktQD--621x414@LiveMint.jpg'),
                            AssetImage('lib/assets/images/property.webp')),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

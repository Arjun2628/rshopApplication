import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_project/google_map/google_maps.dart';
import 'package:first_project/screens/about/about.dart';
import 'package:first_project/screens/myProducts/my_products.dart';
import 'package:first_project/screens/privacy/privacy.dart';
import 'package:first_project/screens/profile/profile_models/profile_list_tile.dart';
import 'package:first_project/screens/profile/profile_screen.dart';
import 'package:first_project/screens/wish_list/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:url_launcher/url_launcher.dart';

import '../authentication/login_screen.dart';

class ViewProfile extends StatelessWidget {
  final dynamic user;
  final User currentUser;
  ViewProfile({super.key, this.user, required this.currentUser});

  final Uri url = Uri.parse('mailto:commonmanaj@gmail.com');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: SafeArea(
          child: ListView(
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('lib/assets/images/viewProfileBg.webp'))),
            height: MediaQuery.of(context).size.height * 0.30,
            width: double.infinity,
            child: Row(
              children: [
                Flexible(
                    flex: 1,
                    child: SizedBox(
                      height: double.infinity,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Expanded(
                            child: Padding(
                          padding: const EdgeInsets.all(30),
                          child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(width: 1, color: Colors.grey),
                                  boxShadow: const [
                                    BoxShadow(
                                        blurRadius: 1,
                                        color: Colors.white,
                                        spreadRadius: 5)
                                  ]),
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(user['photo']),
                              )),
                        )),
                      ),
                    )),
                Flexible(
                    flex: 1,
                    child: SizedBox(
                      height: double.infinity,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(5, 85, 0, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Name :${user['name']}',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 19),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Phone :${user['phone']}',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 19),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ))
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: (() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => GoogleMapScreen(user: user))));
                }),
                child: GoogleMap(
                  onTap: ((argument) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) =>
                                GoogleMapScreen(user: user))));
                  }),
                  initialCameraPosition: CameraPosition(
                      target: LatLng(user['latitude'] ?? 11.4429,
                          user['longitude'] ?? 75.6976),
                      zoom: 14),
                  zoomControlsEnabled: false,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(user: user),
                  ));
            },
            child: const ProfileListTile(
                sections: 'View profile',
                iconSections: Icon(Icons.person_outline)),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyProducts(
                      user: currentUser,
                    ),
                  ));
            },
            child: const ProfileListTile(
                sections: 'My products',
                iconSections: Icon(Icons.production_quantity_limits_rounded)),
          ),
          GestureDetector(
            onTap: (() {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => const WishList())));
            }),
            child: const ProfileListTile(
              sections: 'Wish items',
              iconSections: Icon(Icons.favorite),
            ),
          ),
          GestureDetector(
            onTap: (() {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => const About())));
            }),
            child: const ProfileListTile(
                sections: 'About us', iconSections: Icon(Icons.info_outline)),
          ),
          GestureDetector(
            onTap: (() {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => const PrivacyPolicy())));
            }),
            child: const ProfileListTile(
                sections: 'Privacy policy',
                iconSections: Icon(Icons.privacy_tip_outlined)),
          ),
          GestureDetector(
            child: const ProfileListTile(
                sections: 'Terms&Conditions',
                iconSections: Icon(Icons.contact_support_sharp)),
          ),
          GestureDetector(
            onTap: () async {
              String email = Uri.encodeComponent("commonmanaj@gmail.com");
              String subject = Uri.encodeComponent("Hello Flutter");
              String body = Uri.encodeComponent("Hi! I'm Flutter Developer");
              Uri mail = Uri.parse("mailto:$email?subject=$subject&body=$body");

              await launchUrl(mail);
            },
            child: const ProfileListTile(
                sections: 'Contact',
                iconSections: Icon(Icons.contacts_outlined)),
          ),
          GestureDetector(
            onTap: (() {
              showDialog(
                  context: context,
                  builder: ((context) {
                    return AlertDialog(
                      title: const Text('Alert!'),
                      content: const Text('Do you really want to exit?'),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Back')),
                        TextButton(
                            onPressed: () async {
                              await FirebaseAuth.instance.signOut();
                              // ignore: use_build_context_synchronously
                              Navigator.popUntil(
                                  context, (route) => route.isFirst);
                              // ignore: use_build_context_synchronously
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
                                  ),
                                  (route) => false);
                            },
                            child: const Text('Continue'))
                      ],
                    );
                  }));
            }),
            child: const ProfileListTile(
                sections: 'Logout', iconSections: Icon(Icons.logout_outlined)),
          ),
        ],
      )),
    );
  }
}

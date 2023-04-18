import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: const SafeArea(
          child: Expanded(
              child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
            'R shop is a global online marketplace.\nRshop if founded in 2023 April by Arjun K K.\nR shop allow users to by and sell products in a range between 1000000,\nwe provide a platform for it.The dealings is not with us your dealings is is\n direct.you can chat with other users and by or sell items.'),
      ))),
    );
  }
}

import 'package:flutter/material.dart';

class ProfileListTile extends StatelessWidget {
  final String sections;
  final Widget iconSections;
  const ProfileListTile(
      {super.key, required this.sections, required this.iconSections});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(sections),
          trailing: iconSections,
        ),
        const Divider(
          thickness: 1,
          height: 1,
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';

class SwitchProfileDialog extends StatelessWidget {
  final List<String> profiles = [
    'Profile 1',
    'Profile 2',
    'Profile 3',
    // Add more profiles as needed
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select Profile'),
      content: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        children: List.generate(
          profiles.length,
              (index) {
            return ListTile(
              title: Text(profiles[index]),
              onTap: () {
                // Handle switching profile
                Navigator.pop(context, profiles[index]);
              },
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../utils/palette.dart';

const Color color = Color(0xff001f3f);
Map<int, Color> colors = {
  50: tintColor(color, 0.9),
  100: tintColor(color, 0.8),
  200: tintColor(color, 0.6),
  300: tintColor(color, 0.4),
  400: tintColor(color, 0.2),
  500: color,
  600: shadeColor(color, 0.1),
  700: shadeColor(color, 0.2),
  800: shadeColor(color, 0.3),
  900: shadeColor(color, 0.4),
};
int itemCount = colors.length;

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('My Profile'),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () {
                debugPrint('stats');
              },
              icon: const Icon(Icons.info_outline),
            ),
          ],
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [],
          ),
        ));
  }
}

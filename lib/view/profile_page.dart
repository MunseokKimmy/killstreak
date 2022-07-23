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
    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: (BuildContext context, int index) {
        int key = colors.keys.elementAt(index);
        return Container(
          color: colors[key],
          child: ListTile(
            title: Text('Item $key'),
            leading: const Icon(Icons.person),
            trailing: const Icon(Icons.select_all),
            onTap: () {
              debugPrint('Color ${colors[key]}');
            },
          ),
        );
      },
    );
  }
}

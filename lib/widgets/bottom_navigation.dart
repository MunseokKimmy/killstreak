import 'package:flutter/material.dart';
import 'package:killstreak/view/game_page.dart';
import 'package:killstreak/view/home_page.dart';
import 'package:killstreak/view/profile_page.dart';

class BottomNavigation extends StatefulWidget {
  int currentPage;
  bool shortcut;
  List<Widget> pages = const [
    HomePage(),
    GamePage(),
    ProfilePage(),
  ];
  BottomNavigation(
      {Key? key, required this.currentPage, required this.shortcut})
      : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      unselectedItemColor: Colors.white,
      selectedItemColor: widget.shortcut ? Colors.yellow : Colors.white,
      backgroundColor: const Color(0xff001f3f),
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.sports_volleyball,
            ),
            label: 'Current Game'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
      onTap: (int index) {
        setState(() {
          // currentPage = index;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => widget.pages[index],
            ),
          );
        });
      },
      currentIndex: widget.currentPage,
    );
  }
}

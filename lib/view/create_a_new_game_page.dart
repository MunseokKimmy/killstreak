import 'package:flutter/material.dart';

import '../main.dart';
import '../widgets/bottom_navigation.dart';

class CreateNewGamePage extends StatelessWidget {
  const CreateNewGamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Start a New Game'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {},
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
      body: Container(),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Start a New Game"),
        onPressed: () {},
        backgroundColor: lightColor,
        icon: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigation(
        currentPage: 0,
        shortcut: false,
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:killstreak/model/user_service.dart';
import 'package:killstreak/view/groups_page.dart';
import 'package:killstreak/view/my_stats_page.dart';
import 'package:killstreak/widgets/bottom_navigation.dart';
import 'package:killstreak/widgets/recent_games_carousel.dart';

import '../main.dart';
import 'create_a_new_game_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Killstreak'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(20.0),
              child: Text(
                "Signed in as ${user.email!}",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20),
              ),
            ),
            const RecentGamesCarousel(),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  MyGroupsButton(),
                  MyStatsButton(),
                  LogoutButton(),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Start a New Game"),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const CreateNewGamePage()));
        },
        backgroundColor: lightColor,
        icon: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigation(
        currentPage: 0,
        shortcut: true,
      ),
    );
  }
}

class LogoutButton extends StatelessWidget {
  const LogoutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton.icon(
        icon: const Icon(Icons.arrow_back),
        label: const Text("Sign Out", style: TextStyle(fontSize: 17)),
        style: ElevatedButton.styleFrom(
          primary: lightColor,
          fixedSize: Size(MediaQuery.of(context).size.width * .8, 50),
        ),
        onPressed: () => {
          FirebaseAuth.instance.signOut(),
        },
      ),
    );
  }
}

class MyStatsButton extends StatelessWidget {
  const MyStatsButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: ElevatedButton.icon(
        icon: Icon(Icons.play_arrow_outlined),
        label: const Text(
          "My Games",
          style: TextStyle(fontSize: 17),
        ),
        style: ElevatedButton.styleFrom(
          primary: lightColor,
          fixedSize: Size(MediaQuery.of(context).size.width * .8, 50),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MyStatsPage(),
            ),
          );
        },
      ),
    );
  }
}

class MyGroupsButton extends StatelessWidget {
  const MyGroupsButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton.icon(
        icon: const Icon(
          Icons.groups,
          size: 40,
        ),
        label: const Text(
          "View My Groups",
          style: TextStyle(fontSize: 17),
        ),
        style: ElevatedButton.styleFrom(
          primary: lightColor,
          fixedSize: Size(MediaQuery.of(context).size.width * .8, 50),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const GroupsPage(),
            ),
          );
        },
      ),
    );
  }
}

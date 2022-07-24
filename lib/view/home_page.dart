import 'package:flutter/material.dart';
import 'package:killstreak/model/user_service.dart';
import 'package:killstreak/view/my_stats_page.dart';
import 'package:killstreak/widgets/recent_games_carousel.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserService userService = UserService();
    User testUser = userService.getUser();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('Floating action button');
        },
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(20.0),
              child: Text(
                'Hello ${testUser.username}!',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20),
              ),
            ),
            const RecentGamesCarousel(),
            const MyGroupsButton(),
            const MyStatsButton(),
          ],
        ),
      ),
    );
  }
}

class MyStatsButton extends StatelessWidget {
  const MyStatsButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          children: [
            Image.asset('resources/images/net.png'),
            const Text("My Stats"),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MyStatsPage(),
          ),
        );
      },
    );
  }
}

class MyGroupsButton extends StatelessWidget {
  const MyGroupsButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

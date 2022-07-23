import 'package:flutter/material.dart';
import 'package:killstreak/view/groups_page.dart';
import 'package:killstreak/view/stats_page.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../model/game_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            const RecentGamesCarousel(),
            Container(
              margin: const EdgeInsets.all(20.0),
              child: const Text(
                'Hello ____!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.only(
                    left: 20.0, right: 20.0, bottom: 20.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    side: const BorderSide(color: Colors.white),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const ListTile(
                        leading: Icon(
                          Icons.stacked_bar_chart,
                          color: Colors.white,
                        ),
                        title: Text('Lifetime Totals'),
                        subtitle: Text('Stats'),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          Text('Ace'),
                          Text('Kill'),
                          Text('Assist'),
                          Text('Dig'),
                          Text('Block'),
                        ],
                      ),
                      Center(
                        child: OutlinedButton.icon(
                          icon: const Icon(Icons.web),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return const StatsPage();
                                },
                              ),
                            );
                          },
                          label: const Text("View Your Stats"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Card(
                  shape: const RoundedRectangleBorder(
                    side: BorderSide(color: Colors.white),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Card(
                        shape: const RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: const <Widget>[
                              Text(
                                "Aldair's Volleyball Group",
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                "#6424",
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Center(
                        child: OutlinedButton.icon(
                          icon: const Icon(Icons.group),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return const GroupPage();
                                },
                              ),
                            );
                          },
                          label: const Text("View Your Groups"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RecentGamesCarousel extends StatefulWidget {
  const RecentGamesCarousel({Key? key}) : super(key: key);

  @override
  State<RecentGamesCarousel> createState() => _RecentGamesCarouselState();
}

class _RecentGamesCarouselState extends State<RecentGamesCarousel> {
  int _currentIndex = 0;
  List<GameShort> gameList = [];
  List cardList = [];
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    GameService testService = GameService();
    gameList = testService.getGameShorts();
    cardList = [
      GameCard(game: gameList[0]),
      GameCard(game: gameList[1]),
      GameCard(game: gameList[2]),
      GameCard(game: gameList[3]),
      GameCard(game: gameList[4])
    ];
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 200.0,
            autoPlay: false,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            pauseAutoPlayOnTouch: true,
            aspectRatio: 2.0,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          items: cardList.map((card) {
            return Builder(builder: (BuildContext context) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.30,
                width: MediaQuery.of(context).size.width,
                child: Card(
                  child: card,
                ),
              );
            });
          }).toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: map<Widget>(cardList, (index, url) {
            return Container(
              width: 10.0,
              height: 10.0,
              margin:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentIndex == index ? Colors.blueAccent : Colors.grey,
              ),
            );
          }),
        ),
      ],
    );
  }
}

class GameCard extends StatelessWidget {
  final GameShort game;
  const GameCard({
    Key? key,
    required this.game,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          game.groupName,
                          style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          game.gameCompleted
                              ? game.gameName
                              : "${game.gameName} \n(Ongoing)",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [Text(game.gameDate)],
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: GameCardScores(
              teamOneName: game.teamOneName,
              teamTwoName: game.teamTwoName,
              teamOneScore: game.teamOneScore,
              teamTwoScore: game.teamTwoScore,
              teamOneServing: game.teamOneServing,
            ),
          ),
        ],
      ),
    );
  }
}

class GameCardScores extends StatelessWidget {
  final String teamOneName;
  final String teamTwoName;
  final int teamOneScore;
  final int teamTwoScore;
  final bool teamOneServing;
  const GameCardScores(
      {Key? key,
      required this.teamOneName,
      required this.teamTwoName,
      required this.teamOneScore,
      required this.teamTwoScore,
      required this.teamOneServing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(teamOneName),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Visibility(
                visible: teamOneServing,
                child: const Icon(
                  Icons.sports_volleyball,
                  color: Colors.yellow,
                  size: 18,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(3.0),
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                teamOneScore.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Courier New",
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
        Text(teamTwoName),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Visibility(
                visible: !teamOneServing,
                child: const Icon(
                  Icons.sports_volleyball,
                  color: Colors.yellow,
                  size: 18,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(3.0),
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                teamTwoScore.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Courier New",
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ],
    );
  }
}

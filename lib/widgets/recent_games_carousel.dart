import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../model/game_service.dart';
import '../view/game_page.dart';

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
            viewportFraction: .95,
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
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const GamePage(),
          ),
        );
      },
      child: Container(
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
        Text(
          teamOneName,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 10.0),
          child: Row(
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
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Courier New",
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
        Text(
          teamTwoName,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
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
                  fontSize: 32,
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

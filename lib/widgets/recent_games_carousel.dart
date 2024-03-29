import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:killstreak/main.dart';
import 'package:killstreak/model/dtos/game.dto.dart';
import 'package:killstreak/model/ongoing_game_service.dart';
import 'package:killstreak/view/game/create_a_new_game_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../model/game_service.dart';
import '../view/game/game_page.dart';

class RecentGamesCarousel extends StatefulWidget {
  List<GameCard> gameCards;
  RecentGamesCarousel({Key? key, required this.gameCards}) : super(key: key);

  @override
  State<RecentGamesCarousel> createState() => _RecentGamesCarouselState();
}

class _RecentGamesCarouselState extends State<RecentGamesCarousel> {
  int _currentIndex = 0;
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            viewportFraction: .90,
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
          items: widget.gameCards.map((card) {
            return Builder(builder: (BuildContext context) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.30,
                width: MediaQuery.of(context).size.width * .9,
                child: Card(
                  child: card,
                ),
              );
            });
          }).toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: map<Widget>(widget.gameCards, (index, url) {
            return Container(
              width: 10.0,
              height: 5.0,
              margin:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: _currentIndex == index ? Colors.yellow : Colors.grey,
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
            builder: (context) => GamePage(game: game),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: lightColor,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              blurRadius: 2.0,
              spreadRadius: 0.0,
              offset: Offset(2.0, 2.0), // shadow direction: bottom right
            )
          ],
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 30),
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
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            game.gameCompleted
                                ? game.gameName
                                : "${game.gameName} \n(Ongoing)",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Text(
                            "${game.gameDate} - (${game.location})",
                            style: TextStyle(fontSize: 16),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: GameCardScores(
                teamOneName: game.teamInfo.teamOneName,
                teamTwoName: game.teamInfo.teamTwoName,
                teamOneScore: game.teamInfo.teamOneScore,
                teamTwoScore: game.teamInfo.teamTwoScore,
                teamOneServing: game.teamInfo.teamOneServing,
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

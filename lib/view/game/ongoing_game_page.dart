import 'dart:async';
import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:killstreak/main.dart';
import 'package:killstreak/model/dtos/game.dto.dart';
import 'package:killstreak/model/game_service.dart';
import 'package:killstreak/model/stats_service.dart';
import 'package:killstreak/view/game/game_player_stats_widget.dart';
import 'package:killstreak/view/game/stat_compare_bar_chart.dart';
import 'package:killstreak/view/home_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OngoingGameWidget extends StatefulWidget {
  GameShort game;
  final _controller = PageController();
  OngoingGameWidget({Key? key, required this.game}) : super(key: key);

  @override
  State<OngoingGameWidget> createState() => _OngoingGameWidgetState();
}

class _OngoingGameWidgetState extends State<OngoingGameWidget> {
  final database = FirebaseDatabase.instance.ref();
  List<PlayerGameStats> teamOneStats = [];
  List<PlayerGameStats> teamTwoStats = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: StreamBuilder(
        stream: database
            .child('/players')
            .orderByChild("game_id")
            .equalTo(widget.game.gameId)
            .onValue,
        builder: ((context, snapshot) {
          // final panelList = <GamePlayerStatExpansionPanel>[];
          if (snapshot.hasData) {
            final response = (snapshot.data! as DatabaseEvent).snapshot.value;
            final String parsed = json.encode(response);
            Map<String, dynamic> map = jsonDecode(parsed);
            List<PlayerGameStats> teamOne = [];
            List<PlayerGameStats> teamTwo = [];
            map.forEach((key, value) {
              final PlayerGameStats playerStat =
                  PlayerGameStats.fromRTDB(value);
              if (playerStat.onTeamOne) {
                teamOne.add(playerStat);
              } else {
                teamTwo.add(playerStat);
              }
            });
            teamOneStats = teamOne;
            teamTwoStats = teamTwo;
            return Column(
              children: [
                Expanded(
                  child: PageView(
                    controller: widget._controller,
                    scrollDirection: Axis.horizontal,
                    onPageChanged: ((value) {}),
                    children: [
                      OngoingGamePage1(
                        game: widget.game,
                        teamOneStats: teamOneStats,
                        databaseReference: database,
                      ),
                      OngoingGamePage2(
                        game: widget.game,
                        teamTwoStats: teamTwoStats,
                        databaseReference: database,
                      ),
                      OngoingGamePage3(
                        game: widget.game,
                        databaseReference: database,
                      ),
                    ],
                  ),
                ),
                SmoothPageIndicator(
                  controller: widget._controller,
                  count: 3,
                  effect: const SwapEffect(
                    activeDotColor: Colors.yellow,
                    spacing: 14,
                    dotHeight: 7,
                    dotWidth: 14,
                  ),
                )
              ],
            );
          } else {
            return CircularProgressIndicator();
          }
        }),
      ),
    );
  }
}

class OngoingGamePage1 extends StatefulWidget {
  GameShort game;
  var gameData;
  List<PlayerGameStats> teamOneStats;
  DatabaseReference databaseReference;

  OngoingGamePage1(
      {Key? key,
      required this.game,
      required this.teamOneStats,
      required this.databaseReference})
      : super(key: key);

  @override
  State<OngoingGamePage1> createState() => _OngoingGamePage1State();
}

class _OngoingGamePage1State extends State<OngoingGamePage1> {
  final ScrollController _firstController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GameScoreCard(
          game: widget.game,
          teamOneStats: true,
          teamTwoStats: false,
          databaseReference: widget.databaseReference,
        ),
        Expanded(
          child: Scrollbar(
            controller: _firstController,
            child: ListView.separated(
              controller: _firstController,
              itemCount: widget.teamOneStats.length,
              itemBuilder: (context, index) {
                return GamePlayerStatExpansionPanel(
                  playerGameStats: widget.teamOneStats[index],
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(color: Colors.white);
              },
            ),
          ),
        )
      ],
    );
  }
}

class OngoingGamePage2 extends StatefulWidget {
  GameShort game;
  List<PlayerGameStats> teamTwoStats;
  DatabaseReference databaseReference;
  OngoingGamePage2(
      {Key? key,
      required this.game,
      required this.teamTwoStats,
      required this.databaseReference})
      : super(key: key);

  @override
  State<OngoingGamePage2> createState() => _OngoingGamePage2State();
}

class _OngoingGamePage2State extends State<OngoingGamePage2> {
  final ScrollController _firstController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GameScoreCard(
          game: widget.game,
          teamOneStats: false,
          teamTwoStats: true,
          databaseReference: widget.databaseReference,
        ),
        Expanded(
          child: Scrollbar(
            controller: _firstController,
            child: ListView.separated(
              controller: _firstController,
              itemCount: widget.teamTwoStats.length,
              itemBuilder: (context, index) {
                return GamePlayerStatExpansionPanel(
                  playerGameStats: widget.teamTwoStats[index],
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(color: Colors.white);
              },
            ),
          ),
        ),
      ],
    );
  }
}

class OngoingGamePage3 extends StatefulWidget {
  GameShort game;
  DatabaseReference databaseReference;
  OngoingGamePage3(
      {Key? key, required this.game, required this.databaseReference})
      : super(key: key);

  @override
  State<OngoingGamePage3> createState() => _OngoingGamePage3State();
}

class _OngoingGamePage3State extends State<OngoingGamePage3> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // CheckButton(),
        GameScoreCard(
          game: widget.game,
          teamOneStats: true,
          teamTwoStats: true,
          databaseReference: widget.databaseReference,
        ),
        StatHeadToHeadCompareChart(
          statName: "Service Ace",
          teamOneStatCount: 9,
          teamTwoStatCount: 1,
        ),
        StatHeadToHeadCompareChart(
          statName: "Kills",
          teamOneStatCount: 6,
          teamTwoStatCount: 8,
        ),
        StatHeadToHeadCompareChart(
          statName: "Assists",
          teamOneStatCount: 3,
          teamTwoStatCount: 2,
        ),
        StatHeadToHeadCompareChart(
          statName: "Blocks",
          teamOneStatCount: 1,
          teamTwoStatCount: 1,
        ),
        StatHeadToHeadCompareChart(
          statName: "Digs",
          teamOneStatCount: 6,
          teamTwoStatCount: 4,
        ),
      ],
    );
  }
}

class GameScoreCard extends StatefulWidget {
  GameShort game;
  bool teamOneStats;
  bool teamTwoStats;
  DatabaseReference databaseReference;
  GameScoreCard(
      {Key? key,
      required this.game,
      required this.teamOneStats,
      required this.teamTwoStats,
      required this.databaseReference})
      : super(key: key);

  @override
  State<GameScoreCard> createState() => _GameScoreCardState();
}

class _GameScoreCardState extends State<GameScoreCard> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.databaseReference
          .child('/games/game-${widget.game.gameId}')
          .onValue,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final response = (snapshot.data! as DatabaseEvent).snapshot.value;
          final String parsed = json.encode(response);
          Game gameData = Game.fromRTDB(jsonDecode(parsed));
          return ConstrainedBox(
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * .2),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      gameData.teaminfo.teamOneName,
                      style: TextStyle(
                        color: widget.teamOneStats ? Colors.white : Colors.grey,
                        fontSize: 20,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      margin: const EdgeInsets.only(
                          left: 5, right: 5, top: 10, bottom: 10),
                      decoration: BoxDecoration(
                        color: (widget.teamOneStats && !widget.teamTwoStats)
                            ? lightColor
                            : null,
                        border: Border.all(
                            color: widget.teamOneStats
                                ? Colors.white
                                : Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        gameData.teaminfo.teamOneScore.toString(),
                        style: TextStyle(
                          color: widget.teamOneStats ? lightGrey : Colors.grey,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Courier New",
                        ),
                      ),
                    ),
                    Visibility(
                      visible: gameData.teaminfo.teamOneServing,
                      child: const Icon(
                        Icons.sports_volleyball,
                        color: Colors.yellow,
                        size: 24,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Text(
                      "",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(
                          left: 5, right: 5, top: 10, bottom: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: baseColor),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Text(
                        "-",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Courier New",
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      gameData.teaminfo.teamTwoName,
                      style: TextStyle(
                        color: widget.teamTwoStats ? lightGrey : Colors.grey,
                        fontSize: 20,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(
                          left: 5, right: 5, top: 10, bottom: 10),
                      decoration: BoxDecoration(
                        color: (!widget.teamOneStats && widget.teamTwoStats)
                            ? lightColor
                            : null,
                        border: Border.all(
                            color: widget.teamTwoStats
                                ? Colors.white
                                : Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        gameData.teaminfo.teamTwoScore.toString(),
                        style: TextStyle(
                          color: widget.teamTwoStats ? lightGrey : Colors.grey,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Courier New",
                        ),
                      ),
                    ),
                    Visibility(
                      visible: !gameData.teaminfo.teamOneServing,
                      child: const Icon(
                        Icons.sports_volleyball,
                        color: Colors.yellow,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}

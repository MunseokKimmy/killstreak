import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:killstreak/main.dart';
import 'package:killstreak/model/game_service.dart';
import 'package:killstreak/model/stats_service.dart';
import 'package:killstreak/view/game/game_player_stats_widget.dart';
import 'package:killstreak/view/game/stat_compare_bar_chart.dart';
import 'package:killstreak/view/home_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

DatabaseReference ref = FirebaseDatabase.instance.ref("games/game-1/teams");

class OngoingGameWidget extends StatefulWidget {
  GameShort game;
  var gameData;
  final _controller = PageController();
  OngoingGameWidget({Key? key, required this.game}) : super(key: key);

  @override
  State<OngoingGameWidget> createState() => _OngoingGameWidgetState();
}

class _OngoingGameWidgetState extends State<OngoingGameWidget> {
  @override
  Widget build(BuildContext context) {
    StatsService statsService = StatsService();
    var teamOneStats = statsService.getEmptyTeamOneSingleGameStats();
    var teamTwoStats = statsService.getEmptyTeamTwoSingleGameStats();
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
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
                ),
                OngoingGamePage2(
                  game: widget.game,
                  teamTwoStats: teamTwoStats,
                ),
                OngoingGamePage3(game: widget.game),
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
      ),
    );
  }
}

class OngoingGamePage1 extends StatefulWidget {
  GameShort game;
  var gameData;
  List<PlayerGameStats> teamOneStats;

  OngoingGamePage1({Key? key, required this.game, required this.teamOneStats})
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
  OngoingGamePage2({Key? key, required this.game, required this.teamTwoStats})
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
        )
      ],
    );
  }
}

class OngoingGamePage3 extends StatefulWidget {
  GameShort game;

  OngoingGamePage3({Key? key, required this.game}) : super(key: key);

  @override
  State<OngoingGamePage3> createState() => _OngoingGamePage3State();
}

class _OngoingGamePage3State extends State<OngoingGamePage3> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CheckButton(),
        GameScoreCard(
          game: widget.game,
          teamOneStats: true,
          teamTwoStats: true,
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
  String teamOneName = "";
  var gameData;
  GameScoreCard(
      {Key? key,
      required this.game,
      required this.teamOneStats,
      required this.teamTwoStats})
      : super(key: key);

  @override
  State<GameScoreCard> createState() => _GameScoreCardState();
}

class _GameScoreCardState extends State<GameScoreCard> {
  Future<void> updateCount(data) async {
    widget.gameData = data;
    widget.teamOneName = widget.gameData['team_one_name'];
    print(widget.teamOneName);
  }

  @override
  Widget build(BuildContext context) {
    ref.onValue.listen((event) {
      final data = event.snapshot.value;
      updateCount(data);
    });
    return ConstrainedBox(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height * .2),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                //"",
                widget.teamOneName,
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
                      color: widget.teamOneStats ? Colors.white : Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  widget.game.teamOneScore.toString(),
                  style: TextStyle(
                    color: widget.teamOneStats ? lightGrey : Colors.grey,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Courier New",
                  ),
                ),
              ),
              Visibility(
                visible: widget.game.teamOneServing,
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
                widget.game.teamTwoName,
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
                      color: widget.teamTwoStats ? Colors.white : Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  widget.game.teamTwoScore.toString(),
                  style: TextStyle(
                    color: widget.teamTwoStats ? lightGrey : Colors.grey,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Courier New",
                  ),
                ),
              ),
              Visibility(
                visible: !widget.game.teamOneServing,
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
  }
}

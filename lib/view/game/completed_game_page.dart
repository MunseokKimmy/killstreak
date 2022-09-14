import 'package:flutter/material.dart';
import 'package:killstreak/main.dart';
import 'package:killstreak/model/dtos/game.dto.dart';
import 'package:killstreak/model/ongoing_game_service.dart';
import 'package:killstreak/model/stats_service.dart';
import 'package:killstreak/view/game/completed_game_player_stats_widget.dart';
import 'package:killstreak/view/game/ongoing_game_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CompletedGamePage extends StatefulWidget {
  GameShort game;
  final _controller = PageController();

  CompletedGamePage({Key? key, required this.game}) : super(key: key);

  @override
  State<CompletedGamePage> createState() => _CompletedGamePageState();
}

class _CompletedGamePageState extends State<CompletedGamePage> {
  List<PlayerGameStats> teamOneStats = [];
  List<PlayerGameStats> teamTwoStats = [];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Expanded(
            child: PageView(
              controller: widget._controller,
              scrollDirection: Axis.horizontal,
              children: [
                CompletedGamePage1(
                  game: widget.game,
                  // teamOneStats: teamOneStats,
                ),
                CompletedGamePage2(
                  game: widget.game,
                  // teamTwoStats: teamTwoStats,
                ),
                CompletedGamePage3(
                  game: widget.game,
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
        //   );
        // } else {
        //   return const CircularProgressIndicator();
        // }
        // }
      ),
    );
  }
}

class CompletedGamePage1 extends StatefulWidget {
  GameShort game;

  CompletedGamePage1({Key? key, required this.game}) : super(key: key);

  @override
  State<CompletedGamePage1> createState() => _CompletedGamePage1State();
}

class _CompletedGamePage1State extends State<CompletedGamePage1> {
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
        FutureBuilder(
          future: OngoingGameService()
              .getPlayerListFuture(widget.game.gameId, true),
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              final List<String> playerList = snapshot.data as List<String>;
              return Expanded(
                child: Scrollbar(
                  controller: _firstController,
                  child: ListView.separated(
                    controller: _firstController,
                    itemCount: playerList.length,
                    itemBuilder: (context, index) {
                      return CompletedGamePlayerStats(
                        playerGameStats: playerList[index],
                        game: widget.game,
                        onTeamOne: true,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(color: Colors.white);
                    },
                  ),
                ),
              );
            } else {
              return const Center(
                  child: CircularProgressIndicator(
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(lightColor)));
            }
          }),
        )
      ],
    );
  }
}

class CompletedGamePage2 extends StatefulWidget {
  final ScrollController _firstController = ScrollController();

  GameShort game;

  CompletedGamePage2({Key? key, required this.game}) : super(key: key);

  @override
  State<CompletedGamePage2> createState() => _CompletedGamePage2State();
}

class _CompletedGamePage2State extends State<CompletedGamePage2> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class CompletedGamePage3 extends StatefulWidget {
  GameShort game;

  CompletedGamePage3({Key? key, required this.game}) : super(key: key);

  @override
  State<CompletedGamePage3> createState() => _CompletedGamePage3State();
}

class _CompletedGamePage3State extends State<CompletedGamePage3> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

import 'package:flutter/material.dart';
import 'package:killstreak/main.dart';
import 'package:killstreak/model/dtos/game.dto.dart';
import 'package:killstreak/model/ongoing_game_service.dart';
import 'package:killstreak/model/stats_service.dart';
import 'package:killstreak/view/game/complete_game_modal.dart';
import 'package:killstreak/view/game/game_player_stats_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OngoingGameWidget extends StatefulWidget {
  GameShort game;
  final _controller = PageController();
  OngoingGameWidget({Key? key, required this.game}) : super(key: key);

  @override
  State<OngoingGameWidget> createState() => _OngoingGameWidgetState();
}

class _OngoingGameWidgetState extends State<OngoingGameWidget> {
  List<PlayerGameStats> teamOneStats = [];
  List<PlayerGameStats> teamTwoStats = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Text("${widget.game.gameName} - ${widget.game.location}",
                textAlign: TextAlign.center, style: TextStyle(fontSize: 22)),
          ),
          Expanded(
            child: PageView(
              controller: widget._controller,
              scrollDirection: Axis.horizontal,
              children: [
                OngoingGamePage1(
                  game: widget.game,
                  // teamOneStats: teamOneStats,
                ),
                OngoingGamePage2(
                  game: widget.game,
                  // teamTwoStats: teamTwoStats,
                ),
                // OngoingGamePage3(
                //   game: widget.game,
                // ),
              ],
            ),
          ),
          SmoothPageIndicator(
            controller: widget._controller,
            count: 2,
            effect: const SwapEffect(
              activeDotColor: Colors.yellow,
              spacing: 14,
              dotHeight: 7,
              dotWidth: 14,
            ),
          ),
          FinishGameButton(gameId: widget.game.gameId),
        ],
        //   );
        // } else {
        //   return const CircularProgressIndicator();
        // }
        // }
      ),
    );
    // );
  }
}

class OngoingGamePage1 extends StatefulWidget {
  GameShort game;

  OngoingGamePage1({
    Key? key,
    required this.game,
  }) : super(key: key);

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
        StreamBuilder(
          stream: OngoingGameService()
              .getPlayerListStream(widget.game.gameId, true),
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
                      return GamePlayerStatExpansionPanel(
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

class OngoingGamePage2 extends StatefulWidget {
  GameShort game;
  OngoingGamePage2({Key? key, required this.game}) : super(key: key);

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
        StreamBuilder(
          stream: OngoingGameService()
              .getPlayerListStream(widget.game.gameId, false),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final List<String> playerList = snapshot.data as List<String>;
              return Expanded(
                child: Scrollbar(
                  controller: _firstController,
                  child: ListView.separated(
                    controller: _firstController,
                    itemCount: playerList.length,
                    itemBuilder: (context, index) {
                      return GamePlayerStatExpansionPanel(
                        playerGameStats: playerList[index],
                        game: widget.game,
                        onTeamOne: false,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(color: Colors.white);
                    },
                  ),
                ),
              );
            } else {
              return const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(lightColor));
            }
          },
        ),
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
        GameScoreCard(
          game: widget.game,
          teamOneStats: true,
          teamTwoStats: true,
        ),
        FinishGameButton(gameId: widget.game.gameId),
        // CheckButton(),
        // StatHeadToHeadCompareChart(
        //   statName: "Service Ace",
        //   teamOneStatCount: 9,
        //   teamTwoStatCount: 1,
        // ),
        // StatHeadToHeadCompareChart(
        //   statName: "Kills",
        //   teamOneStatCount: 6,
        //   teamTwoStatCount: 8,
        // ),
        // StatHeadToHeadCompareChart(
        //   statName: "Assists",
        //   teamOneStatCount: 3,
        //   teamTwoStatCount: 2,
        // ),
        // StatHeadToHeadCompareChart(
        //   statName: "Blocks",
        //   teamOneStatCount: 1,
        //   teamTwoStatCount: 1,
        // ),
        // StatHeadToHeadCompareChart(
        //   statName: "Digs",
        //   teamOneStatCount: 6,
        //   teamTwoStatCount: 4,
        // ),
      ],
    );
  }
}

class FinishGameButton extends StatelessWidget {
  int gameId;
  FinishGameButton({Key? key, required this.gameId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8),
        child: ElevatedButton.icon(
          icon: const Icon(
            Icons.done,
            size: 40,
          ),
          label: const Text(
            "Complete Game",
            style: TextStyle(fontSize: 17),
          ),
          style: ElevatedButton.styleFrom(
            primary: lightColor,
            fixedSize: Size(MediaQuery.of(context).size.width * .8, 50),
          ),
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return CompleteGameModal(
                    gameId: gameId,
                  );
                });
          },
        ));
  }
}

class GameScoreCard extends StatefulWidget {
  GameShort game;
  bool teamOneStats;
  bool teamTwoStats;
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
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: OngoingGameService().getGameTeamInfoStream(widget.game.gameId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final TeamInfo gameData = snapshot.data as TeamInfo;
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
                      gameData.teamOneName,
                      style: TextStyle(
                        color: widget.teamOneStats ? Colors.white : Colors.grey,
                        fontSize: 20,
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        OngoingGameService()
                            .updateTeamServing(widget.game.gameId, true);
                      },
                      child: Container(
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
                          gameData.teamOneScore.toString(),
                          style: TextStyle(
                            color:
                                widget.teamOneStats ? lightGrey : Colors.grey,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Courier New",
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: gameData.teamOneServing,
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
                      gameData.teamTwoName,
                      style: TextStyle(
                        color: widget.teamTwoStats ? lightGrey : Colors.grey,
                        fontSize: 20,
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        OngoingGameService()
                            .updateTeamServing(widget.game.gameId, false);
                      },
                      child: Container(
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
                          gameData.teamTwoScore.toString(),
                          style: TextStyle(
                            color:
                                widget.teamTwoStats ? lightGrey : Colors.grey,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Courier New",
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: !gameData.teamOneServing,
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
          return const CircularProgressIndicator(
              valueColor: const AlwaysStoppedAnimation<Color>(lightColor));
        }
      },
    );
  }
}

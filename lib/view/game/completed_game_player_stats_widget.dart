import 'package:flutter/material.dart';
import 'package:killstreak/main.dart';
import 'package:killstreak/model/dtos/game.dto.dart';
import 'package:killstreak/model/ongoing_game_service.dart';
import 'package:killstreak/model/stats_service.dart';

class CompletedGamePlayerStats extends StatefulWidget {
  String playerGameStats;
  GameShort game;
  bool onTeamOne;
  CompletedGamePlayerStats(
      {Key? key,
      required this.playerGameStats,
      required this.game,
      required this.onTeamOne})
      : super(key: key);

  @override
  State<CompletedGamePlayerStats> createState() =>
      _CompletedGamePlayerStatsState();
}

class _CompletedGamePlayerStatsState extends State<CompletedGamePlayerStats> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: FutureBuilder(
              future: OngoingGameService().getSingleStatFutureString(
                  widget.playerGameStats, widget.game.gameId, 'player_name'),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final PlayerGameStats stats =
                      snapshot.data as PlayerGameStats;
                  return ExpansionPanelList(
                    animationDuration: const Duration(milliseconds: 500),
                    children: [
                      ExpansionPanel(
                          hasIcon: false,
                          isExpanded: _expanded,
                          canTapOnHeader: true,
                          headerBuilder: (context, isExpanded) {
                            return PlayerStatsHeader(
                              playerGameStats: stats,
                              playerFirstName: stats.playerName,
                              game: widget.game,
                              onTeamOne: widget.onTeamOne,
                            );
                          },
                          body: PlayerStatsFooter(
                            playerGameStats: stats,
                            playerFirstName: stats.playerName,
                            game: widget.game,
                            onTeamOne: widget.onTeamOne,
                          ))
                    ],
                    expansionCallback: ((panelIndex, isExpanded) {
                      setState(() {
                        _expanded = !_expanded;
                      });
                    }),
                  );
                } else {
                  return const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(lightColor));
                }
              }),
        )
      ],
    );
  }
}

class PlayerStatsHeader extends StatefulWidget {
  PlayerGameStats playerGameStats;
  String playerFirstName;
  GameShort game;
  bool onTeamOne;
  PlayerStatsHeader(
      {Key? key,
      required this.playerGameStats,
      required this.playerFirstName,
      required this.game,
      required this.onTeamOne})
      : super(key: key);

  @override
  State<PlayerStatsHeader> createState() => _PlayerStatsHeaderState();
}

class _PlayerStatsHeaderState extends State<PlayerStatsHeader> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.playerFirstName,
              style: const TextStyle(
                fontSize: 22,
                color: lightGrey,
              ),
            ),
          ),
        ),
        Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: const [
                      Expanded(
                        child: Text(
                          "A",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: "Courier New",
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "|",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Courier New",
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "K",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: "Courier New",
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "|",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Courier New",
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "As",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: "Courier New",
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "|",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Courier New",
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "B",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: "Courier New",
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "|",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Courier New",
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "D",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: "Courier New",
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${widget.playerGameStats.aces}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontFamily: "Courier New",
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Expanded(
                        child: Text(
                          "|",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Courier New",
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "${widget.playerGameStats.kills}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontFamily: "Courier New",
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Expanded(
                        child: Text(
                          "|",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Courier New",
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "${widget.playerGameStats.assists}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontFamily: "Courier New",
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Expanded(
                        child: Text(
                          "|",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Courier New",
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "${widget.playerGameStats.blocks} ",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontFamily: "Courier New",
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Expanded(
                        child: Text(
                          "|",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Courier New",
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "${widget.playerGameStats.digs} ",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontFamily: "Courier New",
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )),
      ],
    );
  }
}

class PlayerStatsFooter extends StatefulWidget {
  PlayerGameStats playerGameStats;
  String playerFirstName;
  GameShort game;
  bool onTeamOne;
  PlayerStatsFooter(
      {Key? key,
      required this.playerGameStats,
      required this.playerFirstName,
      required this.game,
      required this.onTeamOne})
      : super(key: key);

  @override
  State<PlayerStatsFooter> createState() => _PlayerStatsFooterState();
}

class _PlayerStatsFooterState extends State<PlayerStatsFooter> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Expanded(
          flex: 2,
          child: Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              "Errors",
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey,
              ),
            ),
          ),
        ),
        Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: const [
                      Expanded(
                        child: Text(
                          "Sv",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.grey,
                              fontFamily: "Courier New",
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "|",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey,
                            fontFamily: "Courier New",
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "At",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.grey,
                              fontFamily: "Courier New",
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "|",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey,
                            fontFamily: "Courier New",
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "BH",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.grey,
                              fontFamily: "Courier New",
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "|",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey,
                            fontFamily: "Courier New",
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "Bl",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.grey,
                              fontFamily: "Courier New",
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "|",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey,
                            fontFamily: "Courier New",
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "Rc",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.grey,
                              fontFamily: "Courier New",
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${widget.playerGameStats.aces}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.grey,
                              fontFamily: "Courier New",
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Expanded(
                        child: Text(
                          "|",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey,
                            fontFamily: "Courier New",
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "${widget.playerGameStats.kills}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.grey,
                              fontFamily: "Courier New",
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Expanded(
                        child: Text(
                          "|",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey,
                            fontFamily: "Courier New",
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "${widget.playerGameStats.assists}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.grey,
                              fontFamily: "Courier New",
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Expanded(
                        child: Text(
                          "|",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey,
                            fontFamily: "Courier New",
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "${widget.playerGameStats.blocks} ",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.grey,
                              fontFamily: "Courier New",
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Expanded(
                        child: Text(
                          "|",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey,
                            fontFamily: "Courier New",
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "${widget.playerGameStats.digs} ",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.grey,
                              fontFamily: "Courier New",
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )),
      ],
    );
  }
}

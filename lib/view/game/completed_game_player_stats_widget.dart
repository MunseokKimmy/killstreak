import 'package:flutter/material.dart';
import 'package:killstreak/main.dart';
import 'package:killstreak/model/dtos/game.dto.dart';
import 'package:killstreak/model/ongoing_game_service.dart';

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
                  final String playerName = snapshot.data as String;

                  return ExpansionPanelList(
                    animationDuration: const Duration(milliseconds: 500),
                    children: [
                      ExpansionPanel(
                          hasIcon: false,
                          isExpanded: _expanded,
                          canTapOnHeader: true,
                          headerBuilder: (context, isExpanded) {
                            return PlayerStatsHeader(
                              playerGameStats: widget.playerGameStats,
                              playerFirstName: playerName,
                              game: widget.game,
                              onTeamOne: widget.onTeamOne,
                            );
                          },
                          body: PlayerStatsFooter(
                            playerGameStats: widget.playerGameStats,
                            playerFirstName: playerName,
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
  String playerGameStats;
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
    return Container();
  }
}

class PlayerStatsFooter extends StatefulWidget {
  String playerGameStats;
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
    return Container();
  }
}

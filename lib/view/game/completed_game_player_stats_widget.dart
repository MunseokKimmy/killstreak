import 'package:flutter/material.dart';
import 'package:killstreak/model/dtos/game.dto.dart';

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
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

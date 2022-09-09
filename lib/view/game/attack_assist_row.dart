import 'package:flutter/material.dart';
import 'package:killstreak/main.dart';
import 'package:killstreak/model/ongoing_game_service.dart';
import 'package:killstreak/view/game/edit_stat_bottom_modal.dart';

class AtkAstRow extends StatefulWidget {
  String playerGameStats;
  String playerFirstName;
  int gameId;
  bool onTeamOne;
  AtkAstRow(
      {Key? key,
      required this.playerGameStats,
      required this.playerFirstName,
      required this.gameId,
      required this.onTeamOne})
      : super(key: key);

  @override
  State<AtkAstRow> createState() => _AtkAstRowState();
}

class _AtkAstRowState extends State<AtkAstRow> {
  final String killsDataString = "kills";
  final String attackErrorDataString = "attack_errors";
  final String assistsDataString = "assists";
  final String bheDataString = "ball_handling_errors";
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 3.0, right: 3.0),
          child: StreamBuilder(
            stream: OngoingGameService().getSingleStatStreamInt(
                widget.playerGameStats, killsDataString),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final int playerKills = snapshot.data as int;
                return GestureDetector(
                  onLongPress: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return EditStatBottomModal(
                            initialStat: playerKills,
                            playerName: widget.playerFirstName,
                            playerStatId: widget.playerGameStats,
                            statName: 'Kills',
                            statDataName: killsDataString,
                            gameId: widget.gameId,
                            onTeamOne: widget.onTeamOne,
                          );
                        });
                  },
                  child: ActionChip(
                    elevation: 8.0,
                    padding: const EdgeInsets.all(2.0),
                    avatar: CircleAvatar(
                      backgroundColor: Colors.lightBlueAccent,
                      child: Text(playerKills.toString(),
                          style: const TextStyle(
                              color: Color.fromARGB(255, 56, 56, 56),
                              fontWeight: FontWeight.w600,
                              fontSize: 18)),
                    ),
                    label: const Text('Kill'),
                    onPressed: () {
                      OngoingGameService().updateSingleStatInt(
                          widget.playerGameStats,
                          killsDataString,
                          playerKills + 1);
                      OngoingGameService()
                          .updateTeamScore(widget.gameId, widget.onTeamOne, 1);
                    },
                    backgroundColor: Colors.grey[200],
                    shape: const StadiumBorder(
                        side: BorderSide(
                      width: 1,
                      color: Colors.lightBlueAccent,
                    )),
                  ),
                );
              } else {
                return const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(lightColor));
              }
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 3.0, right: 3.0),
          child: StreamBuilder(
            stream: OngoingGameService().getSingleStatStreamInt(
                widget.playerGameStats, attackErrorDataString),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final int playerAttackErrors = snapshot.data as int;
                return GestureDetector(
                  onLongPress: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return EditStatBottomModal(
                            initialStat: playerAttackErrors,
                            playerName: widget.playerFirstName,
                            playerStatId: widget.playerGameStats,
                            statName: 'Attack Errors',
                            statDataName: attackErrorDataString,
                            gameId: widget.gameId,
                            onTeamOne: widget.onTeamOne,
                          );
                        });
                  },
                  child: ActionChip(
                    elevation: 8.0,
                    padding: const EdgeInsets.all(2.0),
                    avatar: CircleAvatar(
                      backgroundColor: Colors.lightBlueAccent,
                      child: Text(playerAttackErrors.toString(),
                          style: const TextStyle(
                              color: Color.fromARGB(255, 56, 56, 56),
                              fontWeight: FontWeight.w600,
                              fontSize: 18)),
                    ),
                    label: const Text('Atk Err'),
                    onPressed: () {
                      OngoingGameService().updateSingleStatInt(
                          widget.playerGameStats,
                          attackErrorDataString,
                          playerAttackErrors + 1);
                      OngoingGameService()
                          .updateTeamScore(widget.gameId, !widget.onTeamOne, 1);
                    },
                    backgroundColor: Colors.grey[200],
                    shape: const StadiumBorder(
                        side: BorderSide(
                      width: 1,
                      color: Colors.lightBlueAccent,
                    )),
                  ),
                );
              } else {
                return const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(lightColor));
              }
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 3.0, right: 3.0),
          child: StreamBuilder(
            stream: OngoingGameService().getSingleStatStreamInt(
                widget.playerGameStats, assistsDataString),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final int playerAssists = snapshot.data as int;
                return GestureDetector(
                  onLongPress: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return EditStatBottomModal(
                            initialStat: playerAssists,
                            playerName: widget.playerFirstName,
                            playerStatId: widget.playerGameStats,
                            statName: 'Assists',
                            statDataName: assistsDataString,
                            gameId: widget.gameId,
                            onTeamOne: widget.onTeamOne,
                          );
                        });
                  },
                  child: ActionChip(
                    elevation: 8.0,
                    padding: const EdgeInsets.all(2.0),
                    avatar: CircleAvatar(
                      backgroundColor: Colors.pinkAccent,
                      child: Text(playerAssists.toString(),
                          style: const TextStyle(
                              color: Color.fromARGB(255, 56, 56, 56),
                              fontWeight: FontWeight.w600,
                              fontSize: 18)),
                    ),
                    label: const Text('Ast'),
                    onPressed: () {
                      OngoingGameService().updateSingleStatInt(
                          widget.playerGameStats,
                          assistsDataString,
                          playerAssists + 1);
                    },
                    backgroundColor: Colors.grey[200],
                    shape: const StadiumBorder(
                        side: BorderSide(
                      width: 1,
                      color: Colors.pinkAccent,
                    )),
                  ),
                );
              } else {
                return const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(lightColor));
              }
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 3.0, right: 3.0),
          child: StreamBuilder(
            stream: OngoingGameService()
                .getSingleStatStreamInt(widget.playerGameStats, bheDataString),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final int playerBHE = snapshot.data as int;
                return GestureDetector(
                  onLongPress: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return EditStatBottomModal(
                            initialStat: playerBHE,
                            playerName: widget.playerFirstName,
                            playerStatId: widget.playerGameStats,
                            statName: 'Ball Handling Errors',
                            statDataName: bheDataString,
                            gameId: widget.gameId,
                            onTeamOne: widget.onTeamOne,
                          );
                        });
                  },
                  child: ActionChip(
                    elevation: 8.0,
                    padding: const EdgeInsets.all(2.0),
                    avatar: CircleAvatar(
                      backgroundColor: Colors.pinkAccent,
                      child: Text(playerBHE.toString(),
                          style: const TextStyle(
                              color: Color.fromARGB(255, 56, 56, 56),
                              fontWeight: FontWeight.w600,
                              fontSize: 18)),
                    ),
                    label: const Text('BH Err'),
                    onPressed: () {
                      OngoingGameService().updateSingleStatInt(
                          widget.playerGameStats, bheDataString, playerBHE + 1);
                      OngoingGameService()
                          .updateTeamScore(widget.gameId, !widget.onTeamOne, 1);
                    },
                    backgroundColor: Colors.grey[200],
                    shape: const StadiumBorder(
                        side: BorderSide(
                      width: 1,
                      color: Colors.pinkAccent,
                    )),
                  ),
                );
              } else {
                return const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(lightColor));
              }
            },
          ),
        ),
      ],
    );
  }
}

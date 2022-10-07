import 'package:flutter/material.dart';
import 'package:killstreak/main.dart';
import 'package:killstreak/model/ongoing_game_service.dart';
import 'package:killstreak/view/game/edit_stat_bottom_modal.dart';

class MiscRow extends StatefulWidget {
  String playerGameStats;
  String playerFirstName;
  int gameId;
  bool onTeamOne;
  MiscRow(
      {Key? key,
      required this.playerGameStats,
      required this.playerFirstName,
      required this.gameId,
      required this.onTeamOne})
      : super(key: key);

  @override
  State<MiscRow> createState() => _MiscRowState();
}

class _MiscRowState extends State<MiscRow> {
  final String bheDataString = "ball_handling_errors";
  final String recDataString = "reception_errors";
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 3.0, right: 3.0),
          child: StreamBuilder(
            stream: OngoingGameService().getSingleStatStreamInt(
                widget.gameId, widget.playerGameStats, bheDataString),
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
                          widget.playerGameStats,
                          bheDataString,
                          playerBHE + 1,
                          widget.gameId);
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
        Padding(
          padding: const EdgeInsets.only(left: 3.0, right: 3.0),
          child: StreamBuilder(
            stream: OngoingGameService().getSingleStatStreamInt(
                widget.gameId, widget.playerGameStats, 'reception_errors'),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final int playerReceptionErrors = snapshot.data as int;
                return GestureDetector(
                  onLongPress: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return EditStatBottomModal(
                            initialStat: playerReceptionErrors,
                            playerName: widget.playerFirstName,
                            playerStatId: widget.playerGameStats,
                            statName: 'Reception Errors',
                            statDataName: 'reception_errors',
                            gameId: widget.gameId,
                            onTeamOne: widget.onTeamOne,
                          );
                        });
                  },
                  child: ActionChip(
                    elevation: 8.0,
                    padding: const EdgeInsets.all(2.0),
                    avatar: CircleAvatar(
                      backgroundColor: Colors.purpleAccent,
                      child: Text(playerReceptionErrors.toString(),
                          style: const TextStyle(
                              color: Color.fromARGB(255, 56, 56, 56),
                              fontWeight: FontWeight.w600,
                              fontSize: 18)),
                    ),
                    label: const Text('Rec Err'),
                    onPressed: () {
                      OngoingGameService().updateSingleStatInt(
                          widget.playerGameStats,
                          'reception_errors',
                          playerReceptionErrors + 1,
                          widget.gameId);
                    },
                    backgroundColor: Colors.grey[200],
                    shape: const StadiumBorder(
                        side: BorderSide(
                      width: 1,
                      color: Colors.purpleAccent,
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

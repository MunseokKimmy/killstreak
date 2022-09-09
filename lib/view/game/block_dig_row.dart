import 'package:flutter/material.dart';
import 'package:killstreak/main.dart';
import 'package:killstreak/model/ongoing_game_service.dart';
import 'package:killstreak/view/game/edit_stat_bottom_modal.dart';

class BlkDigRow extends StatefulWidget {
  String playerGameStats;
  String playerFirstName;

  BlkDigRow(
      {Key? key, required this.playerGameStats, required this.playerFirstName})
      : super(key: key);

  @override
  State<BlkDigRow> createState() => _BlkDigRowState();
}

class _BlkDigRowState extends State<BlkDigRow> {
  final String blockDataString = "blocks";
  final String blockErrorDataString = "block_errors";
  final String digDataString = "digs";
  final String recDataString = "reception_errors";
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 3.0, right: 3.0),
          child: StreamBuilder(
            stream: OngoingGameService()
                .getSingleStatStreamInt(widget.playerGameStats, 'digs'),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final int playerDigs = snapshot.data as int;
                return GestureDetector(
                  onLongPress: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return EditStatBottomModal(
                            initialStat: playerDigs,
                            playerName: widget.playerFirstName,
                            playerStatId: widget.playerGameStats,
                            statName: 'Digs',
                            statDataName: 'digs',
                          );
                        });
                  },
                  child: ActionChip(
                    elevation: 8.0,
                    padding: const EdgeInsets.all(2.0),
                    avatar: CircleAvatar(
                      backgroundColor: Colors.purpleAccent,
                      child: Text(playerDigs.toString(),
                          style: const TextStyle(
                              color: Color.fromARGB(255, 56, 56, 56),
                              fontWeight: FontWeight.w600,
                              fontSize: 18)),
                    ),
                    label: const Text('Dig'),
                    onPressed: () {
                      OngoingGameService().updateSingleStatInt(
                          widget.playerGameStats, 'digs', playerDigs + 1);
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
        Padding(
          padding: const EdgeInsets.only(left: 3.0, right: 3.0),
          child: StreamBuilder(
            stream: OngoingGameService().getSingleStatStreamInt(
                widget.playerGameStats, 'reception_errors'),
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
                          playerReceptionErrors + 1);
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
        Padding(
          padding: const EdgeInsets.only(left: 3.0, right: 3.0),
          child: StreamBuilder(
            stream: OngoingGameService()
                .getSingleStatStreamInt(widget.playerGameStats, 'blocks'),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final int playerBlocks = snapshot.data as int;
                return GestureDetector(
                  onLongPress: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return EditStatBottomModal(
                            initialStat: playerBlocks,
                            playerName: widget.playerFirstName,
                            playerStatId: widget.playerGameStats,
                            statName: 'Blocks',
                            statDataName: 'blocks',
                          );
                        });
                  },
                  child: ActionChip(
                    elevation: 8.0,
                    padding: const EdgeInsets.all(2.0),
                    avatar: CircleAvatar(
                      backgroundColor: Colors.greenAccent,
                      child: Text(playerBlocks.toString(),
                          style: const TextStyle(
                              color: Color.fromARGB(255, 56, 56, 56),
                              fontWeight: FontWeight.w600,
                              fontSize: 18)),
                    ),
                    label: const Text('Blk'),
                    onPressed: () {
                      OngoingGameService().updateSingleStatInt(
                          widget.playerGameStats, 'blocks', playerBlocks + 1);
                    },
                    backgroundColor: Colors.grey[200],
                    shape: const StadiumBorder(
                        side: BorderSide(
                      width: 1,
                      color: Colors.greenAccent,
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
                .getSingleStatStreamInt(widget.playerGameStats, 'block_errors'),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final int playerBlockErrors = snapshot.data as int;
                return GestureDetector(
                  onLongPress: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return EditStatBottomModal(
                            initialStat: playerBlockErrors,
                            playerName: widget.playerFirstName,
                            playerStatId: widget.playerGameStats,
                            statName: 'Block Errors',
                            statDataName: 'block_errors',
                          );
                        });
                  },
                  child: ActionChip(
                    elevation: 8.0,
                    padding: const EdgeInsets.all(2.0),
                    avatar: CircleAvatar(
                      backgroundColor: Colors.greenAccent,
                      child: Text(playerBlockErrors.toString(),
                          style: const TextStyle(
                              color: const Color.fromARGB(255, 56, 56, 56),
                              fontWeight: FontWeight.w600,
                              fontSize: 18)),
                    ),
                    label: const Text('Blk Err'),
                    onPressed: () {
                      OngoingGameService().updateSingleStatInt(
                          widget.playerGameStats,
                          'block_errors',
                          playerBlockErrors + 1);
                    },
                    backgroundColor: Colors.grey[200],
                    shape: const StadiumBorder(
                        side: BorderSide(
                      width: 1,
                      color: Colors.greenAccent,
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

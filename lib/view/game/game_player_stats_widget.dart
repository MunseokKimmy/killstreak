import 'package:flutter/material.dart';
import 'package:killstreak/main.dart';
import 'package:killstreak/model/ongoing_game_service.dart';
import 'package:killstreak/view/game/attack_assist_row.dart';
import 'package:killstreak/view/game/block_dig_row.dart';
import 'package:killstreak/view/game/edit_stat_bottom_modal.dart';

class GamePlayerStatExpansionPanel extends StatefulWidget {
  String playerGameStats;
  GamePlayerStatExpansionPanel({Key? key, required this.playerGameStats})
      : super(key: key);

  @override
  State<GamePlayerStatExpansionPanel> createState() =>
      _GamePlayerStatExpansionPanelState();
}

class _GamePlayerStatExpansionPanelState
    extends State<GamePlayerStatExpansionPanel> {
  bool _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: StreamBuilder(
              stream: OngoingGameService().getSingleStatStreamString(
                  widget.playerGameStats, 'player_name'),
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
                            return GamePlayerStatTileHeader(
                              playerGameStats: widget.playerGameStats,
                              playerFirstName: playerName,
                            );
                          },
                          body: GamePlayerStatTileFooter(
                            playerGameStats: widget.playerGameStats,
                            playerFirstName: playerName,
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

class GamePlayerStatTileHeader extends StatefulWidget {
  String playerGameStats;
  String playerFirstName;
  GamePlayerStatTileHeader(
      {Key? key, required this.playerGameStats, required this.playerFirstName})
      : super(key: key);

  @override
  State<GamePlayerStatTileHeader> createState() =>
      _GamePlayerStatTileHeaderState();
}

class _GamePlayerStatTileHeaderState extends State<GamePlayerStatTileHeader> {
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
            )),
        Expanded(
          flex: 3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 3.0, right: 8.0),
                child: StreamBuilder(
                  stream: OngoingGameService()
                      .getSingleStatStreamInt(widget.playerGameStats, 'ace'),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final int playerAces = snapshot.data as int;
                      return GestureDetector(
                        onLongPress: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return EditStatBottomModal(
                                  initialStat: playerAces,
                                  playerName: widget.playerFirstName,
                                  playerStatId: widget.playerGameStats,
                                  statName: 'Aces',
                                  statDataName: 'ace',
                                );
                              });
                        },
                        child: ActionChip(
                          elevation: 8.0,
                          padding: const EdgeInsets.all(2.0),
                          avatar: CircleAvatar(
                            backgroundColor: baseColor,
                            child: Text(playerAces.toString(),
                                style: const TextStyle(
                                    color: lightGrey,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18)),
                          ),
                          label: const Text('Ace',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15)),
                          onPressed: () async {
                            OngoingGameService().updateSingleStatInt(
                                widget.playerGameStats, 'ace', playerAces + 1);
                          },
                          backgroundColor: Colors.grey[200],
                          shape: const StadiumBorder(
                              side: BorderSide(
                            width: 1,
                            color: baseColor,
                          )),
                        ),
                      );
                    } else {
                      return const CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(lightColor));
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 0, right: 3.0),
                child: StreamBuilder(
                  stream: OngoingGameService().getSingleStatStreamInt(
                      widget.playerGameStats, 'service_errors'),
                  builder: ((context, snapshot) {
                    if (snapshot.hasData) {
                      final int playerServiceErrors = snapshot.data as int;
                      return GestureDetector(
                        onLongPress: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return EditStatBottomModal(
                                  initialStat: playerServiceErrors,
                                  playerName: widget.playerFirstName,
                                  playerStatId: widget.playerGameStats,
                                  statName: 'Service Errors',
                                  statDataName: 'service_errors',
                                );
                              });
                        },
                        child: ActionChip(
                          elevation: 8.0,
                          padding: const EdgeInsets.all(2.0),
                          avatar: CircleAvatar(
                            backgroundColor: baseColor,
                            child: Text(playerServiceErrors.toString(),
                                style: TextStyle(
                                    color: Colors.grey[200],
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18)),
                          ),
                          label: const Text('Service Err',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15)),
                          onPressed: () {
                            OngoingGameService().updateSingleStatInt(
                                widget.playerGameStats,
                                'service_errors',
                                playerServiceErrors + 1);
                          },
                          backgroundColor: Colors.grey[200],
                          shape: const StadiumBorder(
                              side: BorderSide(
                            width: 1,
                            color: baseColor,
                          )),
                        ),
                      );
                    } else {
                      return const CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(lightColor));
                    }
                  }),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class GamePlayerStatTileFooter extends StatefulWidget {
  String playerGameStats;
  String playerFirstName;

  GamePlayerStatTileFooter(
      {Key? key, required this.playerGameStats, required this.playerFirstName})
      : super(key: key);

  @override
  State<GamePlayerStatTileFooter> createState() =>
      _GamePlayerStatTileFooterState();
}

class _GamePlayerStatTileFooterState extends State<GamePlayerStatTileFooter> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          Theme(
            data: ThemeData(
                textTheme: const TextTheme(
              bodyText1: TextStyle(fontSize: 16),
            )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AtkAstRow(
                  playerGameStats: widget.playerGameStats,
                  playerFirstName: widget.playerFirstName,
                ),
                BlkDigRow(
                  playerGameStats: widget.playerGameStats,
                  playerFirstName: widget.playerFirstName,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

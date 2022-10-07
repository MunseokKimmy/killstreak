import 'package:flutter/material.dart';
import 'package:killstreak/custom/custom_expansion_panel.dart';
import 'package:killstreak/main.dart';
import 'package:killstreak/model/dtos/game.dto.dart';
import 'package:killstreak/model/ongoing_game_service.dart';
import 'package:killstreak/view/game/attack_assist_row.dart';
import 'package:killstreak/view/game/block_dig_row.dart';
import 'package:killstreak/view/game/edit_stat_bottom_modal.dart';
import 'package:killstreak/view/game/misc_row.dart';

class GamePlayerStatExpansionPanel extends StatefulWidget {
  String playerGameStats;
  GameShort game;
  bool onTeamOne;
  GamePlayerStatExpansionPanel(
      {Key? key,
      required this.playerGameStats,
      required this.game,
      required this.onTeamOne})
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
                  widget.playerGameStats, widget.game.gameId, 'player_name'),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final String playerName = snapshot.data as String;

                  return CustomExpansionTileList(
                    animationDuration: const Duration(milliseconds: 500),
                    children: [
                      CustomExpansionTile(
                          hasIcon: false,
                          isExpanded: _expanded,
                          canTapOnHeader: true,
                          headerBuilder: (context, isExpanded) {
                            return GamePlayerStatTileHeader(
                              playerGameStats: widget.playerGameStats,
                              playerFirstName: playerName,
                              game: widget.game,
                              onTeamOne: widget.onTeamOne,
                            );
                          },
                          body: GamePlayerStatTileFooter(
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

class GamePlayerStatTileHeader extends StatefulWidget {
  String playerGameStats;
  String playerFirstName;
  GameShort game;
  bool onTeamOne;
  GamePlayerStatTileHeader(
      {Key? key,
      required this.playerGameStats,
      required this.playerFirstName,
      required this.game,
      required this.onTeamOne})
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
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.playerFirstName,
              style: const TextStyle(
                fontSize: 20,
                color: lightGrey,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 3.0, right: 8.0),
                child: StreamBuilder(
                  stream: OngoingGameService().getSingleStatStreamInt(
                      widget.game.gameId, widget.playerGameStats, 'ace'),
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
                                  gameId: widget.game.gameId,
                                  onTeamOne: widget.onTeamOne,
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
                                widget.playerGameStats,
                                'ace',
                                playerAces + 1,
                                widget.game.gameId);
                            OngoingGameService().updateTeamScore(
                                widget.game.gameId, widget.onTeamOne, 1);
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
                padding: const EdgeInsets.only(left: 0, right: 12.0),
                child: StreamBuilder(
                  stream: OngoingGameService().getSingleStatStreamInt(
                      widget.game.gameId,
                      widget.playerGameStats,
                      'service_errors'),
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
                                  gameId: widget.game.gameId,
                                  onTeamOne: widget.onTeamOne,
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
                          label: const Text('Srv Err',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15)),
                          onPressed: () {
                            OngoingGameService().updateSingleStatInt(
                                widget.playerGameStats,
                                'service_errors',
                                playerServiceErrors + 1,
                                widget.game.gameId);
                            OngoingGameService().updateTeamScore(
                                widget.game.gameId, !widget.onTeamOne, 1);
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
  GameShort game;
  bool onTeamOne;

  GamePlayerStatTileFooter(
      {Key? key,
      required this.playerGameStats,
      required this.playerFirstName,
      required this.game,
      required this.onTeamOne})
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
      child: Theme(
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
              onTeamOne: widget.onTeamOne,
              gameId: widget.game.gameId,
            ),
            BlkDigRow(
              playerGameStats: widget.playerGameStats,
              playerFirstName: widget.playerFirstName,
              onTeamOne: widget.onTeamOne,
              gameId: widget.game.gameId,
            ),
            // MiscRow(
            //   playerGameStats: widget.playerGameStats,
            //   playerFirstName: widget.playerFirstName,
            //   onTeamOne: widget.onTeamOne,
            //   gameId: widget.game.gameId,
            // )
          ],
        ),
      ),
    );
  }
}

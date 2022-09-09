import 'package:flutter/material.dart';
import 'package:killstreak/main.dart';
import 'package:killstreak/model/ongoing_game_service.dart';
import 'package:killstreak/model/stats_service.dart';
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
          child: ExpansionPanelList(
            animationDuration: const Duration(milliseconds: 500),
            children: [
              ExpansionPanel(
                  hasIcon: false,
                  isExpanded: _expanded,
                  canTapOnHeader: true,
                  headerBuilder: (context, isExpanded) {
                    return GamePlayerStatTileHeader(
                      playerGameStats: widget.playerGameStats,
                    );
                  },
                  body: GamePlayerStatTileFooter(
                    playerGameStats: widget.playerGameStats,
                  ))
            ],
            expansionCallback: ((panelIndex, isExpanded) {
              setState(() {
                _expanded = !_expanded;
              });
            }),
          ),
        )
      ],
    );
  }
}

class GamePlayerStatTileHeader extends StatefulWidget {
  String playerGameStats;
  late String playerFirstName;
  GamePlayerStatTileHeader({Key? key, required this.playerGameStats})
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
              child: StreamBuilder(
                stream: OngoingGameService().getSingleStatStreamString(
                    widget.playerGameStats, 'player_name'),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final String playerName = snapshot.data as String;
                    widget.playerFirstName = playerName;
                    return Text(
                      playerName,
                      style: const TextStyle(
                        fontSize: 22,
                        color: lightGrey,
                      ),
                    );
                  } else {
                    return const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(lightColor));
                  }
                },
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
                      return ActionChip(
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

  GamePlayerStatTileFooter({Key? key, required this.playerGameStats})
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
                AtkAstRow(playerGameStats: widget.playerGameStats),
                BlkDigRow(playerGameStats: widget.playerGameStats)
              ],
            ),
          )
        ],
      ),
    );
  }
}

class AtkAstRow extends StatefulWidget {
  String playerGameStats;
  AtkAstRow({Key? key, required this.playerGameStats}) : super(key: key);

  @override
  State<AtkAstRow> createState() => _AtkAstRowState();
}

class _AtkAstRowState extends State<AtkAstRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 3.0, right: 3.0),
          child: StreamBuilder(
            stream: OngoingGameService()
                .getSingleStatStreamInt(widget.playerGameStats, 'kills'),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final int playerKills = snapshot.data as int;
                return ActionChip(
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
                        widget.playerGameStats, 'kills', playerKills + 1);
                  },
                  backgroundColor: Colors.grey[200],
                  shape: const StadiumBorder(
                      side: BorderSide(
                    width: 1,
                    color: Colors.lightBlueAccent,
                  )),
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
                widget.playerGameStats, 'attack_errors'),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final int playerAttackErrors = snapshot.data as int;
                return ActionChip(
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
                        'attack_errors',
                        playerAttackErrors + 1);
                  },
                  backgroundColor: Colors.grey[200],
                  shape: const StadiumBorder(
                      side: BorderSide(
                    width: 1,
                    color: Colors.lightBlueAccent,
                  )),
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
                .getSingleStatStreamInt(widget.playerGameStats, 'assists'),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final int playerAssists = snapshot.data as int;
                return ActionChip(
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
                        widget.playerGameStats, 'assists', playerAssists + 1);
                  },
                  backgroundColor: Colors.grey[200],
                  shape: const StadiumBorder(
                      side: BorderSide(
                    width: 1,
                    color: Colors.pinkAccent,
                  )),
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
                widget.playerGameStats, 'ball_handling_errors'),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final int playerBHE = snapshot.data as int;
                return ActionChip(
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
                        'ball_handling_errors',
                        playerBHE + 1);
                  },
                  backgroundColor: Colors.grey[200],
                  shape: const StadiumBorder(
                      side: BorderSide(
                    width: 1,
                    color: Colors.pinkAccent,
                  )),
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

class BlkDigRow extends StatefulWidget {
  String playerGameStats;
  BlkDigRow({Key? key, required this.playerGameStats}) : super(key: key);

  @override
  State<BlkDigRow> createState() => _BlkDigRowState();
}

class _BlkDigRowState extends State<BlkDigRow> {
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
                return ActionChip(
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
                return ActionChip(
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
                return ActionChip(
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
                return ActionChip(
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

class StatQuickViewHeader extends StatefulWidget {
  PlayerGameStats playerGameStats;
  StatQuickViewHeader({Key? key, required this.playerGameStats})
      : super(key: key);

  @override
  State<StatQuickViewHeader> createState() => _StatQuickViewHeaderState();
}

class _StatQuickViewHeaderState extends State<StatQuickViewHeader> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  const Text(
                    "A",
                    style: TextStyle(
                        fontFamily: "Courier New",
                        color: lightGrey,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(widget.playerGameStats.aces.toString(),
                      style: const TextStyle(
                          fontFamily: "Courier New",
                          color: lightGrey,
                          fontSize: 20,
                          fontWeight: FontWeight.w500)),
                ],
              ),
              const VerticalDivider(
                color: lightGrey,
                width: 2,
                thickness: 1,
              ),
              Column(
                children: [
                  const Text("K",
                      style: TextStyle(
                          fontFamily: "Courier New",
                          color: lightGrey,
                          fontSize: 20,
                          fontWeight: FontWeight.w500)),
                  Text(widget.playerGameStats.kills.toString(),
                      style: const TextStyle(
                          color: lightGrey,
                          fontFamily: "Courier New",
                          fontSize: 20,
                          fontWeight: FontWeight.w500)),
                ],
              ),
              const VerticalDivider(
                color: lightGrey,
                width: 2,
                thickness: 1,
              ),
              Column(
                children: [
                  const Text("As",
                      style: TextStyle(
                          fontFamily: "Courier New",
                          fontSize: 20,
                          color: lightGrey,
                          fontWeight: FontWeight.w500)),
                  Text(widget.playerGameStats.assists.toString(),
                      style: const TextStyle(
                          fontFamily: "Courier New",
                          fontSize: 20,
                          color: lightGrey,
                          fontWeight: FontWeight.w500)),
                ],
              ),
              const VerticalDivider(
                color: lightGrey,
                width: 2,
                thickness: 1,
              ),
              Column(
                children: [
                  const Text("B",
                      style: TextStyle(
                          fontFamily: "Courier New",
                          fontSize: 20,
                          color: lightGrey,
                          fontWeight: FontWeight.w500)),
                  Text(widget.playerGameStats.blocks.toString(),
                      style: const TextStyle(
                          fontFamily: "Courier New",
                          fontSize: 20,
                          color: lightGrey,
                          fontWeight: FontWeight.w500)),
                ],
              ),
              const VerticalDivider(
                color: lightGrey,
                width: 2,
                thickness: 1,
              ),
              Column(
                children: [
                  const Text("D",
                      style: TextStyle(
                          fontFamily: "Courier New",
                          fontSize: 20,
                          color: lightGrey,
                          fontWeight: FontWeight.w500)),
                  Text(widget.playerGameStats.digs.toString(),
                      style: const TextStyle(
                          fontFamily: "Courier New",
                          fontSize: 20,
                          color: lightGrey,
                          fontWeight: FontWeight.w500)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

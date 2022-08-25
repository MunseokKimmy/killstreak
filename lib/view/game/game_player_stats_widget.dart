import 'package:flutter/material.dart';
import 'package:killstreak/main.dart';
import 'package:killstreak/model/stats_service.dart';

class GamePlayerStatExpansionPanel extends StatefulWidget {
  PlayerGameStats playerGameStats;
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
  PlayerGameStats playerGameStats;
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
              child: Text(
                widget.playerGameStats.playerName,
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
                child: ActionChip(
                  elevation: 8.0,
                  padding: const EdgeInsets.all(2.0),
                  avatar: CircleAvatar(
                    backgroundColor: baseColor,
                    child: Text(widget.playerGameStats.aces.toString(),
                        style: const TextStyle(
                            color: lightGrey,
                            fontWeight: FontWeight.w600,
                            fontSize: 18)),
                    // Icon(
                    //   Icons.mode_comment,
                    //   color: Colors.white,
                    //   size: 20,
                    // ),
                  ),
                  label: const Text('Ace'),
                  onPressed: () {},
                  backgroundColor: Colors.grey[200],
                  shape: const StadiumBorder(
                      side: BorderSide(
                    width: 1,
                    color: baseColor,
                  )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 3.0, right: 3.0),
                child: ActionChip(
                  elevation: 8.0,
                  padding: const EdgeInsets.all(2.0),
                  avatar: CircleAvatar(
                    backgroundColor: baseColor,
                    child: Text(widget.playerGameStats.serviceErrors.toString(),
                        style: TextStyle(
                            color: Colors.grey[200],
                            fontWeight: FontWeight.w600,
                            fontSize: 18)),
                  ),
                  label: const Text('Service Err'),
                  onPressed: () {},
                  backgroundColor: Colors.grey[200],
                  shape: const StadiumBorder(
                      side: BorderSide(
                    width: 1,
                    color: baseColor,
                  )),
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
  PlayerGameStats playerGameStats;

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
  PlayerGameStats playerGameStats;
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
          child: ActionChip(
            elevation: 8.0,
            padding: const EdgeInsets.all(2.0),
            avatar: CircleAvatar(
              backgroundColor: Colors.blueAccent,
              child: Text(widget.playerGameStats.kills.toString(),
                  style: const TextStyle(
                      color: Color.fromARGB(255, 56, 56, 56),
                      fontWeight: FontWeight.w600,
                      fontSize: 18)),
            ),
            label: const Text('Kill'),
            onPressed: () {},
            backgroundColor: Colors.grey[200],
            shape: const StadiumBorder(
                side: BorderSide(
              width: 1,
              color: Colors.blueAccent,
            )),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 3.0, right: 3.0),
          child: ActionChip(
            elevation: 8.0,
            padding: const EdgeInsets.all(2.0),
            avatar: CircleAvatar(
              backgroundColor: Colors.blueAccent,
              child: Text(widget.playerGameStats.atkErrors.toString(),
                  style: const TextStyle(
                      color: Color.fromARGB(255, 56, 56, 56),
                      fontWeight: FontWeight.w600,
                      fontSize: 18)),
            ),
            label: const Text('Atk Err'),
            onPressed: () {},
            backgroundColor: Colors.grey[200],
            shape: const StadiumBorder(
                side: BorderSide(
              width: 1,
              color: Colors.blueAccent,
            )),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 3.0, right: 3.0),
          child: ActionChip(
            elevation: 8.0,
            padding: const EdgeInsets.all(2.0),
            avatar: CircleAvatar(
              backgroundColor: Colors.pinkAccent,
              child: Text(widget.playerGameStats.assists.toString(),
                  style: const TextStyle(
                      color: Color.fromARGB(255, 56, 56, 56),
                      fontWeight: FontWeight.w600,
                      fontSize: 18)),
            ),
            label: const Text('Ast'),
            onPressed: () {},
            backgroundColor: Colors.grey[200],
            shape: const StadiumBorder(
                side: BorderSide(
              width: 1,
              color: Colors.pinkAccent,
            )),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 3.0, right: 3.0),
          child: ActionChip(
            elevation: 8.0,
            padding: const EdgeInsets.all(2.0),
            avatar: CircleAvatar(
              backgroundColor: Colors.pinkAccent,
              child: Text(widget.playerGameStats.ballHandlingErrors.toString(),
                  style: const TextStyle(
                      color: Color.fromARGB(255, 56, 56, 56),
                      fontWeight: FontWeight.w600,
                      fontSize: 18)),
            ),
            label: const Text('BH Err'),
            onPressed: () {},
            backgroundColor: Colors.grey[200],
            shape: const StadiumBorder(
                side: BorderSide(
              width: 1,
              color: Colors.pinkAccent,
            )),
          ),
        ),
      ],
    );
  }
}

class BlkDigRow extends StatefulWidget {
  PlayerGameStats playerGameStats;
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
          child: ActionChip(
            elevation: 8.0,
            padding: const EdgeInsets.all(2.0),
            avatar: CircleAvatar(
              backgroundColor: Colors.purpleAccent,
              child: Text(widget.playerGameStats.digs.toString(),
                  style: const TextStyle(
                      color: Color.fromARGB(255, 56, 56, 56),
                      fontWeight: FontWeight.w600,
                      fontSize: 18)),
            ),
            label: const Text('Dig'),
            onPressed: () {},
            backgroundColor: Colors.grey[200],
            shape: const StadiumBorder(
                side: BorderSide(
              width: 1,
              color: Colors.purpleAccent,
            )),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 3.0, right: 3.0),
          child: ActionChip(
            elevation: 8.0,
            padding: const EdgeInsets.all(2.0),
            avatar: CircleAvatar(
              backgroundColor: Colors.purpleAccent,
              child: Text(widget.playerGameStats.receptionErrors.toString(),
                  style: const TextStyle(
                      color: Color.fromARGB(255, 56, 56, 56),
                      fontWeight: FontWeight.w600,
                      fontSize: 18)),
            ),
            label: const Text('Rec Err'),
            onPressed: () {},
            backgroundColor: Colors.grey[200],
            shape: const StadiumBorder(
                side: BorderSide(
              width: 1,
              color: Colors.purpleAccent,
            )),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 3.0, right: 3.0),
          child: ActionChip(
            elevation: 8.0,
            padding: const EdgeInsets.all(2.0),
            avatar: CircleAvatar(
              backgroundColor: Colors.greenAccent,
              child: Text(widget.playerGameStats.blocks.toString(),
                  style: const TextStyle(
                      color: Color.fromARGB(255, 56, 56, 56),
                      fontWeight: FontWeight.w600,
                      fontSize: 18)),
            ),
            label: const Text('Blk'),
            onPressed: () {},
            backgroundColor: Colors.grey[200],
            shape: const StadiumBorder(
                side: BorderSide(
              width: 1,
              color: Colors.greenAccent,
            )),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 3.0, right: 3.0),
          child: ActionChip(
            elevation: 8.0,
            padding: const EdgeInsets.all(2.0),
            avatar: CircleAvatar(
              backgroundColor: Colors.greenAccent,
              child: Text(widget.playerGameStats.blockErrors.toString(),
                  style: TextStyle(
                      color: Color.fromARGB(255, 56, 56, 56),
                      fontWeight: FontWeight.w600,
                      fontSize: 18)),
            ),
            label: const Text('Blk Err'),
            onPressed: () {},
            backgroundColor: Colors.grey[200],
            shape: const StadiumBorder(
                side: BorderSide(
              width: 1,
              color: Colors.greenAccent,
            )),
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

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
                  body: GamePlayerStatTileFooter())
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
          child: Column(
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
          ),
        ),
      ],
    );
  }
}

class GamePlayerStatTileFooter extends StatefulWidget {
  GamePlayerStatTileFooter({Key? key}) : super(key: key);

  @override
  State<GamePlayerStatTileFooter> createState() =>
      _GamePlayerStatTileFooterState();
}

class _GamePlayerStatTileFooterState extends State<GamePlayerStatTileFooter> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ActionChip(
                      elevation: 8.0,
                      padding: EdgeInsets.all(2.0),
                      avatar: CircleAvatar(
                        backgroundColor: Colors.redAccent,
                        child: Icon(
                          Icons.mode_comment,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      label: Text('Ace'),
                      onPressed: () {},
                      backgroundColor: Colors.grey[200],
                      shape: StadiumBorder(
                          side: BorderSide(
                        width: 1,
                        color: Colors.redAccent,
                      )),
                    ),
                    ActionChip(
                      elevation: 8.0,
                      padding: EdgeInsets.all(2.0),
                      avatar: CircleAvatar(
                        backgroundColor: Colors.redAccent,
                        child: Icon(
                          Icons.mode_comment,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      label: Text('Srv Err'),
                      onPressed: () {},
                      backgroundColor: Colors.grey[200],
                      shape: StadiumBorder(
                          side: BorderSide(
                        width: 1,
                        color: Colors.redAccent,
                      )),
                    ),
                  ],
                ),
                Row(
                  children: [
                    ActionChip(
                      elevation: 8.0,
                      padding: EdgeInsets.all(2.0),
                      avatar: CircleAvatar(
                        backgroundColor: Colors.blueAccent,
                        child: Icon(
                          Icons.mode_comment,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      label: Text('Kill'),
                      onPressed: () {},
                      backgroundColor: Colors.grey[200],
                      shape: StadiumBorder(
                          side: BorderSide(
                        width: 1,
                        color: Colors.blueAccent,
                      )),
                    ),
                    ActionChip(
                      elevation: 8.0,
                      padding: EdgeInsets.all(2.0),
                      avatar: CircleAvatar(
                        backgroundColor: Colors.blueAccent,
                        child: Icon(
                          Icons.mode_comment,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      label: Text('Atk Err'),
                      onPressed: () {},
                      backgroundColor: Colors.grey[200],
                      shape: StadiumBorder(
                          side: BorderSide(
                        width: 1,
                        color: Colors.blueAccent,
                      )),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ActionChip(
                      elevation: 8.0,
                      padding: EdgeInsets.all(2.0),
                      avatar: CircleAvatar(
                        backgroundColor: Colors.yellowAccent,
                        child: Icon(
                          Icons.mode_comment,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      label: Text('Ast'),
                      onPressed: () {},
                      backgroundColor: Colors.grey[200],
                      shape: StadiumBorder(
                          side: BorderSide(
                        width: 1,
                        color: Colors.yellowAccent,
                      )),
                    ),
                    ActionChip(
                      elevation: 8.0,
                      padding: EdgeInsets.all(2.0),
                      avatar: CircleAvatar(
                        backgroundColor: Colors.yellowAccent,
                        child: Icon(
                          Icons.mode_comment,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      label: Text('BH Error'),
                      onPressed: () {},
                      backgroundColor: Colors.grey[200],
                      shape: StadiumBorder(
                          side: BorderSide(
                        width: 1,
                        color: Colors.yellowAccent,
                      )),
                    ),
                  ],
                ),
                Row(
                  children: [
                    ActionChip(
                      elevation: 8.0,
                      padding: EdgeInsets.all(2.0),
                      avatar: CircleAvatar(
                        backgroundColor: Colors.purpleAccent,
                        child: Icon(
                          Icons.mode_comment,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      label: Text('Dig'),
                      onPressed: () {},
                      backgroundColor: Colors.grey[200],
                      shape: StadiumBorder(
                          side: BorderSide(
                        width: 1,
                        color: Colors.purpleAccent,
                      )),
                    ),
                    ActionChip(
                      elevation: 8.0,
                      padding: EdgeInsets.all(2.0),
                      avatar: CircleAvatar(
                        backgroundColor: Colors.purpleAccent,
                        child: Icon(
                          Icons.mode_comment,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      label: Text('Rec Err'),
                      onPressed: () {},
                      backgroundColor: Colors.grey[200],
                      shape: StadiumBorder(
                          side: BorderSide(
                        width: 1,
                        color: Colors.purpleAccent,
                      )),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                ActionChip(
                  elevation: 8.0,
                  padding: EdgeInsets.all(2.0),
                  avatar: CircleAvatar(
                    backgroundColor: Colors.greenAccent,
                    child: Icon(
                      Icons.mode_comment,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  label: Text('Block'),
                  onPressed: () {},
                  backgroundColor: Colors.grey[200],
                  shape: StadiumBorder(
                      side: BorderSide(
                    width: 1,
                    color: Colors.greenAccent,
                  )),
                ),
                // ActionChip(
                //   elevation: 8.0,
                //   padding: EdgeInsets.all(2.0),
                //   avatar: CircleAvatar(
                //     backgroundColor: Colors.greenAccent,
                //     child: Icon(
                //       Icons.mode_comment,
                //       color: Colors.white,
                //       size: 20,
                //     ),
                //   ),
                //   label: Text('Block Ast'),
                //   onPressed: () {},
                //   backgroundColor: Colors.grey[200],
                //   shape: StadiumBorder(
                //       side: BorderSide(
                //     width: 1,
                //     color: Colors.greenAccent,
                //   )),
                // ),
                ActionChip(
                  elevation: 8.0,
                  padding: EdgeInsets.all(2.0),
                  avatar: CircleAvatar(
                    backgroundColor: Colors.greenAccent,
                    child: Icon(
                      Icons.mode_comment,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  label: Text('Block Err'),
                  onPressed: () {},
                  backgroundColor: Colors.grey[200],
                  shape: StadiumBorder(
                      side: BorderSide(
                    width: 1,
                    color: Colors.greenAccent,
                  )),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}

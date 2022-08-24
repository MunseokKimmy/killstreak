import 'package:flutter/material.dart';
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
                style: const TextStyle(fontSize: 22),
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
                              fontSize: 20,
                            ),
                          ),
                          Text(widget.playerGameStats.aces.toString(),
                              style: const TextStyle(
                                fontFamily: "Courier New",
                                fontSize: 20,
                              )),
                        ],
                      ),
                      const VerticalDivider(
                        color: Colors.white,
                        width: 2,
                        thickness: 1,
                      ),
                      Column(
                        children: [
                          const Text("K",
                              style: TextStyle(
                                fontFamily: "Courier New",
                                fontSize: 20,
                              )),
                          Text(widget.playerGameStats.kills.toString(),
                              style: const TextStyle(
                                fontFamily: "Courier New",
                                fontSize: 20,
                              )),
                        ],
                      ),
                      const VerticalDivider(
                        color: Colors.white,
                        width: 2,
                        thickness: 1,
                      ),
                      Column(
                        children: [
                          const Text("As",
                              style: TextStyle(
                                fontFamily: "Courier New",
                                fontSize: 20,
                              )),
                          Text(widget.playerGameStats.assists.toString(),
                              style: const TextStyle(
                                fontFamily: "Courier New",
                                fontSize: 20,
                              )),
                        ],
                      ),
                      const VerticalDivider(
                        color: Colors.white,
                        width: 2,
                        thickness: 1,
                      ),
                      Column(
                        children: [
                          const Text("B",
                              style: TextStyle(
                                fontFamily: "Courier New",
                                fontSize: 20,
                              )),
                          Text(widget.playerGameStats.blocks.toString(),
                              style: const TextStyle(
                                fontFamily: "Courier New",
                                fontSize: 20,
                              )),
                        ],
                      ),
                      const VerticalDivider(
                        color: Colors.white,
                        width: 2,
                        thickness: 1,
                      ),
                      Column(
                        children: [
                          const Text("D",
                              style: TextStyle(
                                fontFamily: "Courier New",
                                fontSize: 20,
                              )),
                          Text(widget.playerGameStats.digs.toString(),
                              style: const TextStyle(
                                fontFamily: "Courier New",
                                fontSize: 20,
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
                // IntrinsicHeight(
                //     child: Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     Text(widget.playerGameStats.aces.toString(),
                //         style: const TextStyle(
                //             fontFamily: "Courier New",
                //             fontSize: 20,
                //             )),
                //     const VerticalDivider(
                //       color: Colors.white,
                //       width: 2,
                //       thickness: 1,
                //     ),
                //     Text(widget.playerGameStats.kills.toString(),
                //         style: const TextStyle(
                //             fontFamily: "Courier New",
                //             fontSize: 20,
                //             )),
                //     const VerticalDivider(
                //       color: Colors.white,
                //       width: 2,
                //       thickness: 1,
                //     ),
                //     Text(widget.playerGameStats.assists.toString(),
                //         style: const TextStyle(
                //             fontFamily: "Courier New",
                //             fontSize: 20,
                //             )),
                //     const VerticalDivider(
                //       color: Colors.white,
                //       width: 2,
                //       thickness: 1,
                //     ),
                //     Text(widget.playerGameStats.blocks.toString(),
                //         style: const TextStyle(
                //             fontFamily: "Courier New",
                //             fontSize: 20,
                //             )),
                //     const VerticalDivider(
                //       color: Colors.white,
                //       width: 2,
                //       thickness: 1,
                //     ),
                //     Text(widget.playerGameStats.digs.toString(),
                //         style: const TextStyle(
                //             fontFamily: "Courier New",
                //             fontSize: 20,
                //             )),
                //   ],
                // )),
              ],
            ))
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
    return Container();
  }
}
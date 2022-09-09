import 'package:flutter/material.dart';
import 'package:killstreak/main.dart';
import 'package:killstreak/model/stats_service.dart';

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

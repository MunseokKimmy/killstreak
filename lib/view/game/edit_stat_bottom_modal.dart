import 'package:customizable_counter/customizable_counter.dart';
import 'package:flutter/material.dart';
import 'package:killstreak/main.dart';
import 'package:killstreak/model/dtos/stat_info_literal.dart';
import 'package:killstreak/model/ongoing_game_service.dart';

class EditStatBottomModal extends StatefulWidget {
  int initialStat;
  String playerName;
  String playerStatId;
  String statName;
  String statDataName;
  bool onTeamOne;
  int gameId;
  late int _counter;
  List<String> immediatePointForTeam = ["kills", "ace", "blocks"];
  List<String> immediatePointForOpposingTeam = [
    "service_errors",
    "ball_handling_errors",
    "attack_errors"
  ];
  EditStatBottomModal(
      {Key? key,
      required this.initialStat,
      required this.playerName,
      required this.playerStatId,
      required this.statName,
      required this.statDataName,
      required this.onTeamOne,
      required this.gameId})
      : super(key: key) {
    _counter = initialStat;
  }

  @override
  State<EditStatBottomModal> createState() => _EditStatBottomModalState();
}

class _EditStatBottomModalState extends State<EditStatBottomModal> {
  void _incrementCounter() {
    setState(() {
      widget._counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (widget._counter > 0) {
        widget._counter--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      height: MediaQuery.of(context).size.height * .5,
      color: baseColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "${widget.playerName}'s ${widget.statName}",
            style: const TextStyle(fontSize: 22, color: Colors.white),
          ),
          Text(StatInfoLiteral().getInfo(widget.statDataName),
              style: const TextStyle(color: Colors.white, fontSize: 18)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 60,
                width: 60,
                child: Material(
                  color: accentColor,
                  borderRadius:
                      const BorderRadius.all(const Radius.circular(15)),
                  child: IconButton(
                    iconSize: 30,
                    onPressed: _decrementCounter,
                    icon: const Icon(
                      Icons.remove,
                      color: Colors.red,
                    ),
                    splashColor: Colors.redAccent,
                    splashRadius: 40,
                  ),
                ),
              ),
              Text(
                widget._counter.toString(),
                style: const TextStyle(fontSize: 28, color: Colors.white),
              ),
              SizedBox(
                height: 60,
                width: 60,
                child: Material(
                  color: accentColor,
                  borderRadius:
                      const BorderRadius.all(const Radius.circular(15)),
                  child: IconButton(
                    iconSize: 30,
                    onPressed: _incrementCounter,
                    icon: const Icon(
                      Icons.add,
                      color: Colors.green,
                    ),
                    splashColor: Colors.greenAccent,
                    splashRadius: 40,
                  ),
                ),
              ),
            ],
          ),
          ElevatedButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.resolveWith((states) =>
                    const EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 10)),
                backgroundColor: MaterialStateProperty.resolveWith((states) {
                  // If the button is pressed, return green, otherwise blue
                  if (states.contains(MaterialState.pressed)) {
                    return accentColor;
                  }
                  return lightColor;
                }),
              ),
              onPressed: () async {
                if (widget.initialStat != widget._counter) {
                  OngoingGameService().updateSingleStatInt(widget.playerStatId,
                      widget.statDataName, widget._counter);
                  if (widget.immediatePointForTeam
                      .contains(widget.statDataName)) {
                    int difference = widget._counter - widget.initialStat;
                    OngoingGameService().updateTeamScore(
                        widget.gameId, widget.onTeamOne, difference);
                  } else if (widget.immediatePointForOpposingTeam
                      .contains(widget.statDataName)) {
                    int difference = widget._counter - widget.initialStat;
                    OngoingGameService().updateTeamScore(
                        widget.gameId, !widget.onTeamOne, difference);
                  }
                }
                Navigator.pop(context);
              },
              child: const Text("Done", style: const TextStyle(fontSize: 20))),
        ],
      ),
    );
  }
}

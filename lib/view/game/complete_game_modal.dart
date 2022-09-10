import 'package:flutter/material.dart';
import 'package:killstreak/main.dart';
import 'package:killstreak/model/ongoing_game_service.dart';
import 'package:killstreak/view/home_page.dart';

class CompleteGameModal extends StatelessWidget {
  int gameId;
  CompleteGameModal({Key? key, required this.gameId}) : super(key: key);
  final String confirmationMessage =
      "This action cannot be undone. Are you ready to end the game?";
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      height: MediaQuery.of(context).size.height * .3,
      color: baseColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            confirmationMessage,
            style: TextStyle(color: Colors.white, fontSize: 22),
            textAlign: TextAlign.center,
          ),
          ElevatedButton.icon(
            icon: const Icon(
              Icons.done,
              size: 40,
            ),
            label: const Text(
              "Complete Game",
              style: TextStyle(fontSize: 17),
            ),
            style: ElevatedButton.styleFrom(
              primary: lightColor,
              fixedSize: Size(MediaQuery.of(context).size.width * .8, 50),
            ),
            onPressed: () async {
              OngoingGameService().gameCompleted(gameId);
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

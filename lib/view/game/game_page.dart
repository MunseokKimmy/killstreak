import 'package:flutter/material.dart';
import 'package:killstreak/model/dtos/game.dto.dart';
import 'package:killstreak/view/game/completed_game_page.dart';
import 'package:killstreak/view/game/ongoing_game_page.dart';
import 'package:killstreak/widgets/bottom_navigation.dart';

import '../../model/game_service.dart';

class GamePage extends StatelessWidget {
  GameShort game;
  GamePage({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(game.gameName),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.info_outline),
          ),
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: game.gameCompleted
          ? CompletedGamePage(game: game)
          : OngoingGameWidget(game: game),
      bottomNavigationBar: BottomNavigation(
        currentPage: 1,
        shortcut: true,
      ),
    );
  }
}

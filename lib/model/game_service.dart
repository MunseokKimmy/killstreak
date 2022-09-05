import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:killstreak/model/dtos/game.dto.dart';

class GameService {
  List<GameShort> gameShorts = [];
  GameService() {
    gameShorts.add(GameShort("Playoffs Game 1", "Aldair's Volleyball Group",
        "Jul 29, 2022", "Red", "Blue", 0, 0, true, false, false));
    gameShorts.add(GameShort("Playoffs Game 2", "Aldair's Volleyball Group",
        "Jul 29, 2022", "Yellow", "Green", 12, 25, true, true, true));
    gameShorts.add(GameShort("Playoffs Game 3", "RB", "Jul 29, 2022", "Grey",
        "Black", 25, 11, false, false, true));
    gameShorts.add(GameShort("Playoffs Game 4", "BYU Intermurals",
        "Jul 29, 2022", "Orange", "Brown", 18, 25, true, true, true));
    gameShorts.add(GameShort("Playoffs Game 5", "47th Ward", "Jul 29, 2022",
        "White", "Pink", 25, 7, false, false, true));
  }
  List<GameShort> getGameShorts() {
    return gameShorts;
  }

  setGameShorts(List<GameShort> games) {}
}

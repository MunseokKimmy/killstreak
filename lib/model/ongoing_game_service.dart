import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:killstreak/model/dtos/game.dto.dart';
import 'package:killstreak/model/stats_service.dart';

class OngoingGameService {
  final _database = FirebaseDatabase.instance.ref();

  Stream<List<PlayerGameStats>> getPlayerStatsStream(int gameId) {
    final playerStatStream = _database
        .child('players')
        .orderByChild("game_id")
        .equalTo(gameId)
        .onValue;
    final results = playerStatStream.map((event) {
      final String parsed = json.encode(event.snapshot.value);
      Map<String, dynamic> map = jsonDecode(parsed);
      final statList = map.entries.map((element) {
        return PlayerGameStats.fromRTDB(
            Map<String, dynamic>.from(element.value));
      }).toList();
      return statList;
    });
    return results;
  }

  Stream<List<String>> getPlayerListStream(int gameId, bool onTeamOne) {
    final teamAddress = onTeamOne ? 'team-one-players' : 'team-two-players';
    final playerListStream =
        _database.child('games/game-$gameId/$teamAddress').onValue;
    final results = playerListStream.map((event) {
      final String parsed = json.encode(event.snapshot.value);
      List<String> playerList =
          (jsonDecode(parsed) as List<dynamic>).cast<String>();
      return playerList;
    });
    return results;
  }

  Stream<PlayerGameStats> getSinglePlayerStatStream(String gamePlayerId) {
    final playerStatStream = _database.child('players/$gamePlayerId').onValue;
    final result = playerStatStream.map((event) {
      final String parsed = json.encode(event.snapshot.value);
      Map<String, dynamic> map = jsonDecode(parsed);
      PlayerGameStats playerGameStats = PlayerGameStats.fromRTDB(map);
      return playerGameStats;
    });
    return result;
  }

  Stream<Game> getGameStream(int gameId) {
    final gameStream = _database.child('/games/game-$gameId').onValue;
    final results = gameStream.map((event) {
      final String parsed = json.encode(event.snapshot.value);
      Map<String, dynamic> map = jsonDecode(parsed);
      Game game = Game.fromRTDB(map);
      return game;
    });
    return results;
  }
}

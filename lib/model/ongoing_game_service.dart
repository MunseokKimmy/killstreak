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

  Future<List> getPlayerListFuture(int gameId, bool onTeamOne) async {
    final teamAddress = onTeamOne ? 'team-one-players' : 'team-two-players';
    final snapshot =
        await _database.child('games/game-$gameId/$teamAddress').get();
    if (snapshot.exists) {
      List playerList = snapshot.value as List;
      List<String> playerIds = [];
      for (var element in playerList) {
        if (element != null) {
          var playerId = element;
          playerIds.add(playerId);
        }
      }
      return playerIds;
    } else {
      return [];
    }
  }

  Stream<int> getSingleStatStreamInt(
      int gameId, String gamePlayerId, String statName) {
    final statStream =
        _database.child('players/$gameId/$gamePlayerId/$statName').onValue;
    final result = statStream.map((event) {
      return event.snapshot.value as int;
    });
    return result;
  }

  void updateSingleStatInt(
      String gamePlayerId, String statName, int newStatCount) async {
    await _database
        .child('players/$gamePlayerId')
        .update({statName: newStatCount});
  }

  void updateTeamScore(int gameId, bool teamOne, int pointsToAdd) async {
    String teamAddress = teamOne ? 'team_one_score' : 'team_two_score';
    updateTeamServing(gameId, teamOne);
    await _database
        .child('games/game-$gameId/teams/$teamAddress')
        .set(ServerValue.increment(pointsToAdd));
  }

  void updateTeamServing(int gameId, bool teamOne) async {
    String teamAddress = 'team_one_serving';
    await _database.child('games/game-$gameId/teams/$teamAddress').set(teamOne);
  }

  void gameCompleted(int gameId) async {
    await _database.child('games/game-$gameId/completed/').set(true);
  }

  void updatePlayerName() {
    //next release
    // String gamePlayerId, String newName, String newLastName) async {
    // await _database.child('players/$gamePlayerId').
  }

  Future<List<String>> getRecentGameIds(String uid) async {
    final snapshot =
        await _database.child('accounts/$uid').limitToLast(5).get();
    if (snapshot.exists) {
      List gameList = snapshot.value as List;
      List<String> gameIds = [];
      for (var element in gameList) {
        if (element != null) {
          var gameId = "game-${element as int}";
          gameIds.add(gameId);
        }
      }
      return gameIds;
    } else {
      return [];
    }
  }

  Future<List<GameShort>> getGameShorts(String uid) async {
    final List<String> gameIds = await getRecentGameIds(uid);
    List<GameShort> games = [];
    for (var element in gameIds) {
      final snapshot = await _database.child('games/$element').get();
      final String parsed = json.encode(snapshot.value);
      Map<String, dynamic> map = jsonDecode(parsed);
      GameShort game = GameShort.fromRTDB(map);
      games.add(game);
    }
    return games;
  }

  Stream<String> getSingleStatStreamString(
      String gamePlayerId, int gameId, String statName) {
    final statStream =
        _database.child('players/$gameId/$gamePlayerId/$statName').onValue;
    final result = statStream.map((event) {
      return event.snapshot.value as String;
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

  Stream<TeamInfo> getGameTeamInfoStream(int gameId) {
    final gameStream = _database.child('/games/game-$gameId/teams').onValue;
    final results = gameStream.map((event) {
      final String parsed = json.encode(event.snapshot.value);
      Map<String, dynamic> map = jsonDecode(parsed);
      TeamInfo teamInfo = TeamInfo.fromRTDB(map);
      return teamInfo;
    });
    return results;
  }
}

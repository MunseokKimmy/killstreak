import 'package:firebase_database/firebase_database.dart';

class LifeTimeStats {
  String playerName;
  String playerId;
  DateTime playerSince;
  int aces;
  int kills;
  int assists;
  int blocks;
  int digs;
  int serviceErrors;
  int receptionErrors;
  int blockErrors;
  int ballHandlingErrors;
  LifeTimeStats(
      this.playerName,
      this.playerId,
      this.playerSince,
      this.aces,
      this.kills,
      this.assists,
      this.blocks,
      this.digs,
      this.serviceErrors,
      this.receptionErrors,
      this.blockErrors,
      this.ballHandlingErrors);
}

class PlayerGameStats {
  String playerName;
  String playerLastName;
  int playerId;
  int gameId;
  int groupId;
  bool onTeamOne;
  int aces = 0;
  int kills = 0;
  int assists = 0;
  int blocks = 0;
  int digs = 0;
  int serviceErrors = 0;
  int atkErrors = 0;
  int receptionErrors = 0;
  int blockErrors = 0;
  int ballHandlingErrors = 0;
  PlayerGameStats(
      this.playerName,
      this.playerLastName,
      this.playerId,
      this.gameId,
      this.groupId,
      this.onTeamOne,
      this.aces,
      this.kills,
      this.assists,
      this.blocks,
      this.digs,
      this.serviceErrors,
      this.atkErrors,
      this.receptionErrors,
      this.blockErrors,
      this.ballHandlingErrors);

  factory PlayerGameStats.fromRTDB(Map<String, dynamic> json) {
    return PlayerGameStats(
        json['player_name'],
        json['player_last_name'],
        json['player_id'],
        json['game_id'],
        json['group_id'],
        json['on_team_one'],
        json['ace'],
        json['kills'],
        json['assists'],
        json['blocks'],
        json['digs'],
        json['service_errors'],
        json['attack_errors'],
        json['reception_errors'],
        json['block_errors'],
        json['ball_handling_errors']);
  }
}

class StatsService {
  // DatabaseReference ref = FirebaseDatabase.instance.ref("games/game-1/teams");
  List<PlayerGameStats> groupGameStats = [];
  List<PlayerGameStats> singleGameStats = [];
  List<PlayerGameStats> emptySingleGameStats = [];
  var gameData;
  StatsService() {
    // ref.onValue.listen((event) {
    //   final data = event.snapshot.value;
    //   updateCount(data);
    // });
    // groupGameStats.add(PlayerGameStats(
    //     "Munseok Kim", 1, 1, 6424, true, 0, 0, 0, 0, 0, 2, 2, 3, 1, 4));
    // groupGameStats.add(PlayerGameStats(
    //     "Munseok Kim", 1, 2, 6424, true, 0, 0, 0, 0, 0, 2, 3, 3, 1, 4));
    // groupGameStats.add(PlayerGameStats(
    //     "Munseok Kim", 1, 3, 6424, true, 0, 0, 0, 0, 0, 2, 7, 3, 1, 4));
    // groupGameStats.add(PlayerGameStats(
    //     "Munseok Kim", 1, 4, 6424, true, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0));
    // groupGameStats.add(PlayerGameStats(
    //     "Munseok Kim", 1, 5, 6424, true, 0, 0, 0, 0, 0, 2, 0, 3, 1, 4));

    // singleGameStats.add(PlayerGameStats(
    //     "Munseok", 1, 1, 6424, true, 5, 1, 3, 5, 1, 0, 0, 0, 0, 0));
    // singleGameStats.add(PlayerGameStats(
    //     "Kerrigan", 1, 1, 6424, true, 2, 4, 4, 1, 7, 2, 0, 3, 0, 0));
    // singleGameStats.add(PlayerGameStats(
    //     "Jessie", 1, 1, 6424, true, 7, 8, 2, 4, 3, 0, 0, 0, 0, 0));
    // singleGameStats.add(PlayerGameStats(
    //     "Jason", 1, 1, 6424, true, 1, 3, 4, 9, 2, 1, 0, 1, 2, 3));
    // singleGameStats.add(PlayerGameStats(
    //     "Mariah", 1, 1, 6424, true, 2, 2, 3, 1, 4, 1, 0, 3, 1, 3));
    // singleGameStats.add(PlayerGameStats(
    //     "Kaden", 1, 1, 6424, true, 3, 1, 5, 1, 5, 2, 0, 1, 1, 2));
    // singleGameStats.add(PlayerGameStats(
    //     "Jaxon", 1, 1, 6424, true, 1, 3, 4, 9, 2, 1, 0, 1, 2, 3));
    // singleGameStats.add(PlayerGameStats(
    //     "Lydia", 1, 1, 6424, true, 2, 2, 3, 1, 4, 1, 1, 3, 1, 3));
    // singleGameStats.add(PlayerGameStats(
    //     "Spencer", 1, 1, 6424, true, 3, 1, 5, 1, 5, 2, 1, 1, 1, 2));

    // singleGameStats.add(PlayerGameStats(
    //     "Everett", 1, 1, 6424, false, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0));
    // singleGameStats.add(PlayerGameStats(
    //     "Aldair", 1, 1, 6424, false, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0));
    // singleGameStats.add(PlayerGameStats(
    //     "Alma", 1, 1, 6424, false, 0, 0, 0, 0, 0, 2, 0, 3, 1, 4));
    // singleGameStats.add(PlayerGameStats(
    //     "Rubi", 1, 1, 6424, false, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0));
    // singleGameStats.add(PlayerGameStats(
    //     "Aubin", 1, 1, 6424, false, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0));
    // singleGameStats.add(PlayerGameStats(
    //     "Cierra", 1, 1, 6424, false, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0));
    // singleGameStats.add(PlayerGameStats(
    //     "Ana", 1, 1, 6424, false, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0));
    // singleGameStats.add(PlayerGameStats(
    //     "Eve", 1, 1, 6424, false, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0));
    // singleGameStats.add(PlayerGameStats(
    //     "Zabdi", 1, 1, 6424, false, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0));

    // emptySingleGameStats.add(PlayerGameStats(
    //     "Munseok", 1, 1, 6424, true, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0));
    // emptySingleGameStats.add(PlayerGameStats(
    //     "Kerrigan", 1, 1, 6424, true, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0));
    // emptySingleGameStats.add(PlayerGameStats(
    //     "Jessie", 1, 1, 6424, true, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0));
    // emptySingleGameStats.add(PlayerGameStats(
    //     "Jason", 1, 1, 6424, true, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0));
    // emptySingleGameStats.add(PlayerGameStats(
    //     "Mariah", 1, 1, 6424, true, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0));
    // emptySingleGameStats.add(PlayerGameStats(
    //     "Kaden", 1, 1, 6424, true, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0));
    // emptySingleGameStats.add(PlayerGameStats(
    //     "Jaxon", 1, 1, 6424, true, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0));
    // emptySingleGameStats.add(PlayerGameStats(
    //     "Lydia", 1, 1, 6424, true, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0));
    // emptySingleGameStats.add(PlayerGameStats(
    //     "Spencer", 1, 1, 6424, true, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0));

    // emptySingleGameStats.add(PlayerGameStats(
    //     "Everett", 1, 1, 6424, false, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0));
    // emptySingleGameStats.add(PlayerGameStats(
    //     "Aldair", 1, 1, 6424, false, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0));
    // emptySingleGameStats.add(PlayerGameStats(
    //     "Alma", 1, 1, 6424, false, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0));
    // emptySingleGameStats.add(PlayerGameStats(
    //     "Rubi", 1, 1, 6424, false, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0));
    // emptySingleGameStats.add(PlayerGameStats(
    //     "Aubin", 1, 1, 6424, false, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0));
    // emptySingleGameStats.add(PlayerGameStats(
    //     "Cierra", 1, 1, 6424, false, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0));
    // emptySingleGameStats.add(PlayerGameStats(
    //     "Ana", 1, 1, 6424, false, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0));
    // emptySingleGameStats.add(PlayerGameStats(
    //     "Eve", 1, 1, 6424, false, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0));
    // emptySingleGameStats.add(PlayerGameStats(
    //     "Zabdi", 1, 1, 6424, false, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0));
  }

  // Future<void> updateCount(data) async {
  //   gameData = data;
  // }

  List<PlayerGameStats> getPlayerGameStats() {
    return groupGameStats;
  }

  List<PlayerGameStats> getSingleGameStats() {
    return singleGameStats;
  }

  List<PlayerGameStats> getTeamOneSingleGameStats() {
    return singleGameStats.where((stat) => stat.onTeamOne).toList();
  }

  List<PlayerGameStats> getTeamTwoSingleGameStats() {
    return singleGameStats.where((stat) => !stat.onTeamOne).toList();
  }

  List<PlayerGameStats> getEmptyTeamOneSingleGameStats() {
    return emptySingleGameStats.where((stat) => stat.onTeamOne).toList();
  }

  List<PlayerGameStats> getEmptyTeamTwoSingleGameStats() {
    return emptySingleGameStats.where((stat) => !stat.onTeamOne).toList();
  }
}

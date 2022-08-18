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
  int playerId;
  String gameName;
  int gameId;
  String groupName;
  int groupId;
  int aces;
  int kills;
  int assists;
  int blocks;
  int digs;
  int serviceErrors;
  int receptionErrors;
  int blockErrors;
  int ballHandlingErrors;
  PlayerGameStats(
      this.playerName,
      this.playerId,
      this.gameName,
      this.gameId,
      this.groupName,
      this.groupId,
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

class StatsService {
  List<PlayerGameStats> gameStats = [];
  StatsService() {
    gameStats.add(PlayerGameStats("Munseok Kim", 1, "Playoffs Game 1", 1,
        "Aldair's Volleyball Group", 6424, 5, 4, 4, 1, 7, 2, 3, 1, 4));
    gameStats.add(PlayerGameStats("Munseok Kim", 1, "Playoffs Game 2", 2,
        "Aldair's Volleyball Group", 6424, 5, 4, 4, 1, 7, 2, 3, 1, 4));
    gameStats.add(PlayerGameStats("Munseok Kim", 1, "Playoffs Game 3", 3,
        "Aldair's Volleyball Group", 6424, 5, 4, 4, 1, 7, 2, 3, 1, 4));
    gameStats.add(PlayerGameStats("Munseok Kim", 1, "Playoffs Game 4", 4,
        "Aldair's Volleyball Group", 6424, 5, 4, 4, 1, 7, 2, 3, 1, 4));
    gameStats.add(PlayerGameStats("Munseok Kim", 1, "Playoffs Game 5", 5,
        "Aldair's Volleyball Group", 6424, 5, 4, 4, 1, 7, 2, 3, 1, 4));
  }
  List<PlayerGameStats> getPlayerGameStats() {
    return gameStats;
  }
}

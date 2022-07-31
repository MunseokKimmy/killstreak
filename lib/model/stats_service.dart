class LifeTimeStats {}

class PlayerGameStats {
  String playerName;
  String gameName;
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
      this.gameName,
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
    gameStats.add(PlayerGameStats(
        "Munseok Kim", "Playoffs Game 1", 5, 4, 4, 1, 7, 2, 3, 1, 4));
    gameStats.add(PlayerGameStats(
        "Munseok Kim", "Playoffs Game 2", 5, 4, 4, 1, 7, 2, 3, 1, 4));
    gameStats.add(PlayerGameStats(
        "Munseok Kim", "Playoffs Game 3", 5, 4, 4, 1, 7, 2, 3, 1, 4));
    gameStats.add(PlayerGameStats(
        "Munseok Kim", "Playoffs Game 4", 5, 4, 4, 1, 7, 2, 3, 1, 4));
    gameStats.add(PlayerGameStats(
        "Munseok Kim", "Playoffs Game 5", 5, 4, 4, 1, 7, 2, 3, 1, 4));
  }
  List<PlayerGameStats> getPlayerGameStats() {
    return gameStats;
  }
}

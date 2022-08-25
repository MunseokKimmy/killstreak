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
  bool onTeamOne;
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
      this.onTeamOne,
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
  List<PlayerGameStats> groupGameStats = [];
  List<PlayerGameStats> singleGameStats = [];
  StatsService() {
    groupGameStats.add(PlayerGameStats("Munseok Kim", 1, "Playoffs Game 1", 1,
        "Aldair's Volleyball Group", 6424, true, 5, 4, 4, 1, 7, 2, 3, 1, 4));
    groupGameStats.add(PlayerGameStats("Munseok Kim", 1, "Playoffs Game 2", 2,
        "Aldair's Volleyball Group", 6424, true, 5, 4, 4, 1, 7, 2, 3, 1, 4));
    groupGameStats.add(PlayerGameStats("Munseok Kim", 1, "Playoffs Game 3", 3,
        "Aldair's Volleyball Group", 6424, true, 5, 4, 4, 1, 7, 2, 3, 1, 4));
    groupGameStats.add(PlayerGameStats("Munseok Kim", 1, "Playoffs Game 4", 4,
        "Aldair's Volleyball Group", 6424, true, 5, 4, 4, 1, 7, 2, 3, 1, 4));
    groupGameStats.add(PlayerGameStats("Munseok Kim", 1, "Playoffs Game 5", 5,
        "Aldair's Volleyball Group", 6424, true, 5, 4, 4, 1, 7, 2, 3, 1, 4));

    singleGameStats.add(PlayerGameStats("Munseok", 1, "Playoffs Game 1", 1,
        "Aldair's Volleyball Group", 6424, true, 5, 1, 3, 5, 1, 0, 0, 0, 0));
    singleGameStats.add(PlayerGameStats("Kerrigan", 1, "Playoffs Game 1", 1,
        "Aldair's Volleyball Group", 6424, true, 2, 4, 4, 1, 7, 2, 3, 0, 0));
    singleGameStats.add(PlayerGameStats("Jessie", 1, "Playoffs Game 1", 1,
        "Aldair's Volleyball Group", 6424, true, 7, 8, 2, 4, 3, 0, 0, 0, 0));
    singleGameStats.add(PlayerGameStats("Jason", 1, "Playoffs Game 1", 1,
        "Aldair's Volleyball Group", 6424, true, 1, 3, 4, 9, 2, 1, 1, 2, 3));
    singleGameStats.add(PlayerGameStats("Mariah", 1, "Playoffs Game 1", 1,
        "Aldair's Volleyball Group", 6424, true, 2, 2, 3, 1, 4, 1, 3, 1, 3));
    singleGameStats.add(PlayerGameStats("Kaden", 1, "Playoffs Game 1", 1,
        "Aldair's Volleyball Group", 6424, true, 3, 1, 5, 1, 5, 2, 1, 1, 2));
    singleGameStats.add(PlayerGameStats("Jaxon", 1, "Playoffs Game 1", 1,
        "Aldair's Volleyball Group", 6424, true, 1, 3, 4, 9, 2, 1, 1, 2, 3));
    singleGameStats.add(PlayerGameStats("Lydia", 1, "Playoffs Game 1", 1,
        "Aldair's Volleyball Group", 6424, true, 2, 2, 3, 1, 4, 1, 3, 1, 3));
    singleGameStats.add(PlayerGameStats("Spencer", 1, "Playoffs Game 1", 1,
        "Aldair's Volleyball Group", 6424, true, 3, 1, 5, 1, 5, 2, 1, 1, 2));

    singleGameStats.add(PlayerGameStats("Everett", 1, "Playoffs Game 1", 1,
        "Aldair's Volleyball Group", 6424, false, 5, 4, 4, 1, 7, 2, 3, 1, 4));
    singleGameStats.add(PlayerGameStats("Aldair", 1, "Playoffs Game 1", 1,
        "Aldair's Volleyball Group", 6424, false, 5, 4, 4, 1, 7, 2, 3, 1, 4));
    singleGameStats.add(PlayerGameStats("Alma", 1, "Playoffs Game 1", 1,
        "Aldair's Volleyball Group", 6424, false, 5, 4, 4, 1, 7, 2, 3, 1, 4));
    singleGameStats.add(PlayerGameStats("Rubi", 1, "Playoffs Game 1", 1,
        "Aldair's Volleyball Group", 6424, false, 5, 4, 4, 1, 7, 2, 3, 1, 4));
    singleGameStats.add(PlayerGameStats("Aubin", 1, "Playoffs Game 1", 1,
        "Aldair's Volleyball Group", 6424, false, 5, 4, 4, 1, 7, 2, 3, 1, 4));
    singleGameStats.add(PlayerGameStats("Cierra", 1, "Playoffs Game 1", 1,
        "Aldair's Volleyball Group", 6424, false, 5, 4, 4, 1, 7, 2, 3, 1, 4));
    singleGameStats.add(PlayerGameStats("Ana", 1, "Playoffs Game 1", 1,
        "Aldair's Volleyball Group", 6424, false, 5, 4, 4, 1, 7, 2, 3, 1, 4));
    singleGameStats.add(PlayerGameStats("Eve", 1, "Playoffs Game 1", 1,
        "Aldair's Volleyball Group", 6424, false, 5, 4, 4, 1, 7, 2, 3, 1, 4));
    singleGameStats.add(PlayerGameStats("Zabdi", 1, "Playoffs Game 1", 1,
        "Aldair's Volleyball Group", 6424, false, 5, 4, 4, 1, 7, 2, 3, 1, 4));
  }
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
}

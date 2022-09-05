class GameShort {
  String gameName = "";
  String groupName = "";
  String gameDate = "";
  String teamOneName = "";
  String teamTwoName = "";
  int teamOneScore = 0;
  int teamTwoScore = 0;
  bool teamOneServing = true;
  bool onTeamOne;
  bool gameCompleted = false;
  GameShort(
      this.gameName,
      this.groupName,
      this.gameDate,
      this.teamOneName,
      this.teamTwoName,
      this.teamOneScore,
      this.teamTwoScore,
      this.teamOneServing,
      this.onTeamOne,
      this.gameCompleted);
}

class GameStatsSummary {
  String gameName = "";
  String groupName = "";
  String gameDate = "";
  String teamOneName = "";
  String teamTwoName = "";
  String topScorerName = "";
  String topAssisterName = "";
  String topDefenderName = "";
  int aceCount = 0;
  int killCount = 0;
  int assistCount = 0;
  int digCount = 0;
  int blockCount = 0;
}

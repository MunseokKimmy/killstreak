class GameShort {
  int gameId = 0;
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
      this.gameId,
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

class Game {
  String gameName;
  int gameId;
  String groupName;
  int groupId;
  DateTime date;
  String location;
  List<String> players;
  TeamInfo teaminfo;
  Game(this.gameName, this.gameId, this.groupName, this.groupId, this.date,
      this.location, this.players, this.teaminfo);

  factory Game.fromMap(Map<String, dynamic> json) {
    TeamInfo teamInfo = TeamInfo.fromMap(json['teams']);
    return Game(
        json['game_name'] ?? "",
        json['game_id'] ?? 0,
        json['group_name'] ?? "",
        json['group_id'] ?? 0,
        json['date'] ?? "",
        json['location'] ?? "",
        json['players'] ?? [],
        teamInfo);
  }
}

class TeamInfo {
  String teamOneName;
  int teamOneScore;
  String teamTwoName;
  int teamTwoScore;
  bool teamOneServing;
  TeamInfo(this.teamOneName, this.teamOneScore, this.teamTwoName,
      this.teamTwoScore, this.teamOneServing);

  factory TeamInfo.fromMap(Map<String, dynamic> json) {
    return TeamInfo(
        json['team_one_name'] ?? "",
        json['team_one_score'] ?? 0,
        json['team_two_name'] ?? "",
        json['team_two_score'] ?? 0,
        json['team_one_serving'] ?? false);
  }
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

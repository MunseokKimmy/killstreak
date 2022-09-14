class GameShort {
  int gameId = 0;
  String gameName = "";
  String groupName = "";
  String gameDate = "";
  TeamInfo teamInfo;
  bool gameCompleted = false;
  String location;

  GameShort(this.gameId, this.gameName, this.groupName, this.gameDate,
      this.teamInfo, this.gameCompleted, this.location);

  factory GameShort.fromRTDB(Map<String, dynamic> json) {
    TeamInfo teamInfo = TeamInfo.fromRTDB(json['teams']);
    return GameShort(json['game_id'], json['game_name'], json['group_name'],
        json['date'], teamInfo, json['completed'], json['location']);
  }
}

class Game {
  String gameName;
  int gameId;
  String groupName;
  int groupId;
  String date;
  String location;
  List players;
  bool completed;
  TeamInfo teaminfo;
  Game(this.gameName, this.gameId, this.groupName, this.groupId, this.date,
      this.location, this.players, this.completed, this.teaminfo);

  factory Game.fromRTDB(Map<String, dynamic> json) {
    TeamInfo teamInfo = TeamInfo.fromRTDB(json['teams']);
    if (json['players'] != null) {
      List playersJson = json['players'];
      return Game(
          json['game_name'] ?? "",
          json['game_id'] ?? 0,
          json['group_name'] ?? "",
          json['group_id'] ?? 0,
          json['date'] ?? "",
          json['location'] ?? "",
          playersJson,
          json['completed'],
          teamInfo);
    } else {
      return Game(
          json['game_name'] ?? "",
          json['game_id'] ?? 0,
          json['group_name'] ?? "",
          json['group_id'] ?? 0,
          json['date'] ?? "",
          json['location'] ?? "",
          [],
          json['completed'],
          teamInfo);
    }
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

  factory TeamInfo.fromRTDB(Map<String, dynamic> json) {
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

class GameShort {
  String gameName = "";
  String groupName = "";
  String gameDate = "";
  String teamOneName = "";
  String teamTwoName = "";
  int teamOneScore = 0;
  int teamTwoScore = 0;
  bool teamOneServing = true;
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
      this.gameCompleted);
}

class GameService {
  List<GameShort> gameShorts = [];
  GameService() {
    gameShorts.add(GameShort("Playoffs Game 1", "Aldair's Volleyball Group",
        "Jul 29, 2022", "Team Red", "Team Blue", 25, 17, true, false));
    gameShorts.add(GameShort("Playoffs Game 2", "Aldair's Volleyball Group",
        "Jul 29, 2022", "Team Yellow", "Team Green", 2, 1, true, true));
    gameShorts.add(GameShort("Playoffs Game 3", "RB", "Jul 29, 2022",
        "Team Grey", "Team Black", 22, 11, false, false));
    gameShorts.add(GameShort("Playoffs Game 4", "BYU Intermurals",
        "Jul 29, 2022", "Team Orange", "Team Brown", 18, 5, true, false));
    gameShorts.add(GameShort("Playoffs Game 5", "47th Ward", "Jul 29, 2022",
        "Team White", "Team Pink", 1, 7, false, false));
  }
  List<GameShort> getGameShorts() {
    return gameShorts;
  }

  setGameShorts(List<GameShort> games) {}
}

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

class GameService {
  List<GameShort> gameShorts = [];
  GameService() {
    gameShorts.add(GameShort("Playoffs Game 1", "Aldair's Volleyball Group",
        "Jul 29, 2022", "Red", "Blue", 25, 17, true, false, false));
    gameShorts.add(GameShort("Playoffs Game 2", "Aldair's Volleyball Group",
        "Jul 29, 2022", "Yellow", "Green", 12, 25, true, true, true));
    gameShorts.add(GameShort("Playoffs Game 3", "RB", "Jul 29, 2022", "Grey",
        "Black", 25, 11, false, false, false));
    gameShorts.add(GameShort("Playoffs Game 4", "BYU Intermurals",
        "Jul 29, 2022", "Orange", "Brown", 18, 25, true, true, false));
    gameShorts.add(GameShort("Playoffs Game 5", "47th Ward", "Jul 29, 2022",
        "White", "Pink", 25, 7, false, false, false));
  }
  List<GameShort> getGameShorts() {
    return gameShorts;
  }

  setGameShorts(List<GameShort> games) {}
}

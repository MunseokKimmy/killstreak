class Group {
  String groupName;
  String groupId;
  Group(this.groupName, this.groupId);
}

class GroupStatsSummary {
  String groupName;
  String groupId;
  int gamesPlayed;
  String topAceName;
  String topAceUserName;
  int topAceAmount;
  String topKillName;
  String topKillUserName;
  int topKillAmount;
  String topAssistName;
  String topAssistUserName;
  int topAssistAmount;
  String topBlockName;
  String topBlockUserName;
  int topBlockAmount;
  String topDigName;
  String topDigUserName;
  int topDigAmount;
  GroupStatsSummary(
      this.groupName,
      this.groupId,
      this.gamesPlayed,
      this.topAceName,
      this.topAceUserName,
      this.topAceAmount,
      this.topKillName,
      this.topKillUserName,
      this.topKillAmount,
      this.topAssistName,
      this.topAssistUserName,
      this.topAssistAmount,
      this.topBlockName,
      this.topBlockUserName,
      this.topBlockAmount,
      this.topDigName,
      this.topDigUserName,
      this.topDigAmount);
}

class GroupService {
  List<Group> testGroups = [];
  late GroupStatsSummary groupStatsSummary;
  GroupService() {
    testGroups.add(Group("Aldair's Volleyball Group", "#6424"));
    testGroups.add(Group("RB", "#4211"));
    testGroups.add(Group("BYU Intermurals", "#9412"));
    testGroups.add(Group("47th Ward", "#8080"));
    groupStatsSummary = GroupStatsSummary(
        "Aldair's Volleyball Group",
        "#6424",
        725,
        "Lydia",
        "@lydia123",
        162,
        "Sara",
        "@saradavis321",
        80,
        "Mariah",
        "@mariahhh",
        67,
        "Jason",
        "@therealjason",
        40,
        "Alma",
        "@almaseo",
        100);
  }

  List<Group> getGroups() {
    return testGroups;
  }

  GroupStatsSummary getSummary() {
    return groupStatsSummary;
  }
}

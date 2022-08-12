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
  int topAceAmount;
  String topKillName;
  int topKillAmount;
  String topAssistName;
  int topAssistAmount;
  String topBlockName;
  int topBlockAmount;
  String topDigName;
  int topDigAmount;
  GroupStatsSummary(
      this.groupName,
      this.groupId,
      this.gamesPlayed,
      this.topAceName,
      this.topAceAmount,
      this.topKillName,
      this.topKillAmount,
      this.topAssistName,
      this.topAssistAmount,
      this.topBlockName,
      this.topBlockAmount,
      this.topDigName,
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
    groupStatsSummary = GroupStatsSummary("Aldair's Volleyball Group", "#6424",
        725, "Lydia", 162, "Sara", 80, "Mariah", 67, "Jason", 40, "Alma", 100);
  }

  List<Group> getGroups() {
    return testGroups;
  }

  GroupStatsSummary getSummary() {
    return groupStatsSummary;
  }
}

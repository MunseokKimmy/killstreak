import 'package:killstreak/enums/stat_enum.dart';

class Group {
  String groupName;
  String groupId;
  Group(this.groupName, this.groupId);
}

class GroupStatLeaders {
  String groupName;
  String groupId;
  StatType statType;
  List<String> topNames;
  List<int> topCounts;
  GroupStatLeaders(this.groupName, this.groupId, this.statType, this.topNames,
      this.topCounts);
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
  List<GroupStatLeaders> statLeaders = [];
  GroupService() {
    testGroups = getFakeGroups();
    groupStatsSummary = getFakeSummary();
    statLeaders = getAllFakeStatLeaders();
  }

  get getStatLeaders => this.statLeaders;

  set setStatLeaders(statLeaders) => this.statLeaders = statLeaders;
  List<Group> getGroups() {
    return testGroups;
  }

  GroupStatsSummary getSummary() {
    return groupStatsSummary;
  }
}

List<Group> getFakeGroups() {
  List<Group> testGroups = [];
  testGroups.add(Group("Aldair's Volleyball Group", "#6424"));
  testGroups.add(Group("RB", "#4211"));
  testGroups.add(Group("BYU Intermurals", "#9412"));
  testGroups.add(Group("47th Ward", "#8080"));
  return testGroups;
}

GroupStatsSummary getFakeSummary() {
  return GroupStatsSummary(
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

List<GroupStatLeaders> getAllFakeStatLeaders() {
  List<GroupStatLeaders> testAllStats = [];
  testAllStats.add(getFakeStatLeaders(StatType.Ace));
  testAllStats.add(getFakeStatLeaders(StatType.Kills));
  testAllStats.add(getFakeStatLeaders(StatType.Assists));
  testAllStats.add(getFakeStatLeaders(StatType.Blocks));
  testAllStats.add(getFakeStatLeaders(StatType.Digs));
  return testAllStats;
}

GroupStatLeaders getFakeStatLeaders(StatType statType) {
  List<String> names = [
    "Aldair",
    "Allie",
    "Alma",
    "Jaxon",
    "Jason",
    "Mariah",
    "Lauren",
    "Sara",
    "Cierra",
    "Lydia",
    "Jessie"
  ];
  names.shuffle();
  List<int> counts = [180, 176, 160, 155, 144, 139, 137, 130, 122, 119];
  GroupStatLeaders testStatLeaders = GroupStatLeaders(
      "Aldair's Volleyball Group", "#6424", statType, names, counts);
  return testStatLeaders;
}

class Group {
  String groupName;
  String groupId;
  Group(this.groupName, this.groupId);
}

class GroupService {
  List<Group> testGroups = [];
  GroupService() {
    testGroups.add(Group("Aldair's Volleyball Group", "#6424"));
    testGroups.add(Group("RB", "#4211"));
    testGroups.add(Group("BYU Intermurals", "#9412"));
    testGroups.add(Group("47th Ward", "#8080"));
  }

  List<Group> getGroups() {
    return testGroups;
  }
}

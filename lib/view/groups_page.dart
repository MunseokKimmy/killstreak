import 'package:flutter/material.dart';
import 'package:killstreak/main.dart';
import 'package:killstreak/model/groups_service.dart';

import '../widgets/bottom_navigation.dart';
import 'group_page.dart';

class GroupsPage extends StatefulWidget {
  const GroupsPage({Key? key}) : super(key: key);

  @override
  State<GroupsPage> createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
  TextEditingController editingController = TextEditingController();
  GroupService groupService = GroupService();
  List<Group> groupItemsDuplicate = [];
  List<Group> groups = [];

  @override
  void initState() {
    groups.addAll(groupService.getGroups());
    groups.addAll(groupService.getGroups());
    groups.addAll(groupService.getGroups());
    groups.addAll(groupService.getGroups());
    groups.addAll(groupService.getGroups());
    groupItemsDuplicate.addAll(groupService.getGroups());
    groupItemsDuplicate.addAll(groupService.getGroups());
    groupItemsDuplicate.addAll(groupService.getGroups());
    groupItemsDuplicate.addAll(groupService.getGroups());
    groupItemsDuplicate.addAll(groupService.getGroups());
    super.initState();
  }

  void filterSearchResults(String query) {
    List<Group> dummySearchList = [];
    dummySearchList.addAll(groupItemsDuplicate);
    if (query.isNotEmpty) {
      List<Group> searchedData = [];
      for (var item in dummySearchList) {
        if (item.groupName.toLowerCase().contains(query.toLowerCase())) {
          searchedData.add(item);
        }
      }
      setState(() {
        groups.clear();
        groups.addAll(searchedData);
      });
      return;
    } else {
      setState(() {
        groups.clear();
        groups.addAll(groupItemsDuplicate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Groups'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.info_outline),
          ),
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(
          left: 25,
          right: 25,
          bottom: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: accentColor,
                  iconColor: Colors.white,
                  labelText: "Search Groups",
                  labelStyle: const TextStyle(color: Colors.white),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide:
                        const BorderSide(color: Colors.grey, width: 1.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    gapPadding: 0.0,
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.white, width: 2),
                  ),
                ),
                onChanged: (value) {
                  filterSearchResults(value);
                },
              ),
            ),
            Expanded(
              child: MyGroups(
                groups: groups,
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigation(
        currentPage: 0,
        shortcut: false,
      ),
    );
  }
}

class MyGroups extends StatefulWidget {
  List<Group> groups;
  MyGroups({Key? key, required this.groups}) : super(key: key);

  @override
  State<MyGroups> createState() => _MyGroupsState();
}

class _MyGroupsState extends State<MyGroups> {
  final ScrollController _firstController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: _firstController,
      child: ListView.separated(
        controller: _firstController,
        itemCount: widget.groups.length,
        itemBuilder: (context, index) {
          return GroupSummaryPanel(
            group: widget.groups[index],
          );
        },
        separatorBuilder: (context, index) {
          return const Divider(
            color: Colors.white,
          );
        },
      ),
    );
  }
}

class GroupSummaryPanel extends StatefulWidget {
  Group group;
  GroupSummaryPanel({Key? key, required this.group}) : super(key: key);

  @override
  State<GroupSummaryPanel> createState() => _GroupSummaryPanelState();
}

class _GroupSummaryPanelState extends State<GroupSummaryPanel> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      visualDensity: VisualDensity(vertical: -2),
      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
      title: Text(widget.group.groupName, style: TextStyle(fontSize: 20)),
      subtitle: Text(widget.group.groupId, style: TextStyle(fontSize: 18)),
      leading: const Icon(
        Icons.group_outlined,
        color: Colors.white,
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => GroupPage(
                      group: widget.group,
                    )));
      },
    );
  }
}

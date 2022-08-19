import 'package:flutter/material.dart';
import '../main.dart';
import '../model/groups_service.dart';
import '../widgets/bottom_navigation.dart';

class CreateNewGamePage extends StatelessWidget {
  const CreateNewGamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Start a New Game'),
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
        padding: const EdgeInsets.all(10),
        child: const CreateANewGameForm(),
      ),
      bottomNavigationBar: BottomNavigation(
        currentPage: 0,
        shortcut: false,
      ),
    );
  }
}

class CreateANewGameForm extends StatelessWidget {
  const CreateANewGameForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width * .75,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [GroupDropdown()],
        ),
      ),
    );
  }
}

class GroupDropdown extends StatefulWidget {
  const GroupDropdown({Key? key}) : super(key: key);

  @override
  State<GroupDropdown> createState() => _GroupDropdownState();
}

class _GroupDropdownState extends State<GroupDropdown> {
  GroupService groupService = GroupService();
  List<Group> groups = [];
  String dropdownValue = "";
  @override
  void initState() {
    groups.addAll(groupService.getGroups());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: accentColor),
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: DropdownButtonFormField<String>(
        isExpanded: true,
        value: null,
        icon: const Icon(Icons.keyboard_arrow_down),
        elevation: 16,
        style: const TextStyle(color: Colors.white),
        dropdownColor: accentColor,
        iconEnabledColor: Colors.white,
        iconDisabledColor: Colors.white,
        focusColor: accentColor,
        hint: const Text(
          "Select a Group",
          style: TextStyle(color: Colors.white),
        ),
        items: groups.map<DropdownMenuItem<String>>((Group group) {
          return DropdownMenuItem<String>(
            value: group.groupId,
            child: Text("${group.groupName} - ${group.groupId}"),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            dropdownValue = value!;
          });
        },
      ),
    );
  }
}

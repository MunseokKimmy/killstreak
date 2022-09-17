import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:killstreak/model/dtos/game.dto.dart';
import 'package:killstreak/model/ongoing_game_service.dart';
import 'package:killstreak/view/game/game_page.dart';
import '../../main.dart';
import '../../model/groups_service.dart';
import '../../widgets/bottom_navigation.dart';

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
        child: MyForm(),
      ),
      bottomNavigationBar: BottomNavigation(
        currentPage: 0,
        shortcut: false,
      ),
    );
  }
}

class MyForm extends StatefulWidget {
  MyForm({Key? key}) : super(key: key);

  @override
  State<MyForm> createState() => MyFormState();
}

class MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  static List<String> teamOneList = [""];
  static List<String> teamTwoList = [""];
  TextEditingController _nameController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  List<Widget> _getTeamOnePlayers() {
    List<Widget> friendsTextFieldsList = [];
    for (int i = 0; i < teamOneList.length; i++) {
      friendsTextFieldsList.add(Flexible(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            children: [
              Expanded(child: FriendTextFields(index: i, onTeamOne: true)),
              SizedBox(
                width: 10,
              ),
              // we need add button at last friends row only
              _addRemoveButton(i == teamOneList.length - 1, i, true),
            ],
          ),
        ),
      ));
    }
    return friendsTextFieldsList;
  }

  List<Widget> _getTeamTwoPlayers() {
    List<Widget> friendsTextFieldsList = [];
    for (int i = 0; i < teamTwoList.length; i++) {
      friendsTextFieldsList.add(Flexible(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            children: [
              Expanded(child: FriendTextFields(index: i, onTeamOne: false)),
              SizedBox(
                width: 10,
              ),
              // we need add button at last friends row only
              _addRemoveButton(i == teamTwoList.length - 1, i, false),
            ],
          ),
        ),
      ));
    }
    return friendsTextFieldsList;
  }

  Widget _addRemoveButton(bool add, int index, bool teamOne) {
    return InkWell(
      onTap: () {
        if (add) {
          // add new text-fields at the top of all friends textfields
          teamOne ? teamOneList.insert(0, "") : teamTwoList.insert(0, "");
        } else {
          teamOne ? teamOneList.removeAt(index) : teamTwoList.removeAt(index);
        }
        setState(() {});
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: (add) ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          (add) ? Icons.add : Icons.remove,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // name textfield
              Padding(
                padding: const EdgeInsets.only(top: 25, right: 32.0),
                child: TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name of the Game',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  validator: (v) {
                    if (v!.trim().isEmpty) {
                      return 'Please enter something';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 32.0),
                child: TextFormField(
                  controller: _locationController,
                  decoration: const InputDecoration(
                    labelText: 'Location of the Game',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  validator: (v) {
                    if (v!.trim().isEmpty) {
                      return 'Please enter something';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Players',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          "Team 1 Players",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 16),
                        ),
                        ..._getTeamOnePlayers(),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          "Team 2 Players",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 16),
                        ),
                        ..._getTeamTwoPlayers(),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 40,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    GameShort game = await OngoingGameService().createANewGame(
                        _nameController.text,
                        _locationController.text,
                        teamOneList,
                        teamTwoList);
                    final user = FirebaseAuth.instance.currentUser!;
                    OngoingGameService()
                        .addGameToAccount(user.uid, game.gameId);
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GamePage(game: game),
                      ),
                    );
                  }
                },
                child: Text('Submit'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith((states) {
                    // If the button is pressed, return green, otherwise blue
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.green;
                    }
                    return Colors.greenAccent;
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FriendTextFields extends StatefulWidget {
  final int index;
  bool onTeamOne;
  FriendTextFields({Key? key, required this.index, required this.onTeamOne});
  @override
  _FriendTextFieldsState createState() => _FriendTextFieldsState();
}

class _FriendTextFieldsState extends State<FriendTextFields> {
  TextEditingController _nameController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _nameController.text = widget.onTeamOne
          ? MyFormState.teamOneList[widget.index]
          : MyFormState.teamTwoList[widget.index];
    });
    return TextFormField(
      controller: _nameController,
      // save text field data in friends list at index
      // whenever text field value changes
      onChanged: (v) => {
        if (widget.onTeamOne)
          {
            MyFormState.teamOneList[widget.index] = v,
          }
        else
          {
            MyFormState.teamTwoList[widget.index] = v,
          }
      },
      decoration: const InputDecoration(
        labelText: 'Player\'s name',
        labelStyle: TextStyle(color: Colors.white),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
      validator: (v) {
        if (v!.trim().isEmpty) return 'Please enter something';
        return null;
      },
    );
  }
}

// class GroupDropdown extends StatefulWidget {
//   const GroupDropdown({Key? key}) : super(key: key);

//   @override
//   State<GroupDropdown> createState() => _GroupDropdownState();
// }

// class _GroupDropdownState extends State<GroupDropdown> {
//   GroupService groupService = GroupService();
//   List<Group> groups = [];
//   String dropdownValue = "";
//   @override
//   void initState() {
//     groups.addAll(groupService.getGroups());
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(color: accentColor),
//       padding: const EdgeInsets.only(left: 10.0, right: 10.0),
//       child: DropdownButtonFormField<String>(
//         isExpanded: true,
//         value: null,
//         icon: const Icon(Icons.keyboard_arrow_down),
//         elevation: 16,
//         style: const TextStyle(color: Colors.white),
//         dropdownColor: accentColor,
//         iconEnabledColor: Colors.white,
//         iconDisabledColor: Colors.white,
//         focusColor: accentColor,
//         hint: const Text(
//           "Select a Group",
//           style: TextStyle(color: Colors.white),
//         ),
//         items: groups.map<DropdownMenuItem<String>>((Group group) {
//           return DropdownMenuItem<String>(
//             value: group.groupId,
//             child: Text("${group.groupName} - ${group.groupId}"),
//           );
//         }).toList(),
//         onChanged: (value) {
//           setState(() {
//             dropdownValue = value!;
//           });
//         },
//       ),
//     );
//   }
// }

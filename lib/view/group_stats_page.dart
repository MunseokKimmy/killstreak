//Use SQL Queries to get:
// Group leader in aces, kills, digs, blocks, assists
// Games played
// All other players' aces/kills/etc... in paid version

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/groups_service.dart';
import '../widgets/bottom_navigation.dart';

class GroupsStatsPage extends StatelessWidget {
  Group group;
  GroupsStatsPage({Key? key, required this.group}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GroupService groupService = GroupService();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Group Stats'),
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
              Text(
                group.groupName,
                style: const TextStyle(fontSize: 20),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 20.0),
                child: Text(DateFormat("MMMM dd yyyy").format(DateTime.now())),
              ),
              GroupStatSummary(
                groupStatsSummary: groupService.getSummary(),
              ),
            ]),
      ),
      bottomNavigationBar: BottomNavigation(currentPage: 0, shortcut: false),
    );
  }
}

class GroupStatSummary extends StatefulWidget {
  GroupStatsSummary groupStatsSummary;
  GroupStatSummary({Key? key, required this.groupStatsSummary})
      : super(key: key);

  @override
  State<GroupStatSummary> createState() => _GroupStatSummaryState();
}

class _GroupStatSummaryState extends State<GroupStatSummary> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: const Text(
            "Games Played",
            style: TextStyle(fontSize: 20),
          ),
          trailing: Text(widget.groupStatsSummary.gamesPlayed.toString(),
              style: const TextStyle(fontSize: 20)),
        ),
        Divider(
          color: Colors.white,
          thickness: 1,
        ),
        ListTile(
          leading: Image.asset(
            'resources/images/ServiceIcon.png',
            height: 40,
            width: 40,
          ),
          title: const Text("Ace", style: TextStyle(fontSize: 20)),
          trailing: Text(
              widget.groupStatsSummary.topAceName +
                  " - " +
                  widget.groupStatsSummary.topAceAmount.toString(),
              style: const TextStyle(fontSize: 20)),
        ),
        Divider(
          color: Colors.white,
          thickness: 1,
        ),
        ListTile(
          title: Text(
            widget.groupStatsSummary.topKillName,
            style: TextStyle(fontSize: 20),
          ),
          subtitle: const Text("Kill", style: TextStyle(fontSize: 20)),
          trailing: Text(widget.groupStatsSummary.topKillAmount.toString(),
              style: const TextStyle(fontSize: 20)),
        ),
        Divider(
          color: Colors.white,
          thickness: 1,
        ),
        ListTile(
          title: const Text("Assist", style: TextStyle(fontSize: 20)),
          trailing: Text(
              widget.groupStatsSummary.topAssistName +
                  " - " +
                  widget.groupStatsSummary.topAssistAmount.toString(),
              style: const TextStyle(fontSize: 20)),
        ),
        Divider(
          color: Colors.white,
          thickness: 1,
        ),
        ListTile(
          title: const Text("Digs", style: TextStyle(fontSize: 20)),
          subtitle: Text(
            widget.groupStatsSummary.topDigName,
            style: TextStyle(fontSize: 20),
          ),
          trailing: Text(widget.groupStatsSummary.topDigAmount.toString(),
              style: const TextStyle(fontSize: 20)),
        ),
        Divider(
          color: Colors.white,
          thickness: 1,
        ),
        ListTile(
          title: Text("Blocks - " + widget.groupStatsSummary.topBlockName,
              style: TextStyle(fontSize: 20)),
          trailing: Text(widget.groupStatsSummary.topBlockAmount.toString(),
              style: const TextStyle(fontSize: 20)),
        ),
      ],
    );
  }
}

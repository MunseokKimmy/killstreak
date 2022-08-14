//Use SQL Queries to get:
// Group leader in aces, kills, digs, blocks, assists
// Games played
// All other players' aces/kills/etc... in paid version

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:killstreak/utils/string.utils.dart';
import 'package:killstreak/view/profile_page.dart';

import '../main.dart';
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
        margin: const EdgeInsets.all(25),
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
              StatLeaderCarousel(),
              // GroupStatSummary(
              //   groupStatsSummary: groupService.getSummary(),
              // ),
              Text("asdfasdf"),
            ]),
      ),
      bottomNavigationBar: BottomNavigation(currentPage: 0, shortcut: false),
    );
  }
}

class StatLeaderCarousel extends StatefulWidget {
  StatLeaderCarousel({Key? key}) : super(key: key);
  @override
  State<StatLeaderCarousel> createState() => _StatLeaderCarouselState();
}

class _StatLeaderCarouselState extends State<StatLeaderCarousel> {
  int _currentIndex = 0;
  List cardList = [];
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    GroupService groupService = GroupService();
    GroupStatsSummary statSummary = groupService.getSummary();
    cardList = [
      StatLeaderCard(
        statLeaderName: statSummary.topAceName,
        statLeaderUsername: statSummary.topAceUserName,
        statName: "Ace",
        statLeaderCount: statSummary.topAceAmount,
        statImage: Image.asset(
          'resources/images/ServiceColor.png',
          height: 45,
        ),
      ),
      StatLeaderCard(
        statLeaderName: statSummary.topKillName,
        statLeaderUsername: statSummary.topKillUserName,
        statName: "Kills",
        statLeaderCount: statSummary.topKillAmount,
        statImage: Image.asset(
          'resources/images/AttackColor.png',
          height: 45,
        ),
      ),
      StatLeaderCard(
        statLeaderName: statSummary.topAssistName,
        statLeaderUsername: statSummary.topAssistUserName,
        statName: "Assists",
        statLeaderCount: statSummary.topAssistAmount,
        statImage: Image.asset(
          'resources/images/AssistColor.png',
          height: 45,
        ),
      ),
      StatLeaderCard(
        statLeaderName: statSummary.topBlockName,
        statLeaderUsername: statSummary.topBlockUserName,
        statName: "Blocks",
        statLeaderCount: statSummary.topBlockAmount,
        statImage: Image.asset(
          'resources/images/BlockColor.png',
          height: 45,
        ),
      ),
      StatLeaderCard(
        statLeaderName: statSummary.topDigName,
        statLeaderUsername: statSummary.topDigUserName,
        statName: "Digs",
        statLeaderCount: statSummary.topDigAmount,
        statImage: Image.asset(
          'resources/images/DigColor.png',
          height: 45,
        ),
      ),
    ];
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            enlargeCenterPage: true,
            enlargeStrategy: CenterPageEnlargeStrategy.scale,
            viewportFraction: .33,
            height: MediaQuery.of(context).size.height * .25,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 10),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            pauseAutoPlayOnTouch: true,
            aspectRatio: 16 / 5,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          items: cardList.map((card) {
            return Builder(builder: (BuildContext context) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                child: card,
              );
            });
          }).toList(),
        ),
      ],
    );
  }
}

class StatLeaderCard extends StatefulWidget {
  String statLeaderName;
  String statLeaderUsername;
  String statName;
  int statLeaderCount;
  Image statImage;
  StatLeaderCard(
      {Key? key,
      required this.statLeaderName,
      required this.statLeaderUsername,
      required this.statLeaderCount,
      required this.statImage,
      required this.statName})
      : super(key: key);

  @override
  State<StatLeaderCard> createState() => _StatLeaderCardState();
}

class _StatLeaderCardState extends State<StatLeaderCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ProfilePage()));
        },
        child: Container(
          padding: EdgeInsets.all(10.0),
          margin: EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: lightColor,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                blurRadius: 2.0,
                spreadRadius: 0.0,
                offset: Offset(2.0, 2.0), // shadow direction: bottom right
              )
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: widget.statImage, flex: 3),
              Expanded(
                flex: 1,
                child: Text(
                  widget.statName,
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  widget.statLeaderName,
                  style: TextStyle(
                      fontSize: 20, color: Color.fromARGB(255, 208, 208, 208)),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  widget.statLeaderCount.toString(),
                  style: TextStyle(
                      color: Colors.yellow,
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                ),
              ),
            ],
          ),
        ));
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

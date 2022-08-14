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
      body: GroupStatsContent(
        group: group,
      ),
      bottomNavigationBar: BottomNavigation(currentPage: 0, shortcut: false),
    );
  }
}

class GroupStatsContent extends StatefulWidget {
  Group group;
  GroupStatsContent({Key? key, required this.group}) : super(key: key);

  @override
  State<GroupStatsContent> createState() => _GroupStatsContentState();
}

class _GroupStatsContentState extends State<GroupStatsContent> {
  int _currentIndex = 0;
  final ScrollController _firstController = ScrollController();

  @override
  Widget build(BuildContext context) {
    GroupService groupService = GroupService();
    List<GroupStatLeaders> leaders = groupService.getStatLeaders;
    List cardList = buildStatLeaderCards(groupService);

    return Container(
      margin: const EdgeInsets.all(25),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.group.groupName,
              style: const TextStyle(fontSize: 20),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 20.0),
              child: Text(DateFormat("MMMM dd yyyy").format(DateTime.now())),
            ),
            StatLeaderCarousel(
              groupStatLeaders: groupService.statLeaders,
              cardList: cardList,
              onIndexChanged: (int index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            Text(
              cardList[_currentIndex].getStatName,
              style: TextStyle(fontSize: 24),
            ),
            Expanded(
              child: SizedBox(
                  height: MediaQuery.of(context).size.height / 2,
                  child: Scrollbar(
                    thumbVisibility: true,
                    controller: _firstController,
                    child: ListView.separated(
                      controller: _firstController,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Color.fromARGB(255, 228, 137, 1),
                            child: Text(
                              getInitials(
                                  leaders[_currentIndex].topNames[index]),
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                          ),
                          title: Text(
                            leaders.isNotEmpty
                                ? leaders[_currentIndex].topNames[index]
                                : '',
                            style: TextStyle(fontSize: 20),
                          ),
                          trailing: Text(
                              leaders[_currentIndex]
                                  .topCounts[index]
                                  .toString(),
                              style: const TextStyle(
                                  color: Colors.green,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Courier New")),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider(
                          color: Colors.white,
                        );
                      },
                    ),
                  )),
            ),
          ]),
    );
  }
}

class StatLeaderCarousel extends StatefulWidget {
  List<GroupStatLeaders> groupStatLeaders;
  List cardList;
  final Function(int) onIndexChanged;
  StatLeaderCarousel(
      {Key? key,
      required this.groupStatLeaders,
      required this.cardList,
      required this.onIndexChanged})
      : super(key: key);
  @override
  State<StatLeaderCarousel> createState() => _StatLeaderCarouselState();
}

class _StatLeaderCarouselState extends State<StatLeaderCarousel> {
  int _currentIndex = 0;

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
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
                widget.onIndexChanged(index);
              });
            },
          ),
          items: widget.cardList.map((card) {
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
  get getStatLeaderName => statLeaderName;

  set setStatLeaderName(statLeaderName) => this.statLeaderName = statLeaderName;

  get getStatLeaderUsername => statLeaderUsername;

  set setStatLeaderUsername(statLeaderUsername) =>
      this.statLeaderUsername = statLeaderUsername;

  get getStatName => statName;

  set setStatName(statName) => this.statName = statName;

  get getStatLeaderCount => statLeaderCount;

  set setStatLeaderCount(statLeaderCount) =>
      this.statLeaderCount = statLeaderCount;

  get getStatImage => statImage;

  set setStatImage(statImage) => this.statImage = statImage;
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
              Expanded(child: widget.statImage, flex: 1),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        widget.statName,
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ),
                    Text(
                      widget.statLeaderName,
                      style: const TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 208, 208, 208)),
                    ),
                    Expanded(
                      child: Text(
                        widget.statLeaderCount.toString(),
                        style: const TextStyle(
                            color: Colors.yellow,
                            fontFamily: "Courier New",
                            fontWeight: FontWeight.bold,
                            fontSize: 26),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

List<StatLeaderCard> buildStatLeaderCards(GroupService groupService) {
  GroupStatsSummary statSummary = groupService.getSummary();
  List<StatLeaderCard> cards = [
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
  return cards;
}

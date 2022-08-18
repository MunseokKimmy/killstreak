import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:killstreak/view/create_a_new_game_page.dart';
import 'package:killstreak/view/game_page.dart';
import 'package:killstreak/view/my_stats_page.dart';
import '../main.dart';
import '../model/game_service.dart';
import '../model/groups_service.dart';
import '../widgets/bottom_navigation.dart';
import 'group_stats_page.dart';

class GroupPage extends StatelessWidget {
  Group group;
  GroupPage({Key? key, required this.group}) : super(key: key);

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
        margin: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              group.groupName,
              style: TextStyle(fontSize: 24),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10.0),
              child: Text(DateFormat("MMMM dd yyyy").format(DateTime.now())),
            ),
            SizedBox(
              child: Card(
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GroupsStatsPage(group: group),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                            top: 10.0, left: 10.0, right: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text("Scorer", style: TextStyle(fontSize: 16)),
                              ],
                            )),
                            Expanded(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text("Assists", style: TextStyle(fontSize: 16)),
                              ],
                            )),
                            Expanded(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text("Defender",
                                    style: TextStyle(fontSize: 16)),
                              ],
                            )),
                          ],
                        ),
                      ),
                      const Divider(
                        color: Colors.white,
                        thickness: 2,
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding:
                                                EdgeInsets.only(bottom: 5.0),
                                            child: Text("Connor",
                                                style: TextStyle(fontSize: 20)),
                                          )
                                        ]),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: const [
                                        Text("A",
                                            style: TextStyle(fontSize: 20)),
                                        Text("K",
                                            style: TextStyle(fontSize: 20)),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: const [
                                        Text("5",
                                            style: TextStyle(fontSize: 20)),
                                        Text("7",
                                            style: TextStyle(fontSize: 20)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(bottom: 5.0),
                                          child: Text("Cierra",
                                              style: TextStyle(fontSize: 20)),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("As",
                                            style: TextStyle(fontSize: 20)),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("8",
                                            style: TextStyle(fontSize: 20))
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding:
                                                EdgeInsets.only(bottom: 5.0),
                                            child: Text("Alma",
                                                style: TextStyle(fontSize: 20)),
                                          )
                                        ]),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: const [
                                        Text("D",
                                            style: TextStyle(fontSize: 20)),
                                        Text("B",
                                            style: TextStyle(fontSize: 20)),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: const [
                                        Text("11",
                                            style: TextStyle(fontSize: 20)),
                                        Text("6",
                                            style: TextStyle(fontSize: 20)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 0.0),
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.bar_chart,
                                color: Colors.white,
                              ),
                              Text(
                                "View All Group Stats",
                                style: TextStyle(fontSize: 17),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10.0),
              child: const Text(
                "Recent Games",
                style: TextStyle(fontSize: 24),
              ),
            ),
            Expanded(child: RecentGroupGames())
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Start a New Game"),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CreateNewGamePage()));
        },
        backgroundColor: lightColor,
        icon: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigation(
        currentPage: 0,
        shortcut: false,
      ),
    );
  }
}

class RecentGroupGames extends StatefulWidget {
  const RecentGroupGames({Key? key}) : super(key: key);

  @override
  State<RecentGroupGames> createState() => _RecentGroupGamesState();
}

class _RecentGroupGamesState extends State<RecentGroupGames> {
  final ScrollController _firstController = ScrollController();
  @override
  Widget build(BuildContext context) {
    GameService gameService = GameService();
    var games = gameService.getGameShorts() +
        gameService.getGameShorts() +
        gameService.getGameShorts() +
        gameService.getGameShorts();
    return Scrollbar(
      thumbVisibility: true,
      controller: _firstController,
      child: ListView.separated(
        controller: _firstController,
        itemCount: 20,
        itemBuilder: (context, index) {
          return GroupGame(game: games[index]);
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

class GroupGame extends StatefulWidget {
  GameShort game;
  GroupGame({Key? key, required this.game}) : super(key: key);

  @override
  State<GroupGame> createState() => _GroupGameState();
}

class _GroupGameState extends State<GroupGame> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => GamePage(
                      game: widget.game,
                    )));
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.game.gameName,
                  style: TextStyle(
                      fontSize: 16,
                      color: widget.game.gameCompleted
                          ? Colors.white
                          : Colors.yellow),
                ),
                Text(
                  widget.game.gameCompleted
                      ? "(Completed ${widget.game.gameDate})"
                      : "(Ongoing)",
                  style: TextStyle(
                      color: widget.game.gameCompleted
                          ? Color.fromARGB(255, 210, 210, 210)
                          : Colors.yellow,
                      fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: widget.game.onTeamOne ? lightColor : null,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.game.teamOneScore.toString(),
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Courier New",
                      color: (widget.game.gameCompleted &&
                              (widget.game.teamOneScore >
                                  widget.game.teamTwoScore))
                          ? Colors.yellow
                          : null,
                    ),
                  ),
                  Text(
                    widget.game.teamOneName,
                    style: TextStyle(
                      fontSize: 16,
                      color: (widget.game.gameCompleted &&
                              (widget.game.teamOneScore >
                                  widget.game.teamTwoScore))
                          ? Colors.yellow
                          : null,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text("-"),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: !widget.game.onTeamOne ? lightColor : null,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.game.teamTwoScore.toString(),
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Courier New",
                      color: (widget.game.gameCompleted &&
                              (widget.game.teamOneScore <
                                  widget.game.teamTwoScore))
                          ? Colors.yellow
                          : null,
                    ),
                  ),
                  Text(
                    widget.game.teamTwoName,
                    style: TextStyle(
                      fontSize: 16,
                      color: (widget.game.gameCompleted &&
                              (widget.game.teamOneScore <
                                  widget.game.teamTwoScore))
                          ? Colors.yellow
                          : null,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

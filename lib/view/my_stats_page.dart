import 'package:flutter/material.dart';
import 'package:killstreak/model/game_service.dart';

class MyStatsPage extends StatelessWidget {
  const MyStatsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('My Stats'),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () {
                debugPrint('stats');
              },
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
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: double.infinity,
              ),
              const LifeTimeTotals(),
              Container(
                margin: const EdgeInsets.only(top: 20.0),
                child: const Text("Recent Games"),
              ),
              const RecentGames(),
            ],
          ),
        ));
  }
}

class LifeTimeTotals extends StatelessWidget {
  const LifeTimeTotals({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(15.0),
      ),
      width: MediaQuery.of(context).size.width / 1.25,
      margin: const EdgeInsets.only(top: 20.0),
      padding: const EdgeInsets.all(15.0),
      child: ExpansionTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Icon(Icons.stacked_bar_chart_sharp,
                    color: Colors.white, size: 48),
                Text("Lifetime Totals"),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Ace: "),
                Text("Kills: "),
                Text("Assists: "),
                Text("Blocks: "),
                Text("Digs: "),
              ],
            ),
            Column(
              children: const [
                Text("2"),
                Text("2"),
                Text("2"),
                Text("2"),
                Text("2"),
              ],
            )
          ],
        ),
        collapsedIconColor: Colors.white,
        iconColor: Colors.white,
        collapsedTextColor: Colors.white,
        textColor: Colors.white,
        children: [
          Container(
            margin: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("Attack Errors: "),
                        Text("Service Errors: "),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("2"),
                        Text("2"),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Column(
                      children: const [
                        Text("Assist Errors: "),
                        Text("Block Errors: "),
                      ],
                    ),
                    Column(
                      children: const [
                        Text("2"),
                        Text("2"),
                      ],
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class RecentGames extends StatefulWidget {
  const RecentGames({Key? key}) : super(key: key);

  @override
  State<RecentGames> createState() => _RecentGamesState();
}

class _RecentGamesState extends State<RecentGames> {
  @override
  Widget build(BuildContext context) {
    GameService gameService = GameService();
    var games = gameService.getGameShorts();
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return GameSummaryExpansionPanel(game: games[index]);
        },
      ),
    );
  }
}

class GameSummaryExpansionPanel extends StatefulWidget {
  final GameShort game;
  const GameSummaryExpansionPanel({Key? key, required this.game})
      : super(key: key);

  @override
  State<GameSummaryExpansionPanel> createState() =>
      _GameSummaryExpansionPanelState();
}

class _GameSummaryExpansionPanelState extends State<GameSummaryExpansionPanel> {
  bool _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Center(
        child: Container(
          margin: const EdgeInsets.all(10),
          color: Colors.green,
          child: ExpansionPanelList(
            animationDuration: const Duration(milliseconds: 500),
            children: [
              ExpansionPanel(
                headerBuilder: (context, isExpanded) {
                  return ListTile(
                    title: Text(
                      widget.game.gameName,
                    ),
                  );
                },
                body: ListTile(title: Text(widget.game.groupName)),
                isExpanded: _expanded,
                canTapOnHeader: true,
              ),
            ],
            dividerColor: Colors.grey,
            expansionCallback: (panelIndex, isExpanded) {
              _expanded = !_expanded;
              setState(() {});
            },
          ),
        ),
      ),
    ]);
  }
}

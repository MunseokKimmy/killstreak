import 'package:flutter/material.dart';
import 'package:killstreak/model/game_service.dart';
import 'package:killstreak/widgets/bottom_navigation.dart';

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
      body: Container(
        margin: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(10.0),
              child: const Text(
                "Recent Games",
                style: TextStyle(fontSize: 20),
              ),
            ),
            const Expanded(
              child: RecentGames(),
            ),
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

class RecentGames extends StatefulWidget {
  const RecentGames({Key? key}) : super(key: key);

  @override
  State<RecentGames> createState() => _RecentGamesState();
}

class _RecentGamesState extends State<RecentGames> {
  @override
  Widget build(BuildContext context) {
    GameService gameService = GameService();
    var games = gameService.getGameShorts() +
        gameService.getGameShorts() +
        gameService.getGameShorts() +
        gameService.getGameShorts();
    return ListView.separated(
      itemCount: 20,
      itemBuilder: (context, index) {
        return GameSummaryExpansionPanel(game: games[index]);
      },
      separatorBuilder: (context, index) {
        return const Divider(
          color: Colors.white,
        );
      },
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
        child: ExpansionPanelList(
          animationDuration: const Duration(milliseconds: 500),
          children: [
            ExpansionPanel(
              hasIcon: false,
              headerBuilder: (context, isExpanded) {
                return RecentGameTileHeader(game: widget.game);
              },
              body: ListTile(title: Text(widget.game.groupName)),
              isExpanded: _expanded,
              canTapOnHeader: true,
            )
          ],
          dividerColor: Colors.white,
          expansionCallback: (panelIndex, isExpanded) {
            _expanded = !_expanded;
            setState(() {});
          },
        ),
      ),
    ]);
  }
}

class RecentGameTileHeader extends StatefulWidget {
  final GameShort game;

  const RecentGameTileHeader({Key? key, required this.game}) : super(key: key);

  @override
  State<RecentGameTileHeader> createState() => _RecentGameTileHeaderState();
}

class _RecentGameTileHeaderState extends State<RecentGameTileHeader> {
  @override
  Widget build(BuildContext context) {
    return Row(
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
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              Text(
                widget.game.groupName,
                style: const TextStyle(
                    color: Color.fromARGB(255, 210, 210, 210),
                    fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            color: widget.game.onTeamOne
                ? const Color.fromRGBO(8, 51, 88, 1)
                : null,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.game.teamOneScore.toString(),
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Courier New",
                  ),
                ),
                Text(
                  widget.game.teamOneName,
                  style: const TextStyle(
                    fontSize: 16,
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
            color: !widget.game.onTeamOne
                ? const Color.fromRGBO(8, 51, 88, 1)
                : null,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.game.teamTwoScore.toString(),
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Courier New",
                  ),
                ),
                Text(
                  widget.game.teamTwoName,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
    ;
  }
}
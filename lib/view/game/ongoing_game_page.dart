import 'package:flutter/material.dart';
import 'package:killstreak/main.dart';
import 'package:killstreak/model/game_service.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OngoingGameWidget extends StatefulWidget {
  GameShort game;
  final _controller = PageController();
  OngoingGameWidget({Key? key, required this.game}) : super(key: key);

  @override
  State<OngoingGameWidget> createState() => _OngoingGameWidgetState();
}

class _OngoingGameWidgetState extends State<OngoingGameWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Expanded(
            child: PageView(
              controller: widget._controller,
              scrollDirection: Axis.horizontal,
              children: [
                //GameScoreCard(game: widget.game),
                //GameScoreCard(game: widget.game),
                OngoingGamePage1(game: widget.game),
                OngoingGamePage1(game: widget.game),
                OngoingGamePage1(game: widget.game),
              ],
            ),
          ),
          SmoothPageIndicator(
            controller: widget._controller,
            count: 3,
            effect: const SwapEffect(
              activeDotColor: Colors.yellow,
              spacing: 14,
              dotHeight: 7,
              dotWidth: 14,
            ),
          )
        ],
      ),
    );
  }
}

class OngoingGamePage1 extends StatefulWidget {
  GameShort game;
  OngoingGamePage1({Key? key, required this.game}) : super(key: key);

  @override
  State<OngoingGamePage1> createState() => _OngoingGamePage1State();
}

class _OngoingGamePage1State extends State<OngoingGamePage1> {
  @override
  Widget build(BuildContext context) {
    return GameScoreCard(game: widget.game);
  }
}

class OngoingGamePage2 extends StatefulWidget {
  OngoingGamePage2({Key? key}) : super(key: key);

  @override
  State<OngoingGamePage2> createState() => _OngoingGamePage2State();
}

class _OngoingGamePage2State extends State<OngoingGamePage2> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class GameScoreCard extends StatefulWidget {
  GameShort game;
  GameScoreCard({Key? key, required this.game}) : super(key: key);

  @override
  State<GameScoreCard> createState() => _GameScoreCardState();
}

class _GameScoreCardState extends State<GameScoreCard> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height * .3),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                widget.game.teamOneName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  widget.game.teamOneScore.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Courier New",
                  ),
                ),
              ),
              Visibility(
                visible: widget.game.teamOneServing,
                child: const Icon(
                  Icons.sports_volleyball,
                  color: Colors.yellow,
                  size: 24,
                ),
              ),
            ],
          ),
          Column(
            children: [
              const Text(
                "",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(color: baseColor),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Text(
                  "-",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Courier New",
                  ),
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                widget.game.teamTwoName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  widget.game.teamTwoScore.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Courier New",
                  ),
                ),
              ),
              Visibility(
                visible: !widget.game.teamOneServing,
                child: const Icon(
                  Icons.sports_volleyball,
                  color: Colors.yellow,
                  size: 24,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

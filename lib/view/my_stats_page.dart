import 'package:flutter/material.dart';

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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              LifeTimeTotals(),
              RecentGames(),
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
          ListTile(title: Text("asdfsad")),
        ],
      ),
    );
  }
}

class RecentGames extends StatelessWidget {
  const RecentGames({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

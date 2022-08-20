import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:killstreak/model/stats_service.dart';

import '../widgets/bottom_navigation.dart';

const Color color = Color(0xff001f3f);

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key, this.playerId}) : super(key: key);
  final int? playerId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
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
          children: [
            const LifeTimeTotals(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigation(
        currentPage: 2,
        shortcut: true,
      ),
    );
  }
}

class LifeTimeTotals extends StatelessWidget {
  const LifeTimeTotals({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(5.0),
      ),
      width: MediaQuery.of(context).size.width / 1.15,
      margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
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
            margin: const EdgeInsets.only(top: 10, right: 10, left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("Attack Errors: "),
                        Text("Service Errors: "),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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

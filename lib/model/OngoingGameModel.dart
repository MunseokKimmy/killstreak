import 'dart:async';
import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:killstreak/model/dtos/game.dto.dart';
import 'package:killstreak/model/stats_service.dart';

class OngoingGameModel extends ChangeNotifier {
  Game? _game;
  List<PlayerGameStats> _playerGameStats = [];
  final _db = FirebaseDatabase.instance.ref();

  static const PLAYERS_PATH = 'players';
  static const GAME_PATH = '/games/game-';

  late StreamSubscription<DatabaseEvent> _gameStream;

  Game? get game => _game;
  List<PlayerGameStats> get stats => _playerGameStats;

  OngoingGameModel() {
    _listenToGame();
  }

  _listenToGame() {
    _gameStream = _db.child(GAME_PATH).onValue.listen((event) {
      final String parsed = json.encode(event.snapshot.value);
      Map<String, dynamic> map = jsonDecode(parsed);
      _game = Game.fromRTDB(map);
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _gameStream.cancel();
    super.dispose();
  }
}

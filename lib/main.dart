import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gameoflife/board.dart';

import 'gameOfLive.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game of life',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Game of life'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _game = GameOfLife();

  Size _cellSize;
  @override
  void initState() {
    super.initState();
    //Fullscreen display (still including appbar)
    SystemChrome.setEnabledSystemUIOverlays([]);
    _game.resetWorld();
  }

  void _toggleGame() {
    setState(() {
      _game.toggleGame();
    });
  }

  @override
  Widget build(BuildContext contGameOfLifeext) {
    final screenSize = MediaQuery.of(context).size;
    _cellSize = Size(
        screenSize.width / GameOfLife.rowLength,
        (screenSize.height - kToolbarHeight) /
            (GameOfLife.worldSize / GameOfLife.rowLength));

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: StreamBuilder<double>(
        stream: _game.stateController.stream,
        builder: (context, snapshot) {
          return GameBoard(
            GameOfLife.cellMargin,
            _game.world,
            GameOfLife.rowLength,
            cellSize: _cellSize,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleGame,
        tooltip: 'Start/Stop',
        child: _game.running ? Icon(Icons.pause) : Icon(Icons.play_arrow),
      ),
    );
  }
}

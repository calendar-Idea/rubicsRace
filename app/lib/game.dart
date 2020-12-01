import 'dart:collection';
import 'dart:io';
import 'package:app/alerts/DialogCreator.dart';

import 'board.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math';

class Rumikub extends StatefulWidget {
  final name;
  final sendWin;
  final playing;

  Rumikub({
    @required this.name,
    @required this.sendWin,
    @required this.playing,
  }) {}

  @override
  _RumikubState createState() => _RumikubState();
}

class _RumikubState extends State<Rumikub> {
  int tileQuantity;
  int colorQuantity;
  int tableSize;
  int rowSize;
  int colSize;
  List board;
  List goalBoard;
  List colorRange = ['Red', 'Green', 'Yellow', 'Blue', 'Orange', 'White'];
  int currentEmpty;
  List<int> emptyTile;
  @override
  void initState() {
    super.initState();
    tableSize = 5;
    tileQuantity = ((tableSize * tableSize) - 1);
    if (checkIfValid()) {
      board = initializeBoard(tableSize, true);
      goalBoard = initializeBoard(tableSize - 2, false);
      emptyTile = new List(2);
      emptyTile[0] = tableSize - 1;
      emptyTile[1] = tableSize - 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    print("Rerender board");
    if (checkIfDone() && this.widget.playing) {
      //send to server
      widget.sendWin();
      DialogCreator.showWinnerDialog(context);
      print("Doneeeee");
      //render winScreen and reconnect
    }
    return Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Board(
                key: UniqueKey(),
                board: this.board,
                tableSize: tableSize,
                handleMove: handleMove)
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Board(
              key: UniqueKey(),
              board: this.goalBoard,
              tableSize: tableSize,
              handleMove: handleMove,
            )
          ])
        ]));
  }

  void handleMove(int x, int y) {
    if ((x + 1) == emptyTile[0] && y == emptyTile[1]) {
      //setstate
      makeMove(x, y);
    } else if ((x - 1) == emptyTile[0] && y == emptyTile[1]) {
      makeMove(x, y);
      //setstate
    } else if ((y - 1) == emptyTile[1] && x == emptyTile[0]) {
      makeMove(x, y);
    } else if ((y + 1) == emptyTile[1] && x == emptyTile[0]) {
      makeMove(x, y);
    } else {
      //invalid move
    }
  }

  void makeMove(int x, int y) {
    List tempBoard = board;
    List tempEmpty = emptyTile;
    String temp = board[x][y];
    tempBoard[x][y] = null;
    tempBoard[emptyTile[0]][emptyTile[1]] = temp;
    tempEmpty[0] = x;
    tempEmpty[1] = y;
    emptyTile = tempEmpty;
    this.setState(() {
      board = tempBoard;
    });
    //duplicates instead of rerendering
  }

  bool checkIfValid() {
    if (tableSize % 2 == 0 && tileQuantity % 6 != 0) {
      return false;
      //even fails to load
    } else {
      colorQuantity = (tileQuantity / 6).round();
      return true;
    }
  }

  List initializeBoard(int tableSize, bool emptyTile) {
    int counter = 0;
    if (!emptyTile) {
      counter = -1;
    }

    List board = List.generate(tableSize, (i) => List(tableSize));
    HashMap<String, int> color = new HashMap();
    for (String i in colorRange) {
      color[i] = colorQuantity;
    }
    var rng = new Random();
    for (int i = 0; i < board.length; i++) {
      for (int j = 0; j < board[i].length; j++) {
        int randomColor;
        counter++;
        if (counter == (tableSize * tableSize)) {
          break;
        }
        while (true) {
          randomColor = rng.nextInt(colorRange.length);
          if (color[colorRange[randomColor]] != 0) {
            color[colorRange[randomColor]] = color[colorRange[randomColor]] - 1;
            board[i][j] = colorRange[randomColor];
            break;
          }
        }
      }
    }
    return board;
  }

  bool checkIfDone() {
    for (int i = 0; i < goalBoard.length; i++) {
      for (int j = 0; j < goalBoard[i].length; j++) {
        if (goalBoard[i][j] != board[i + 1][j + 1]) {
          return false;
        }
      }
    }
    return true;
  }

  void initializeGoalBoard() {
    int goalSize = tableSize - 2;
    var rng = new Random();
    goalBoard = List.generate(goalSize, (i) => List(goalSize));
    HashMap<String, int> color = new HashMap();
    for (String i in colorRange) {
      color[i] = colorQuantity;
    }
    int counter = 0;
    for (int i = 0; i < goalBoard.length; i++) {
      for (int j = 0; j < goalBoard[i].length; j++) {
        int randomColor;
        if (counter == (goalSize * goalSize)) {
          break;
        }
        counter++;
        while (true) {
          randomColor = rng.nextInt(colorRange.length);
          if (color[colorRange[randomColor]] != 0) {
            color[colorRange[randomColor]] = color[colorRange[randomColor]] - 1;
            goalBoard[i][j] = colorRange[randomColor];
            break;
          }
        }
      }
    }
  }
}

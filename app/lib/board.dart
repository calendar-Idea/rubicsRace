import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'sizeConfig.dart';
import 'tile.dart';
import 'package:flutter/foundation.dart';

class Board extends StatefulWidget {
  final List board;
  final int tableSize;
  final Function handleMove;
  

  Board({Key key, this.board, this.tableSize, this.handleMove})
      : super(key: key);
  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {
  List<List<Tile>> columns;
  List board;
  int tableSize;
  SizeConfig sizeScreen;
  Function handleMove;
  @override
  void initState() {
    super.initState();
    sizeScreen = new SizeConfig();
    this.board = widget.board;
    this.tableSize = widget.tableSize;
    this.handleMove = widget.handleMove;
    columns = List.generate(tableSize, (index) => List<Tile>());
  }

  void buildImageBoard(BuildContext context) {
    int i = 0;
    sizeScreen.init(context);
    for (List row in board) {
      int j = 0;
      for (String color in row) {
        columns[i].add(Tile(
            tableSize: this.tableSize,
            color: color,
            boardSizing: sizeScreen,
            x: i,
            y: j,
            onTap: (x, y) => {handleMove(x, y)}));
        j++;
      }
      i++;
    }
  }

  @override
  Widget build(BuildContext context) {
    buildImageBoard(context);
    return Container(
        
        child: Column(
      children:
          columns.asMap().entries.map((e) => Row(children: e.value)).toList(),
    ));
  }
}

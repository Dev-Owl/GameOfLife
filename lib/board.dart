import 'package:flutter/material.dart';
import 'package:gameoflife/cell.dart';

class GameBoard extends StatelessWidget {
  final List<bool> _world;
  final Size cellSize;
  final int _rowLength;
  final int _cellMargin;

  const GameBoard(this._cellMargin,this._world, this._rowLength, {Key key, this.cellSize})
      : super(key: key);

  List<Widget> _buildCells() {
    final cells = List<Widget>();
    var rowCounter = 0;
    for (var i = 0; i < _world.length; ++i) {
      if (i != 0 && i  % _rowLength == 0) rowCounter++;

      final left = ((i - (rowCounter * _rowLength)) * cellSize.width)+_cellMargin;
      final top  = (cellSize.height * rowCounter)+_cellMargin;
      final marginedSize = Size(cellSize.width-2*_cellMargin,cellSize.height-2*_cellMargin);
      cells.add(
        CustomPaint(
          size: marginedSize,
          painter: CellPainter(
            cellIsAlive: _world[i],
            left: left,
            top: top,
          ),
        ),
      );
    }
    return cells;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: _buildCells());
  }
}

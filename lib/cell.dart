import 'package:flutter/material.dart';

class CellPainter extends CustomPainter {
  bool cellIsAlive = false;
  double left;
  double top;
  final Paint paintSetting = Paint();

  CellPainter({this.cellIsAlive,this.left,this.top}){
    paintSetting.strokeWidth = 1;
  }

  @override
  void paint(Canvas canvas, Size size) {
  paintSetting.color = Colors.teal;

    //canvas.drawRect(Rect.fromLTWH(left, top, size.width, size.height), paintSetting);
    paintSetting.color =  cellIsAlive ? Colors.green : Colors.amber;
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(left, top, size.width, size.height), Radius.circular(4)),paintSetting);
    //canvas.drawCircle(Rect.fromLTWH(left, top, size.width, size.height).center, size.height/2, paintSetting);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    var cellPainter = (oldDelegate as CellPainter);
    return cellPainter.cellIsAlive != this.cellIsAlive
            || cellPainter.left != this.left 
            || cellPainter.top != this.top;
  }
}

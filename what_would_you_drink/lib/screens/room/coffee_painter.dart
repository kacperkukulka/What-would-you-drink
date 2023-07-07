import 'package:flutter/material.dart';
import '../../shared/brew_types.dart';

class CoffeePainter extends CustomPainter {
  final int milkPercent;
  final String type;

  CoffeePainter(this.milkPercent, this.type);

  @override
  void paint(Canvas canvas, Size size){    
    //milk
    final Rect milk = Rect.fromCenter(
      center: Offset(size.width/2, size.height*milkPercent/200),
      width: size.width, 
      height: size.height * milkPercent/100);

    final Paint coffePaint = Paint()..color = Colors.white;

    canvas.drawRect(milk, coffePaint);

    //brew
    final Rect brew = Rect.fromCenter(
      center: Offset(size.width/2, size.height*milkPercent/100 + size.height*(100-milkPercent)/200), 
      width: size.width, 
      height: size.height * (100-milkPercent)/100);

    late Color brewColor;
    switch (type) {
      case 'tea':     brewColor = Colors.green[300]!; break;
      case 'coffee':  brewColor = Colors.brown; break;
      case 'instant_coffee': brewColor = const Color.fromARGB(255, 182, 125, 39); break;
      case 'loose_coffee': brewColor = Colors.brown[900]!; break;
      default: brewColor = Colors.black45; break;
    }
    final Paint brewPaint = Paint()
      ..color = brewColor;

    canvas.drawRect(brew, brewPaint);

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class CircularPage extends StatefulWidget {
  CircularPage({Key key}) : super(key: key);

  @override
  _CircularPageState createState() => _CircularPageState();
}

class _CircularPageState extends State<CircularPage> 
with SingleTickerProviderStateMixin{
  double porc = 0;
  double nuevoPorc = 0;
  AnimationController aniCtrl;
  @override
  void initState() { 
    super.initState();
    aniCtrl = new AnimationController(
      vsync: this, 
      duration: Duration(milliseconds: 20000)
    );
    aniCtrl.addListener(() {
      // print('Valor controller: ${aniCtrl.value}');
      setState(() {
        porc = lerpDouble(porc, nuevoPorc, aniCtrl.value);
        // print('Porc: $porc');
      });
    });
  }
  @override
  void dispose() { 
    
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () {
          setState(() {
            porc = nuevoPorc;
            nuevoPorc += 10;
            if (nuevoPorc>100) {
              nuevoPorc = 0;
              porc = 0;
            }
            // print('Comienzo -----------');
            aniCtrl.forward(from: 0.0);
          });
        }
      ),
      body: Center(
        child: Container(
          width: 300,
          height: 300,
          // color: Colors.red,
          child: CustomPaint(
            painter: _Circulo(porc),
          )
        ),
      ),
    );
  }
}

class _Circulo extends CustomPainter {
  double porc;
  _Circulo(this.porc);
  Color color;
  @override
  void paint(Canvas canvas, Size size) {
    // print('Pintando: $porc');
    color = Color.fromRGBO(255, 0, 0, 1.0);
    double stWidth = 10.0;
    final paint = new Paint()
      ..strokeWidth = stWidth
      ..color = Colors.grey
      ..style = PaintingStyle.stroke;
    final Offset c = Offset(size.width*0.5, size.height*0.5);
    final double radius = min(size.width, size.height)*0.5 - stWidth/2;
    canvas.drawCircle(c, radius, paint);
    final paintArco = new Paint()
      ..strokeWidth = stWidth * 1.60
      ..color = color
      ..style = PaintingStyle.stroke;
    final double radiusArc = min(size.width, size.height)*0.5 - stWidth*1.50/2;
    double arcAngle = 2 * pi * ( porc / 100.0);
    canvas.drawArc(
      Rect.fromCircle(center: c, radius: radiusArc),
      -pi / 2, 
      arcAngle, 
      true, 
      paintArco);
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
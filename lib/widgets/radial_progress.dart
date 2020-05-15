import 'dart:math';

import 'package:flutter/material.dart';

class RadialProgress extends StatefulWidget {
  final porcentaje;
  final Color color;
  final bool mostrarValor;
  RadialProgress({
    @required this.porcentaje, 
    this.color = Colors.blue,
    this.mostrarValor = false,
  });

  @override
  _RadialProgressState createState() => _RadialProgressState();
}

class _RadialProgressState extends State<RadialProgress> with SingleTickerProviderStateMixin {
  AnimationController controller;
  double porcAnterior;
  @override
  void initState() { 
    super.initState();
    porcAnterior = widget.porcentaje;
    controller = new AnimationController(vsync: this, 
      duration: Duration(milliseconds: 800)
    );
  }
  @override
  void dispose() { 
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    controller.forward(from: 0.0);
    final diff = widget.porcentaje - porcAnterior;
    porcAnterior = widget.porcentaje;
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget child) {
        final vProg = diff*controller.value + porcAnterior-diff;
        return Container(
          width: double.infinity,
          height: double.infinity,
          child: CustomPaint(
            painter: _Circulo(vProg, widget.color),
            child: widget.mostrarValor ? 
              Center(
                child: Text('${vProg.round()} %',
                  style: TextStyle(fontSize: 30),
                ),) :
              Container(),
          )
        );
      },
    );
  }
}

class _Circulo extends CustomPainter {
  double porc;
  Color color;
  _Circulo(this.porc, this.color);
  @override
  void paint(Canvas canvas, Size size) {
    // print('Pintando: $porc');
    // color = Color.fromRGBO(255, 0, 0, 1.0);
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
      false, 
      paintArco);
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
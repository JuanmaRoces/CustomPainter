import 'package:custom_painter/pages/graficas_circulares.dart';
import 'package:flutter/material.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        body: GraficasCirculares(),
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text('Hello World'),
      ),
    );
  }
}

class HeaderCuadrado extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      color: Color(0xff615aab),
    );
  }
}

class BordesRedondos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(70),
          bottomRight: Radius.circular(70),
        ),
        color: Color(0xff615aab),
      ),
    );
  }
}

class HeaderDiagonal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: CustomPaint(
        painter: _DiagonalPainter(),
      ),
    );
  }
}
class _DiagonalPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final lapiz = Paint();
    lapiz.color = Color(0xff615aab);
    lapiz.style = PaintingStyle.fill;
    lapiz.strokeWidth = 5;
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height*0.30);
    path.lineTo(size.width*0.5, size.height*0.35);
    path.lineTo(size.width, size.height*0.3);
    path.lineTo(size.width, 0);
    canvas.drawPath(path, lapiz);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

}

/////////
///
class HeaderCurvo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: CustomPaint(
        painter: _CurvoPainter(),
      ),
    );
  }
}
class _CurvoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final lapiz = Paint();
    final path = Path();
    final grad = RadialGradient(
      colors: [
        Colors.red,
        Colors.yellow,
        Colors.red,
        Color(0xff6d05e8),
        Color(0xffc012ff),
        Color(0xff6d05fa),
        Colors.red,
        Colors.blue,
        Colors.blueAccent,
      ],
      stops: [
        0.1,
        0.1,
        0.3,
        0.4,
        0.5,
        0.5,
        0.5,
        0.5,
        0.5,
      ]
    );
    final rect = Rect.fromCircle(
      center: Offset(size.width*0.5, 80),
      radius: 260,
    );
    lapiz.shader = grad.createShader(rect);
    lapiz.color = Color(0xff615aab);
    lapiz.style = PaintingStyle.fill;
    lapiz.strokeWidth = 10;
    path.lineTo(0, size.height*0.3);
    path.quadraticBezierTo(size.width*0.10, size.height*0.40, size.width*0.5, size.height*0.3);
    path.quadraticBezierTo(size.width*0.70, size.height*0.25, size.width*1.05, size.height*0.3);
    path.lineTo(size.width, 0);

    canvas.drawPath(path, lapiz);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

}
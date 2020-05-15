import 'package:flutter/material.dart';
import 'dart:math' as Math;

class PageAnimaciones extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CuadroAnimado(_Rectangulo()),
      ),
    );
  }
}

// Esta clase controla la animación
class CuadroAnimado extends StatefulWidget {
  final Widget cuadro;
  CuadroAnimado(this.cuadro);
  @override
  _CuadroAnimadoState createState() => _CuadroAnimadoState();
}
class _CuadroAnimadoState extends State<CuadroAnimado> with SingleTickerProviderStateMixin {
  AnimationController ctrl;
  Animation<double> rotacion;
  Animation<double> opacidad;
  Animation<double> opacidadOut;
  Animation<double> moverDerecha;
  Animation<double> agrandar;
  @override
  void initState() { 
    super.initState();
    ctrl = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 4000),
    );
    rotacion = Tween(begin: 0.0, end: 2.0*Math.pi).animate(
      CurvedAnimation(parent: ctrl, curve: Curves.easeOut)
    );
    opacidad = Tween(begin: 0.1, end: 1.00).animate(
      CurvedAnimation(parent: ctrl, 
      curve: Interval(0, 0.50, curve: Curves.easeOut))
    );
    opacidadOut = Tween(begin: 0.0, end: -0.9).animate(
      CurvedAnimation(parent: ctrl, 
      curve: Interval(0.75, 1.0, curve: Curves.easeOut))
    );
    moverDerecha = Tween(begin: 0.0, end: 200.0).animate(ctrl);
    ctrl.addListener(() {
      /*
      if (ctrl.status == AnimationStatus.completed)
        ctrl.reset();
      */
    });
    agrandar = Tween(begin: 0.5, end: 2.0).animate(ctrl);
    ctrl.forward();
    //ctrl.repeat();
  }
  @override
  void dispose() { 
    ctrl.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: ctrl,
      child: widget.cuadro,
      builder: (BuildContext context, Widget child) {
        return Transform.translate(
          offset: Offset(moverDerecha.value, 0),
          child: Transform.rotate(
            angle: rotacion.value,
            child: Opacity(
              opacity: opacidad.value+opacidadOut.value,
              child: Transform.scale(
                scale: agrandar.value,
                child: child)
              ),
          ),
        );
      },
    );
  }
}


// Este es el elemento a animar
class _Rectangulo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.blue,
      ),
    );
  }
}
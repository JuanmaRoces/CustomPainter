import 'package:custom_painter/widgets/radial_progress.dart';
import 'package:flutter/material.dart';

class GraficasCirculares extends StatefulWidget {
  GraficasCirculares({Key key}) : super(key: key);

  @override
  _GraficasCircularesState createState() => _GraficasCircularesState();
}

class _GraficasCircularesState extends State<GraficasCirculares> {
  double porcentaje = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            porcentaje += 10;
            if (porcentaje>100)
              porcentaje = 0;
          });
        },
        child: Icon(Icons.refresh),
      ),
      body: Center(
        child: Container(
          width: 300,
          height: 300,
          child: RadialProgress(porcentaje: porcentaje, color: Colors.purple, mostrarValor: true,),
        )
      )
    );
  }
}
import 'package:flutter/material.dart';

import "../componentes/PhotoTile.dart";
import '../Telas/TelaCamera.dart';

class TelaInicial extends StatefulWidget {
  @override
  _TelaInicialState createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  var lista = [
    PhotoTile(),
    PhotoTile(),
    PhotoTile(),
    PhotoTile(),
    PhotoTile(),
    PhotoTile(),
    PhotoTile(),
    PhotoTile(),
    PhotoTile(),
    PhotoTile(),
    PhotoTile(),
    PhotoTile(),
    PhotoTile(),
    PhotoTile(),
    PhotoTile(),
    PhotoTile()
  ];

  var _scale = "oi";
  var _scaleStart;
  var _scaleEnd;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_scale),
      ),
      body: GestureDetector(
        onScaleUpdate: (details) {
          setState(() {
            var scale = details.scale;
            _scale = "$scale";
          });
        },
        child: GridView.count(
          crossAxisCount: 3,
          children: lista,
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.all(2),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => clicouCamera(),
        tooltip: 'Abrir Câmera',
        child: Icon(Icons.camera),
      ),
    );
  }

  void clicouCamera() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CameraView()));
  }
}

import 'package:flutter/material.dart';

import "./componentes/PhotoTile.dart";
import "./Telas/Camera.dart";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'one pic a day demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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

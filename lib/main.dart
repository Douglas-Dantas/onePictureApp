import 'package:flutter/material.dart';

import "./componentes/PhotoTile.dart";
import 'Telas/TelaCamera.dart';
import 'Telas/TelaInicial.dart';

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
      home: TelaInicial(),
    );
  }
}
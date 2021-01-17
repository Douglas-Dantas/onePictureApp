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
  var _corBotoesOpcoes;

  bool shouldShowOptions;
  bool shouldHideOptions;

  @override
  void initState() {
    _corBotoesOpcoes = Colors.yellowAccent;
    shouldShowOptions = false;
    shouldHideOptions = true;
    super.initState();
  }

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
      floatingActionButton: Container(
        height: 200,
        child: floatingActionButton(),
        // color: Colors.white,
      ),
    );
  }

  Widget floatingActionButton() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        AnimatedPositioned(
          duration: Duration(milliseconds: 200),
          bottom: shouldShowOptions ? 60 : -100,
          // onEnd: () => setState(() {
          // if (!shouldShowOptions) shouldHideOptions = !shouldHideOptions;
          // },),
          child: Column(
            children: [
              IconButton(
                  icon: Icon(
                    Icons.camera_alt,
                  ),
                  color: _corBotoesOpcoes,
                  onPressed: () => clicouCamera()),
              IconButton(
                  icon: Icon(
                    Icons.photo_album,
                  ),
                  color: _corBotoesOpcoes,
                  onPressed: () => print('Clicou Album')),
            ],
          ),
        ),
        FloatingActionButton(
          onPressed: () => clicouFloatingActionButton(),
          tooltip: 'Abrir Câmera',
          elevation: shouldShowOptions ? 10 : 2,
          child: Icon(
            shouldShowOptions ? Icons.cancel : Icons.add_a_photo,
            // size: 45,
          ),
        ),
      ],
    );
  }

  void clicouFloatingActionButton() {
    setState(() {
      shouldShowOptions = !shouldShowOptions;
      if (shouldHideOptions) shouldHideOptions = !shouldHideOptions;
    });
  }

  void clicouCamera() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CameraView()));
  }
}

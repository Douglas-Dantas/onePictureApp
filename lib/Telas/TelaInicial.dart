import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
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

  //open galery
  File _image;
  final picker = ImagePicker();

  var _scale = "oi";
  var _scaleStart;
  var _scaleEnd;
  var _corBotoesOpcoes;
  int _duracaoAnimacao;
  int _numberOfTilesPerRow;

  bool shouldShowOptions;
  bool shouldHideOptions;

  @override
  void initState() {
    _corBotoesOpcoes = Colors.teal;
    _duracaoAnimacao = 150;
    shouldShowOptions = false;
    shouldHideOptions = true;
    _numberOfTilesPerRow = 3;
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
          if (details.scale > 1)
            _numberOfTilesPerRow = 3;
          else
            _numberOfTilesPerRow = 4;
          setState(() {
            _scale = "${details.scale}";
          });
        },
        child: AnimatedCrossFade(
          duration: Duration(milliseconds: 200),
          firstChild: gridView(3),
          secondChild: gridView(4),
          crossFadeState: _numberOfTilesPerRow == 3
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
        ),
      ),
      floatingActionButton: Container(
        height: 200,
        child: floatingActionButton(),
        // color: Colors.white,
      ),
    );
  }

  Widget gridView(numberOfTilesPerRow) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: numberOfTilesPerRow,
      children: lista,
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.all(2),
    );
  }

  Widget floatingActionButton() {
    return Stack(
      alignment: Alignment.bottomCenter,
      clipBehavior: Clip.none,
      children: [
        AnimatedPositioned(
          onEnd: () => finalizouAnimacao(),
          duration: Duration(milliseconds: _duracaoAnimacao),
          bottom: shouldShowOptions ? 60 : 0,
          child: Opacity(
            opacity: shouldHideOptions ? 0 : 1,
            child: Tooltip(
              message: "Abrir Câmera",
              child: RawMaterialButton(
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                  ),
                  fillColor: _corBotoesOpcoes,
                  shape: CircleBorder(),
                  onPressed: () => clicouCamera()),
            ),
          ),
        ),
        AnimatedPositioned(
          duration: Duration(milliseconds: _duracaoAnimacao),
          bottom: shouldShowOptions ? 105 : 0,
          child: Opacity(
            opacity: shouldHideOptions ? 0 : 1,
            child: Tooltip(
              message: "Abrir Álbum",
              child: RawMaterialButton(
                child: Icon(
                  Icons.photo_album,
                  color: Colors.white,
                ),
                fillColor: _corBotoesOpcoes,
                shape: CircleBorder(),
                onPressed: () => clicouAlbum(),
              ),
            ),
          ),
        ),
        FloatingActionButton(
          onPressed: () => clicouFloatingActionButton(),
          tooltip: 'Adicionar Foto',
          elevation: 10,
          backgroundColor: shouldShowOptions ? Colors.red : _corBotoesOpcoes,
          child: Icon(
            shouldShowOptions ? Icons.cancel : Icons.add_a_photo,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  void finalizouAnimacao() {
    if (shouldShowOptions)
      shouldHideOptions = false;
    else
      shouldHideOptions = true;
    setState(() {});
  }

  void clicouFloatingActionButton() {
    shouldShowOptions = !shouldShowOptions;
    if (shouldShowOptions) shouldHideOptions = false;
    setState(() {});
  }

  void clicouCamera() {
    shouldShowOptions = !shouldShowOptions;
    setState(() {});
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CameraView()));
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    // final bytes = await pickedFile.readAsBytes();

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  void clicouAlbum() {
    getImage();
  }
}

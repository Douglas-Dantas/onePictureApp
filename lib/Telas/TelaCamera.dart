import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CameraView extends StatefulWidget {
  @override
  _CameraViewState createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  CameraController _controller;
  List cameras;
  int selectedCameraIdx;
  String imagePath;

  @override
  void initState() {
    super.initState();
    availableCameras().then((availableCameras) {
      cameras = availableCameras;
      if (cameras.length > 0) {
        setState(() {
          selectedCameraIdx = 0;
        });
        _initCameraController(cameras[selectedCameraIdx]).then((void v) {});
      } else {
        print("No camera available");
      }
      // fechaSeCameraNegada();
    }).catchError((err) {
      print('Error: ${err.code}\nError Message: ${err.message}');
      Navigator.pop(context);
    });
  }

  // void fechaSeCameraNegada() async {
  //   var status = await Permission.camera.status;
  //   print('====> $status');
  // }

  Future _initCameraController(CameraDescription cameraDescription) async {
    if (_controller != null) {
      await _controller.dispose();
    }
    _controller = CameraController(cameraDescription, ResolutionPreset.medium);
    _controller.addListener(() {
      if (mounted) {
        setState(() {});
      }
      if (_controller.value.hasError) {
        print('Camera error ${_controller.value.errorDescription}');
      }
    });

    try {
      await _controller.initialize();
    } on CameraException catch (e) {
      print(e);
    }

    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("Take a pic"), backgroundColor: Color(0xaa000000), elevation: 0,),
      body: SafeArea(
        child: Stack(
          children: [
            _cameraPreviewWidget(),
            appBarContainer(),
            containerBotoes()
          ],
        ),
      ),
    );
  }

  Widget appBarContainer() {
    return Container(
      // alignment: Alignment.topCenter,
      color: Color(0x990000000),
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          BackButton(
            color: Colors.white,
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
    );
  }

  Widget containerBotoes() {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Container(
        color: Color(0x990000000),
        width: MediaQuery.of(context).size.width,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              child: botaoTrocarCamera(),
              left: 15,
            ),
            botaoBaterFoto(),
          ],
        ),
      ),
    );
  }

  Widget _cameraPreviewWidget() {
    if (_controller == null || !_controller.value.isInitialized) {
      return Container(
        color: kDebugMode ? Colors.blueGrey : Colors.black,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    SystemChrome.setEnabledSystemUIOverlays([]);
    return CameraPreview(_controller);
  }

  Widget botaoBaterFoto() {
    return FloatingActionButton(
      materialTapTargetSize: MaterialTapTargetSize.padded,
      onPressed: () => print("Clicou bater foto"),
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Icon(
        Icons.photo_camera,
        size: 50,
        color: Colors.white,
      ),
    );
  }

  Widget botaoTrocarCamera() {
    Function trocarCamera = () {
      if (selectedCameraIdx + 1 >= cameras.length) {
        selectedCameraIdx = 0;
      } else {
        selectedCameraIdx++;
      }
      CameraDescription selectedCamera = cameras[selectedCameraIdx];
      _initCameraController(selectedCamera);
      setState(() {});
    };

    return IconButton(
      icon: Icon(
        Icons.camera_front,
        color: Colors.white,
      ),
      onPressed: () => trocarCamera(),
    );
  }
}

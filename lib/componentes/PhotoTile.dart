import 'package:flutter/material.dart';
import 'package:one_pic/Telas/DetalheFoto.dart';

class PhotoTile extends StatefulWidget {
  @override
  _PhotoTileState createState() => _PhotoTileState();
}

class _PhotoTileState extends State<PhotoTile> {
  double _width = 120;
  double _height = 120;

  @override
  void initState() {
    super.initState();
  }

  tocouTile() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => DetalheFoto()));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Stack(
          alignment: Alignment.bottomCenter,
          fit: StackFit.expand,
          children: [
            imagemView(),
            Material(
              color: Colors.transparent,
              child: new InkWell(
                onTap: () => tocouTile(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget imagemView() {
    Widget placeholder = SizedBox(
      height: _height,
      width: _width,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );

    Function onLoading =
        (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
      if (loadingProgress == null)
        return child;
      else
        return placeholder;
    };

    return GridTile(
      // footer: dataBox(),
      child: new Image.network(
        'https://placeimg.com/640/480/any',
        loadingBuilder: onLoading,
        fit: BoxFit.cover,
      ),
    );
  }

  // Widget dataBox() {
  //   return Container(
  //     decoration: BoxDecoration(
  //       // border: Border.all(color: Color(0xffdddddd)),
  //       color: Colors.black45,
  //       // borderRadius: BorderRadius.circular(5),
  //     ),
  //     child: SizedBox(
  //       height: 20,
  //       width: 80,
  //       child: Center(
  //         child: Text(
  //           "11/01/2021",
  //           style: TextStyle(
  //               fontSize: 11, color: Colors.white, fontWeight: FontWeight.w800),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}

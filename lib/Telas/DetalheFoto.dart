import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetalheFoto extends StatefulWidget {
  @override
  _DetalheFotoState createState() => _DetalheFotoState();
}

class _DetalheFotoState extends State<DetalheFoto> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Stack(children: [
          AppBar(
            // title: Text("23/06/2021"),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          Center(
            child: new Image.network(
              'https://placeimg.com/640/480/any',
              fit: BoxFit.cover,
            ),
          ),
          containerRodape()
        ]),
      ),
    );
  }

  Widget containerRodape() {
    return Container(
      alignment: Alignment.bottomCenter,
      // color: Colors.white30,
      child: Container(
        color: Color(0x99000000),
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Data: 23/02/2021',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
              CupertinoButton(
                child: Text(
                  'Baixar para galeria',
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                padding: EdgeInsets.all(0),
                onPressed: () => print('Pressed'),
                minSize: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

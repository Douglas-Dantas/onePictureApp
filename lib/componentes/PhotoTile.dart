import 'package:flutter/material.dart';

class PhotoTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Card(
          color: Colors.black54,
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 0,
          child: new InkWell(
            onTap: () => print("photo pressed"),
            splashColor: Colors.black,
            child: SizedBox(
              height: 120,
              width: 120,
              child: new Image.network(
                'https://placeimg.com/640/480/any',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xffdddddd)),
            color: Color(0xffffffff),
            borderRadius: BorderRadius.circular(5),
          ),
          child: SizedBox(
            height: 20,
            width: 80,
            child: Center(
              child: Text(
                "11/01/2021",
                style: TextStyle(fontSize: 11),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

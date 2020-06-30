import 'package:flutter/material.dart';

class note extends StatelessWidget {

  final String image;
  final String title;
  final String description;

  const note({Key key, this.image, this.title, this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      width:width,
      height: height -106,
      child:Column(
        children: <Widget>[
          Container(
            height: 250,
            width: width,
            child: Center(
              child: Column(
                children:<Widget>[
                  Image.asset(image,height:180,width:180),
                  SizedBox(
                    height:2
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 25.0
                    ),
                    textAlign: TextAlign.center,
                  )
                ]
              )
            ),
          ),

          Container(
            padding: const EdgeInsets.all(10),
            child: Text(
              description,
              style: TextStyle(
                fontSize: 16.0,
              )
            )
          )

        ],
      )
    );
  }
}
import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';

class page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: height -108,
      child: Material(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: Column(
          children: <Widget>[
            Container(
              height:250,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset("assets/images/lady-doctor-message.png",width:150,height:150),
                    SizedBox(height:20),
                    Text(
                      "Notes",
                      style: TextStyle(
                        fontSize: 25,
                      )
                    )
                  ]
                )
              )
            ),
            Container(
              padding: const EdgeInsets.all(5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Help the doctors and nurses fight the coronavirus by doing the following.",
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height:15),
                  Item(todo: "Stay Home"),
                  SizedBox(height: 10),
                  Item(todo: "Wash your Hands"),
                  SizedBox(height: 10),
                  Item(todo: "Wear a mask When outside"),
                  SizedBox(height: 10),
                  Item(todo: "Self Isolate if sick"),
                  SizedBox(height: 10),
                  Item(todo: "Avoid Crowds"),
                  SizedBox(height: 10),
                  Item(todo: "Sanitise  ou hands"),
                  SizedBox(height: 10),
                  Item(todo: "Stay Safe"),
                ]
              )
            )
          ],
        )
      )
    );
  }

  Item({String todo,}){
    return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(Mdi.chevronDoubleRight,size:30),
                SizedBox(width:20),
                Container(
                  child: Text(
                    todo,
                    style: TextStyle(
                      fontSize:15.0,
                      color: Colors.grey,
                      letterSpacing: 3
                    ),
                    softWrap: true,
                    maxLines: 3,
                  ),
                )
              ]
            );
  }

}
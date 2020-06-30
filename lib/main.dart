import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Home.dart';
import 'data/DataStorage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CovidSafe',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.red,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SafeArea(child:MyHomePage()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    Storage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor
            ),
            child: Stack(
              children: <Widget>[
                Center(
                  child:Container(
                    width:220,
                    height: 220,
                    child: Image.asset('assets/images/globe-33.gif',colorBlendMode: BlendMode.multiply,)
                  )
                ),
                Center(
                    child:Container(
                        width:320,
                        height: 320,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color:Theme.of(context).primaryColor,width:60,style:BorderStyle.solid)
                      )
                    )
                ),
                Positioned(
                  bottom:10,
                  left:0,
                  right:0,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height:10),
                      Center(
                        child: Container(
                          width:150,
                          child: RaisedButton(
                            onPressed:(){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Home()
                                  )
                              );
                            },
                            child: Text("Continue")
                          ),
                        ),
                      )
                    ]
                  )
                )
              ]
            )
          )
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

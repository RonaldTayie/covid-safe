import 'package:covidsafe/bloc/navigation_bloc.dart';
import 'package:covidsafe/data/DataStorage.dart';
import 'package:covidsafe/pages/NewsOffline.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webfeed/webfeed.dart';

class HomePage extends StatefulWidget with NavigationStates{
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //Get the RSS feed from the SharedPrefernces
  RssFeed _feed;
  int _feedLength = 0;

  _loadNews ()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.get('Headlines'));
    if(Conn()==true&&_feedLength<1){
      StoreHeadlines();
      setState(()=>_feed = RssFeed.parse(prefs.get('Headlines')));
      setState(()=>_feedLength = _feed.items.length);
      return _feed;
    }else{
      if(prefs.get('Headlines')!=""&& _feedLength<1){
        setState(()=>_feed = RssFeed.parse(prefs.get('Headlines')));
        setState(()=>_feedLength = _feed.items.length);
        return _feed;
      }
    }
  }

  @override
  void initState() {
    _loadNews();
    super.initState();
  }

  //Cases Data

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    Color primaryColor = Theme.of(context).primaryColor;

    _loadNews();
    return Container(
      width:width,
      height: height,
      child: Stack(

        children: <Widget>[
          Column(
            children: <Widget>[
              Material(
                elevation:3,
                borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(400.0),bottomRight: Radius.circular(20.0)),
                color: Theme.of(context).primaryColor,
                child: Container(
                  height:height*0.6,
                  width:width,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(400))
                  ),

                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(400)),
                    child:Stack(
                      fit: StackFit.expand,
                      children:<Widget>[
                        Positioned(
                          top: -40,
                          right: -40,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(100)),
                            child:Container(
                              width:200,
                              height: 200,
                              child: Image.asset("assets/images/globe-33.gif"),
                            )
                          ),
                        ),
                        Positioned(
                          top: -80,
                          right: -80,
                          child: ClipRRect(
                              borderRadius: const BorderRadius.all(Radius.circular(100)),
                              child:Container(
                                width:280,
                                height: 280,
                                decoration: BoxDecoration(
                                  image:  new DecorationImage(
                                    image: new AssetImage("assets/images/virus.png"),
                                    fit: BoxFit.fill,
                                    colorFilter: new ColorFilter.mode(Theme.of(context).primaryColor.withOpacity(0.4), BlendMode.dstATop)
                                  )
                                ),
                              )
                          ),
                        ),

                        Positioned(
                          top:200,
                          right:0,
                          child: Column(
                            children:<Widget>[
                              Text(
                                "Stay Home".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 30.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 4.0,
                                )
                              ),
                              Text(
                                "Stay Safe".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 40.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 4.0,
                                ),
                              )
                            ]
                          ),
                        )
                      ]
                    )
                  )

                )
              ),
            ],
          ),
          Positioned(
            top:250,
            right: 0,
            left: 0,
            child: FutureBuilder(
              future: _loadNews(),
              builder: (BuildContext context,AsyncSnapshot snapshot){
                return _feed!=null?
                  Container(
                    width:width,
                    child: ListView.builder(
                      itemBuilder: (BuildContext context,int index){
                        return Container(
                          width:150,
                          child:Text("Float")
                        );
                      },
                    )
                  ):
                  Container(child:Center(child:Text("Not Found")));
              }
            )
          )
        ],
      )
    );
  }
}

import 'package:covidsafe/data/DataStorage.dart';
import 'package:covidsafe/pages/NewsOffline.dart';
import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webfeed/webfeed.dart';

class Sport extends StatefulWidget {
  @override
  _SportState createState() => _SportState();
}

class _SportState extends State<Sport> {

  RssFeed _feed;
  int _feedLength =0;
  //Check Connection
  bool _isOnline=false;


  @override
  void initState() {
    StoreSport();
    super.initState();
  }

  _loadNews ()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(Conn()==true && _feed==null){
      StoreSport();
      setState(()=>_feed = RssFeed.parse(prefs.get('sport')));
      setState(()=>_feedLength = _feed.items.length);
      return _feed;
    }else{
      if(prefs.get('sport')!="" && _feed==null){
        setState(()=>_feed = RssFeed.parse(prefs.get('sport')));
        setState(()=>_feedLength = _feed.items.length);
        return _feed;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    _loadNews();
    return _feed !=null?
      ListView.builder(
        padding: const EdgeInsets.all(5.0),
        itemCount: _feedLength,
        itemBuilder: (BuildContext context, int index){
          var item = _feed.items[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 4),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(25.0)),
              border: Border.all(color: primaryColor.withOpacity(0.3),style: BorderStyle.solid,width: 2.0)
            ),
            child: ListTile(
              leading: Container(
                width:60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: primaryColor
                ),
                child:Center(
                  child:Icon(Mdi.football,size:50,color: Colors.white,)
                ),
              ),
              title: Text(
                item.title,
                style: TextStyle(
                  fontSize: 20.25,
                ),
                maxLines: 1,
              ),
              subtitle: Text(item.description,maxLines: 2),
              trailing: Container(
                width: 40,
                child: Center(
                  child: Icon(Mdi.chevronDoubleRight,size:30.0,color: primaryColor.withOpacity(0.3))
                )
              ),
              onTap: (){
                CanLaunchFeed(link: item.link)==true?
                  OpenFeed(feed: item):
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context)=>NewsOffline(feed: item,)
                      )
                  );
              },
            ),
          );
        },
      ):Center(
        child: Text("Loading")
      );
  }
}

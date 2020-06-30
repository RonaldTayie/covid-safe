import 'package:covidsafe/data/DataStorage.dart';
import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webfeed/webfeed.dart';

import '../NewsOffline.dart';

class Health extends StatefulWidget {
  @override
  _HealthState createState() => _HealthState();
}

class _HealthState extends State<Health> {

  RssFeed _feed;
  int _feedLength =0;

  @override
  void initState() {
    StoreHealth();
    super.initState();
  }

  _loadNews ()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(Conn()==true && _feedLength<1){
      StoreHeadlines();
      setState(()=>_feed = RssFeed.parse(prefs.get('Health')));
      setState(()=>_feedLength = _feed.items.length);
      return _feed;
    }else{
      if(prefs.get('Health')!="" && _feedLength<1){
        setState(()=>_feed = RssFeed.parse(prefs.get('Health')));
        setState(()=>_feedLength = _feed.items.length);
        return _feed;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _loadNews();
    Color primaryColor = Theme.of(context).primaryColor;
    return _feed !=null?
      ListView.builder(
        padding: const EdgeInsets.all(2.1),
        itemBuilder: (BuildContext context,int index){
          RssItem item = _feed.items[index];
          return Container(
            margin: const EdgeInsets.only(top:2.5),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              border:  Border.all(color: primaryColor.withOpacity(0.4),width: 1.0,style: BorderStyle.solid),
              borderRadius: BorderRadius.all(Radius.circular(20.0))
            ),
            child:ListTile(
              trailing: Container(
                width: 30.0,
                child: Center(
                  child: Icon(Mdi.chevronDoubleRight,size:25.0),
                ),
              ),
              leading: Container(
                width:50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: primaryColor
                ),
                child: Center(
                  child: Icon(Mdi.hospitalBox,size:40.0,color:Colors.white70),
                ),
              ),
              title: Text(item.title,maxLines: 1,style: TextStyle(fontSize:15.0),softWrap: true,),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(item.description,maxLines: 3,softWrap: true,style: TextStyle(fontWeight: FontWeight.w300)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(item.pubDate,style: TextStyle(fontSize:10))
                    ],
                  )
                ],
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
            )
          );
        }
      ):Center(
        child: CircularProgressIndicator(
          backgroundColor: primaryColor,
          strokeWidth: 3.1,
        )
      );
     
  }
}

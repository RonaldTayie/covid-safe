import 'package:covidsafe/data/DataStorage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webfeed/webfeed.dart';

import '../NewsOffline.dart';

class Headlines extends StatefulWidget {
  @override
  _HeadlinesState createState() => _HeadlinesState();
}

class _HeadlinesState extends State<Headlines> {

  RssFeed _feed;
  int _feedLength =0;
  //Check Connection
  bool _isOnline=false;

  @override
  void initState() {
    StoreHeadlines();
    super.initState();
  }

  _loadNews ()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
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
  Widget build(BuildContext context) {
    _loadNews();
    Color primaryColor = Theme.of(context).primaryColor;

    return ListView.builder(
        itemCount: _feedLength,
        itemBuilder: (context,int index){
          return ListTile(
            leading: Icon(Icons.chrome_reader_mode,size:50.0,color: primaryColor,),
            title: Text(_feed.items[index].title,style:TextStyle(fontSize: 20.0,letterSpacing: 3,),maxLines: 1,),
            subtitle: Text(_feed.items[index].description,maxLines: 3,),
            onTap: (){

                CanLaunchFeed(link: _feed.items[index].link)==true?
                  OpenFeed(feed: _feed.items[index]):
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context)=>NewsOffline(feed: _feed.items[index],)
                      )
                  );
              },
          );
        }
    );
  }
}

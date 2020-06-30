import 'package:covidsafe/data/DataStorage.dart';
import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';
import 'package:webfeed/webfeed.dart';

class NewsOffline extends StatelessWidget {

  final RssItem feed;

  const NewsOffline({Key key, this.feed}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    Color primaryColor =Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: Text(feed.title),
      ),
      body: Column(
        children: <Widget>[
          Container(
            width:width,
            height:180,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: primaryColor
            ),
            child:Center(
              child: Text(
                feed.title,
                style:TextStyle(
                  fontSize: 16.0,
                  color:Colors.white
                )
              )
            )
          ),
          Column(
            children: <Widget>[
              Container(
                width: width,
                height: 50,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment:  CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(feed.pubDate)
                  ],
                )
              ),
              Container(
                height: height-390,
                child: Padding(
                  padding: const EdgeInsets.all(5.2),
                  child: Text(
                    feed.description,
                    style: TextStyle(
                      fontSize: 19.2,
                    )
                  )
                ),
              ),
              ListTile(
                dense:true,
                leading: Container(
                  width:40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle
                  ),
                  child: Center(
                    child: Icon(
                      Mdi.link,
                      size: 30,
                      color: primaryColor
                    )
                  )
                ),
                title: Text("Link"),
                subtitle: Text(feed.link),
                onTap:  () => OpenFeed(feed: feed),
              )
            ],
          )
        ],
      )
    );
  }
}

//floor
/*
salt
sugar
oil
milk
*/
/*
Pan cake

floor (2cups)
1/2 teaspoon salt
1/2 cup sugar()

3 tbs baking powder
water/milk
eggs (optinal)
*/
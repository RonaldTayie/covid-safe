import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:webfeed/webfeed.dart';


Conn()async{
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    print("Connection is mobile");
    return true;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    print("Connection is wifi");
    return true;
  } else {
    return false;
  }
}


void Storage(){
  print("Loading Data for Storage");
  StoreCases();
  StoreHealth();
  StoreHeadlines();
  StoreHeadlines2();
  StoreSport();
  StoreHealth2();
}

_Shared <SharedPreferences> ()async{
  SharedPreferences prefs;
  return prefs;
}

Store({String url,String title})async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var resp = await http.get(url);
  prefs.setString(title, resp.body.toString());
  return prefs.getString(title);
}

StoreCases(){
  print("setting cases");
  return Store(title: "cases",url: "http://jmldemo.000webhostapp.com/parser.php?request=all");
}
StoreHealth(){
  print("setting Health1");
  return Store(title: "Health",url: "https://rss.medicalnewstoday.com/featurednews.xml");
}
StoreHealth2(){
  print("setting Health2");
  return Store(title: "Health",url: "https://medicalxpress.com/rss-feed/");
}
StoreSport(){
  print("setting Sport");
  return Store(title: "sport",url: "https://www.espn.com/espn/rss/news");
}
StoreHeadlines(){
  print("setting NEws");
  return Store(title: "Headlines",url: "https://allafrica.com/tools/headlines/rdf/latest/headlines.rdf");
}
StoreHeadlines2(){
  print("setting News2");
  return Store(title: "Headlines2",url: "http://feeds.news24.com/articles/news24/TopStories/rss");
}


//Open the RSS FEED online or do an offline read all dependent on the network connectivity

CanLaunchFeed({String link}) async{
  var httpCheck = await http.get(link);
  return httpCheck.statusCode==200?true:false;
}

OpenFeed({RssItem feed}) async{
  if(await canLaunch(feed.link)!=false){
    await launch(
      feed.link,
      forceWebView: true,
      forceSafariVC: true,
      enableJavaScript: true
    );
  }
}

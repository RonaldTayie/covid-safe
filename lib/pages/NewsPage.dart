import 'package:covidsafe/bloc/navigation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';
import 'news_pages/Headlines.dart';
import 'news_pages/Health.dart';
import 'news_pages/Other.dart';
import 'news_pages/Sport.dart';

class NewsPage extends StatefulWidget with NavigationStates{
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  PageController page_controller =  PageController(initialPage: 0,);
  int _selected = 0;

  void SelectedIndex({int index}){
    page_controller.jumpToPage(index);
    setState(() => _selected = index);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    Color primaryColor = Theme.of(context).primaryColor;

    return Stack(
      fit: StackFit.expand,
      children:<Widget>[
        Container(
            width:width,
            height: height,
            child: PageView(
              controller: page_controller,
              onPageChanged: (index){
                SelectedIndex(index:index);
              },
              pageSnapping: true,
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Headlines(),
                Health(),
                Sport(),
                Other()
              ],
            )
        ),

        Positioned(
          bottom:0,
          child:Container(
            decoration:BoxDecoration(
              color:Colors.white,
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(20.0),topRight: Radius.circular(20.0)),
              shape: BoxShape.rectangle
            ),
            width:width,
            height:80,
            child: BottomNavigationBar(
              showSelectedLabels: true,
              fixedColor: Colors.black,
              currentIndex: _selected,
              elevation: 3.0,
              backgroundColor: Colors.red,
              onTap: (index){
                SelectedIndex(index: index);
              },
              unselectedIconTheme: IconThemeData(color:Colors.black,size:30),
              unselectedLabelStyle: TextStyle(color:Colors.black,fontSize:10),
              selectedIconTheme: IconThemeData(color:Colors.black,size:40),
              iconSize: 40,
              items: <BottomNavigationBarItem> [
                BottomNavigationBarItem(
                  icon: Icon(Mdi.earth),
                  title: Text("World",style: TextStyle(color: Colors.black)),
                ),
                BottomNavigationBarItem(
                    icon: Icon(Mdi.hospital),
                    title: Text("Health",style: TextStyle(color: Colors.black))
                ),
                BottomNavigationBarItem(
                    icon: Icon(Mdi.football),
                    title: Text("Sport",style: TextStyle(color: Colors.black))
                ),
                BottomNavigationBarItem(
                    icon: Icon(Mdi.robot),
                    title: Text("Other",style: TextStyle(color: Colors.black))
                ),
              ],
            ),
          )
        ),
      ]
    );
  }
}




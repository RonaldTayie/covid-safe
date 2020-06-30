import 'package:covidsafe/bloc/navigation_bloc.dart';
import 'package:covidsafe/models/menuItem.dart';
import 'package:covidsafe/pages/NewsPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mdi/mdi.dart';

class sidebar extends StatefulWidget {
  @override
  _sidebarState createState() => _sidebarState();
}

class _sidebarState extends State<sidebar> {

  List <menuItem> items = [];
  int _selected;

  setSelected(index){
    setState(() => _selected = index);
  }

  bool isMenuOpen = false;

  menuToggle(){
    if(isMenuOpen==true){
      setState(() {
        isMenuOpen = false;
      });
    }else{
      setState(() {
        isMenuOpen = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Stack(
      fit: StackFit.passthrough,
      children: <Widget>[
        AnimatedPositioned(
          duration: Duration(milliseconds: 700),
          width: 300,
          height: height,
          left: isMenuOpen==true?0:-320,
          child: Material(
            color: Theme.of(context).primaryColor,
            elevation: 2.1,
            shadowColor: Colors.white30,
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Positioned(
                  top:-10,
                  left:-10,
                  height: 149,
                  width:149,
                  child: Image.asset("assets/images/globe-33.gif",colorBlendMode: BlendMode.multiply, color: Theme.of(context).primaryColor,)
                ),
                Positioned(
                    top:-40,
                    left:-40,
                    height: 210,
                    width:210,
                    child: Container(
                      width:200,
                      height:200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color:Theme.of(context).primaryColor,style: BorderStyle.solid,width: 39)
                      )
                    )
                ),
                Positioned(
                  top:20,
                  left:120,
                  child: Container(
                    height:100,
                    child: Center(
                        child: Text(
                            "    Menu",
                            style: TextStyle(
                                fontSize:25.0,
                                letterSpacing: 3,
                                fontWeight: FontWeight.bold,
                                color: Colors.white70
                            )
                        )
                    ),
                  ),
                ),

                Container(
                  margin: const EdgeInsets.only(top: 160),
                  child: ListView(
                    children: <Widget>[

                      MenuItem(
                          "Home",
                          Icon(Mdi.home,size:30.0),(){setSelected(0);BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.HomePageClickedEvent);menuToggle();},0
                      ),
                      SizedBox(height:10.0),
                      MenuItem(
                          "Cases",
                          Icon(Mdi.chartMultiline,size:30.0),(){setSelected(1);BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.CasesPageClickedEvent);menuToggle();},1
                      ),
                      SizedBox(height:10.0),
                      MenuItem(
                          "News",
                          Icon(Icons.chrome_reader_mode,size:30.0),
                              (){setSelected(2);BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.NewsPageClickedEvent);menuToggle();},2
                      ),
                      SizedBox(height:10.0),
                      MenuItem(
                          "Note",
                          Icon(Mdi.accountDetails,size:30.0),(){setSelected(3);BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.NotesPageClickedEvent);menuToggle();},3
                      ),
                      SizedBox(height:10.0),
                      MenuItem(
                          "Settings",
                          Icon(Icons.settings,size:30.0),(){setSelected(4);BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.SettingsPageClickedEvent);menuToggle();},4
                      )

                    ],
                  )
                )

              ]
            ),
          )
        ),
        AnimatedPositioned(
          duration: Duration(milliseconds: 700),
          top: 20,
          left: isMenuOpen==true?310:5,
          child: GestureDetector(
            onTap: ()=> menuToggle(),
            child: Container(
              width:40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Icon(Icons.menu,size: 40.0,color: Theme.of(context).primaryColor)
            ),
          )
        )
      ],
    );
  }

  MenuItem(String title,Icon icon,Function onClick,int index){
    return ListTile(
      selected: _selected ==index?true:false,
      onTap: onClick,
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white70,
          fontWeight: FontWeight.w700,
          letterSpacing: 3.5,
          fontSize: 20.0,
          shadows: [
            Shadow(blurRadius: 3.0,color: Colors.black54,offset: Offset(2.0, 4.0))
          ]
        ),
      ),
      leading: Container(
        width:50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white
        ),
        child: Center(
          child: icon
        )
      ),
      key: Key(index.toString()),
    );
  }


}

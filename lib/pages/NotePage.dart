import 'package:covidsafe/bloc/navigation_bloc.dart';
import 'package:covidsafe/pages/note_pages/note.dart';
import 'package:covidsafe/pages/note_pages/page1.dart';
import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';

class NotesPage extends StatefulWidget with NavigationStates{
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  PageController _controller = new PageController();
  int _selectedPage = 0;

  void ChangePage({int index}){
    setState(()=>_selectedPage = index);
    _controller.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          width:width,
          height: height-106,
          child: PageView(
            onPageChanged: (int index){
              ChangePage(index: index);
            },
            scrollDirection: Axis.horizontal,
            controller: _controller,
            children: [
              page1(),
              note(image:"assets/images/sanitize-hands.png",title: "Wash Your Hands",description: "Wash your hands Regularly for atleast 20 seconds using soap or alcohol based hand sanitiser.",),
              note(image:"assets/images/cleanig-siut.png",title: "Clean And Sanitized Environment",description: "Keep your environment clean by sanitizeing it once in a while or regularly.",),
              note(image:"assets/images/avoid-crowds.png",title: "Crowds",description: "Avoid crowded places, when shopping practice social distancing",),
              note(image:"assets/images/new-mask.png",title: "Mask",description: "Wear a mask when you leave your residence and you're going to a crowded place.",)
            ],
          )
        ),
        Container(
          width:width,
          height: 80.0,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor
          ),
          child: BottomNavigationBar(
            onTap: (int index){
              ChangePage(index:index);
            },
            currentIndex:_selectedPage,
            selectedItemColor: Theme.of(context).primaryColor,
            unselectedItemColor: Colors.grey,
            elevation: 4,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Mdi.numeric1Box),
                title:  Text("1"),
              ),
              BottomNavigationBarItem(
                icon: Icon(Mdi.numeric2Box),
                title:  Text("2"),
              ),
              BottomNavigationBarItem(
                icon: Icon(Mdi.numeric3Box),
                title:  Text("3"),
              ),
              BottomNavigationBarItem(
                icon: Icon(Mdi.numeric4Box),
                title:  Text("4"),
              ),
              BottomNavigationBarItem(
                icon: Icon(Mdi.numeric5Box),
                title:  Text("5"),
              )
            ],
          )
        )
      ],
    );
  }
}

import 'package:covidsafe/pages/CasesPage.dart';
import 'package:covidsafe/pages/HomePage.dart';
import 'package:covidsafe/pages/NewsPage.dart';
import 'package:covidsafe/pages/NotePage.dart';
import 'package:covidsafe/pages/SettingPages.dart';
import 'package:bloc/bloc.dart';

enum NavigationEvents {
  HomePageClickedEvent,
  SettingsPageClickedEvent,
  NewsPageClickedEvent,
  NotesPageClickedEvent,
  CasesPageClickedEvent,
}

abstract class NavigationStates{}


class NavigationBloc extends Bloc<NavigationEvents , NavigationStates>{
  @override
  NavigationStates get initialState => HomePage();

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async*{
    switch(event){
      case NavigationEvents.HomePageClickedEvent:
        yield HomePage();
        break;
      case NavigationEvents.CasesPageClickedEvent:
        yield CasesPage();
        break;
      case NavigationEvents.SettingsPageClickedEvent:
        yield SettingsPage();
        break;
      case NavigationEvents.NotesPageClickedEvent:
        yield NotesPage();
        break;
      case NavigationEvents.NewsPageClickedEvent:
        yield NewsPage();
        break;
    }
  }

}
import 'package:covidsafe/sidebar/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/navigation_bloc.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea( child:BlocProvider<NavigationBloc>(
      create: (context) => NavigationBloc(),
      child: Scaffold(
        body:Stack(
          children: <Widget>[
            BlocBuilder<NavigationBloc,NavigationStates>(
              builder: (context,navigationState){
                return navigationState as Widget;
              },
            ),
            sidebar(),
          ],
        )
      ),
    )
    );
  }
}

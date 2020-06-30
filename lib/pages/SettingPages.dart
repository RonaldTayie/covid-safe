import 'dart:convert';

import 'package:covidsafe/bloc/navigation_bloc.dart';
import 'package:covidsafe/models/user.dart';
import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SettingsPage extends StatefulWidget with NavigationStates{
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isFullName_enabled = false;
  bool _isEmail_enabled = false;
  bool _isCountry_enabled = false;

  TextEditingController FullName = new TextEditingController();
  TextEditingController Country = new TextEditingController();
  TextEditingController Email = new TextEditingController();

  String name;
  String country;
  String email;

  getUser()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.get('user')!=""){
      var u =  json.decode(prefs.get('user'));
      setState(() {
        email = u['Email'].toString().toLowerCase();
        country = u['Country'].toString().toLowerCase();
        name = u['FullName'].toString().toUpperCase();
      });
      print(u);
      return u;

    }

  }

  void updateUser() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    user u = user(
      Country: Country.text!=""?Country.text:"Set Country",
      Email: Email.text!=""?Email.text:"Set Email Address",
      FullName: FullName.text!=""?FullName.text:"Set Full Name"
    );

    var UserJson = userToJson(u);
    prefs.setString("user", UserJson);

    print("Your Data");
    print(UserJson);
  }

  @override
  void initState() {

    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Stack(
      fit:StackFit.expand,
      children: <Widget>[
        Positioned(
          bottom:-40,
          right: -40,
          width: 300,
          height:300,
          child: Stack(
              fit: StackFit.expand,
              children:<Widget>[
                Positioned(
                  bottom: -0,
                  right: -0,
                  child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(100)),
                      child:Container(
                        width:200,
                        height: 200,
                        child: Image.asset("assets/images/globe-33.gif"),
                      )
                  ),
                ),
                Positioned(
                  bottom: -40,
                  right: -40,
                  child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(100)),
                      child:Container(
                        width:280,
                        height: 280,
                        decoration: BoxDecoration(
                            image:  new DecorationImage(
                                image: new AssetImage("assets/images/virus.png"),
                                fit: BoxFit.fill,
                                colorFilter: new ColorFilter.mode(Colors.white.withOpacity(0.5), BlendMode.dstATop)
                            )
                        ),
                      )
                  ),
                ),
              ]
          )
        ),

        Container(
          width:width,
          height:height,
          key: Key("Settings_Container"),
          child: Column(
              children:<Widget>[
                Container(
                    width:width,
                    height: 80,
                    color: Theme.of(context).primaryColor,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children:<Widget>[
                          Container(
                            width:50,
                            height:50,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context).primaryColor
                            ),
                            child: Icon(Icons.settings,size:45,color:Colors.white),
                          ),
                          Text(
                            "Settings",
                            style: TextStyle(
                                fontSize:20,
                                color: Colors.white
                            ),
                          )
                        ]
                    )
                ),
                Expanded(
                  child: Container(
                      width: width,
                      child: ListView(
                          padding: const EdgeInsets.all(5.0),
                          children:<Widget>[
                            Container(
                                height: 150,
                                margin: const EdgeInsets.only(top:12.0),
                                child:Center(
                                    child: Container(
                                      width: 150,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle
                                      ),
                                      child: ClipRRect(
                                          borderRadius: const BorderRadius.all(Radius.circular(90)),
                                          child: Material(
                                            color: Theme.of(context).primaryColor,
                                            borderRadius: const BorderRadius.all(Radius.circular(90)),
                                            elevation: 3,
                                            child: Center(
                                                child: Icon(Mdi.account,size:130,color: Colors.white)
                                            ),
                                          )
                                      ),
                                    )
                                )
                            ),
                            Container(
                                height: 50,
                                child: Center(
                                    child: Text(name==""?name.toString().toUpperCase():"Set Full Name")
                                )
                            ),

                            SizedBox(height:20.0),
                            ListTile(
                              title: TextField(
                                controller: FullName,
                                key: Key("FullName"),
                                decoration: InputDecoration(
                                    disabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.zero
                                    ),
                                    enabled: _isFullName_enabled,
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                                        borderSide: BorderSide(width:1.3,color: Theme.of(context).primaryColor,style:BorderStyle.solid)
                                    ),
                                    labelText: _isFullName_enabled?"Full Name":name,
                                  hintText: name!=null?name:"Set Full name"
                                ),
                              ),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: (){
                                      setState((){
                                        if(_isFullName_enabled){
                                          _isFullName_enabled = false;
                                        } else{
                                          _isFullName_enabled = true;
                                        }
                                      });
                                    },
                                    child: Container(
                                      width:80,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Theme.of(context).primaryColor
                                      ),
                                      padding: const EdgeInsets.all(5.0),
                                      child: Icon(Icons.mode_edit,color:Colors.white),
                                    ),
                                  ),
                                  Text("Edit",style:TextStyle(fontSize:5.0))
                                ],
                              ),
                            ),

                            SizedBox(height:10),
                            ListTile(
                              title: TextField(
                                keyboardType: TextInputType.text,
                                controller: Country,
                                key: Key("countryname"),
                                decoration: InputDecoration(
                                    disabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.zero
                                    ),
                                    enabled: _isCountry_enabled,
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                                        borderSide: BorderSide(width:1.3,color: Theme.of(context).primaryColor,style:BorderStyle.solid)
                                    ),
                                    labelText: _isCountry_enabled?"Country":country.toString().toUpperCase(),
                                    hintText: country !=null?country.toString().toUpperCase():"Country"
                                ),
                              ),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: (){
                                      setState((){
                                        if(_isCountry_enabled){
                                          _isCountry_enabled = false;
                                        } else{
                                          _isCountry_enabled = true;
                                        }
                                      });
                                      print(_isCountry_enabled);
                                    },
                                    child: Container(
                                      width:80,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Theme.of(context).primaryColor
                                      ),
                                      padding: const EdgeInsets.all(5.0),
                                      child: Icon(Icons.mode_edit,color:Colors.white),
                                    ),
                                  ),
                                  Text("Edit",style:TextStyle(fontSize:5.0))
                                ],
                              ),
                            ),


                            SizedBox(height:10),
                            ListTile(
                              title: TextField(
                                keyboardType: TextInputType.emailAddress,
                                controller: Email,
                                key: Key("Email"),
                                decoration: InputDecoration(
                                  disabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.zero
                                  ),
                                  enabled: _isEmail_enabled,
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                                      borderSide: BorderSide(width:1.3,color: Theme.of(context).primaryColor,style:BorderStyle.solid)
                                  ),
                                  labelText: _isEmail_enabled ?"Email Address": !_isEmail_enabled?email:"Email Address",
                                  hintText: email!=null?email:"",
                                ),
                              ),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: (){
                                      setState((){
                                        if(_isEmail_enabled){
                                          _isEmail_enabled = false;
                                        } else{
                                          _isEmail_enabled = true;
                                        }
                                      });
                                      print(_isCountry_enabled);
                                    },
                                    child: Container(
                                      width:80,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Theme.of(context).primaryColor
                                      ),
                                      padding: const EdgeInsets.all(5.0),
                                      child: Icon(Icons.mode_edit,color:Colors.white),
                                    ),
                                  ),
                                  Text("Edit",style:TextStyle(fontSize:5.0))
                                ],
                              ),
                            ),

                            SizedBox(height:30),
                            Center(
                                child: Container(
                                    width:200,
                                    child: RaisedButton(
                                      color: Theme.of(context).primaryColor,
                                      onPressed: (){
                                        updateUser();
                                        @override
                                        void reassemble() {
                                          getUser();
                                          super.reassemble();
                                        }
                                      },
                                      child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children:<Widget>[
                                            Text(
                                                "Save",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize:18.0
                                                )
                                            ),
                                            Icon(Icons.save,size: 25.0,color:Colors.white,)
                                          ]
                                      ),
                                      splashColor: Colors.white,
                                    )
                                )
                            )

                          ]
                      )
                  ),
                )
              ]
          )
      ),


      ],
    );
  }
}


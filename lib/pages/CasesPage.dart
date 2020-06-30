import 'package:connectivity/connectivity.dart';
import 'package:covidsafe/bloc/navigation_bloc.dart';
import 'package:covidsafe/models/country_model.dart';
import 'package:covidsafe/pages/countryCases.dart';
import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class CasesPage extends StatefulWidget with NavigationStates{
  @override
  _CasesPageState createState() => _CasesPageState();
}

class _CasesPageState extends State<CasesPage> {

  bool _isSearchOpen = false;
  TextEditingController search = new TextEditingController();
  String _searchTerm;
  bool _isSearchInView = false;

  //Check Connection
  bool _isOnline=false;

  void _Conn()async{
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      print("Connection is mobile");
      setState(()=>_isOnline=true);
    } else if (connectivityResult == ConnectivityResult.wifi) {
      print("Connection is wifi");
      setState(()=>_isOnline=true);
    } else {
      setState(()=>_isOnline=false);
    }
    print(_isOnline);
  }

  //Search country by name
  SearchCoutry()async{
    //get data from the Shared Preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var cases = prefs.get('cases');

    if(cases!=""){
      if(_case.length>0){

        List <country_model> country_name = [];

        for(int i=0;i<_case.length;i++){
          if(_case[i].name==search.text.toLowerCase()){
            country_name.add(_case[i]);
            setState(()=> _Searchcase = country_name);
            setState(()=> _isSearchInView = true);
            break;
          }else{
            print("#");
          }
        }

      }
    }
  }

  //ON INITSTATE run and check the connection
  @override
  void initState() {
    _Conn();
    super.initState();
  }
  
  //Get the cases From the API. If there is a connection get Data from API and overwrite the stored Data

  List <country_model> _case = [];
  List <country_model> _Searchcase = [];

  _loadCases()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var cases="";
    print(_isOnline);
    if(_isOnline==true){
      var url = "http://jmldemo.000webhostapp.com/parser.php?request=all";
      try{
        var resp = await http.get(url);
        if(resp.statusCode==200){
          cases = resp.body;
          prefs.setString('cases', cases);
        }else{
          cases = prefs.get('cases');
        }
      }catch(e){
        if(prefs.get('cases')!=""){
          cases = prefs.get('cases');
        }else{
          cases = null;
        }
      }
    }else{
      cases = prefs.get('cases');
    }

    if(cases!=""){
      var json = convert.json.decode(cases);
      List <country_model> countries = [];
      for(var u in json){
        country_model country = country_model(
            name: u['CountryOther'],
            totalCase: u['TotalCases'],
            newCase: u['NewCases'],
            totalDeath: u['TotalDeaths'],
            newDeath: u['NewDeaths'],
            totalRecovered: u['TotalRecovered'],
            seriousUser: u['SeriousCritical'],
            code: u['code'],
            totalTests: u['TotalTests']
        );
        countries.add(country);
      }
      setState(() {
        this._case = countries;
      });
      print(countries.length);
      return countries;
    }
  }
  void openSearch(){
    setState(() =>_isSearchOpen = _isSearchOpen?false:true);
  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    Color primaryColor = Theme.of(context).primaryColor;
    return Container(
        width:width,
        height:height,
        child:Stack(
            fit:StackFit.expand,
            children:<Widget>[
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
                width: width,
                height: height,
                padding: const EdgeInsets.all(5.0),
                child:Container(
                      child: _isSearchInView==true? Container(
                          child:Center(
                              child:Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: ()=> Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context)=>countryCases(country: _Searchcase[0],)
                                        )
                                    ),
                                    child: Container(
                                      width:width,
                                      height: 150,
                                      padding: const EdgeInsets.all(5.0),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          color: Colors.black.withOpacity(0.1),
                                          borderRadius: const BorderRadius.all(Radius.circular(20.0))
                                      ),
                                      child:Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children:<Widget>[
                                                Container(
                                                  width:50,
                                                  height:50,
                                                  decoration:BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Theme.of(context).primaryColor
                                                  ),
                                                  child: CircleAvatar(
                                                    backgroundColor: Colors.transparent,
                                                    child: _Searchcase[0].code==null?
                                                    Icon(Icons.flag,color: Colors.grey,size:20):
                                                    Image(
                                                        image: NetworkImage("https://www.countryflags.io/"+_Searchcase[0].code+"/flat/64.png",),
                                                        width:40,
                                                        height: 40,
                                                        colorBlendMode: BlendMode.darken
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width:20),
                                                Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children:<Widget>[
                                                      Text(_Searchcase[0].name,
                                                          style:TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 25.0,
                                                          )
                                                      ),
                                                      SizedBox(height:10),
                                                      Row(
                                                        children: <Widget>[
                                                          Icon(Icons.local_hospital,size:30,color:Colors.redAccent),
                                                          Text("Case:"+ _Searchcase[0].totalCase),
                                                          SizedBox(width:20),
                                                          Icon(Mdi.accountConvert,color:Colors.green,size:30),
                                                          Text("Recoveries:"+ _Searchcase[0].totalRecovered)
                                                        ],
                                                      ),
                                                    ]
                                                )
                                              ]
                                          ),
                                    ),
                                  ),

                                  SizedBox(height:20.0),
                                  Container(
                                      width:width,
                                      child: Center(
                                          child: Container(
                                              width:150,
                                              height:150,
                                              decoration:BoxDecoration(
                                                  shape: BoxShape.circle
                                              ),
                                              child: ClipRRect(
                                                borderRadius: const BorderRadius.all(Radius.circular(80.0)),
                                                child: RaisedButton(
                                                    onPressed: (){
                                                      setState(() {
                                                        _isSearchInView = false;
                                                      });
                                                    },
                                                    elevation:4,
                                                    color:primaryColor,
                                                    child: Container(
                                                        width:150,
                                                        height:150,
                                                        child:Column(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            children:<Widget>[
                                                              Icon(Mdi.close,size:50,color:Colors.white),
                                                              Text("Close Search",
                                                                  style: TextStyle(
                                                                      fontSize:10.0,
                                                                      color:Colors.white
                                                                  )
                                                              )
                                                            ]
                                                        )
                                                    )
                                                ),
                                              )
                                          )
                                      )
                                  )
                                ],
                              )
                          )
                      ):
                      FutureBuilder(
                        future: _isSearchOpen==true?SearchCoutry():_loadCases(),
                        // ignore: missing_return
                        builder: (BuildContext context,AsyncSnapshot snapshot){
                          if(snapshot.data==null){
                            return Container();
                          }else{
                            return ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context,int index){
                                if(index==0){
                                  return Container();
                                }else {

                                  return Container(
                                      width:double.infinity,
                                      height: 70.0,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10)),
                                          border: Border.all(style: BorderStyle.solid,color: Colors.grey,width: 1.5),
                                          shape: BoxShape.rectangle
                                      ),
                                      margin: const EdgeInsets.only(bottom:5),
                                      child:ListTile(
                                        enabled: true,
                                        title: Text(
                                            _capitalize(snapshot.data[index].name),
                                            style: TextStyle(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: 3,
                                              fontSize: 20,
                                            )
                                        ),
                                        subtitle: Row(
                                          children: <Widget>[
                                            Icon(Icons.local_hospital,size:20,color:Colors.redAccent),
                                            Text("Case:"+snapshot.data[index].totalCase),
                                            SizedBox(width:20),
                                            Icon(Mdi.accountConvert,color:Colors.green,size:20),
                                            Text("Recoveries:"+snapshot.data[index].totalRecovered)
                                          ],
                                        ),
                                        leading: CircleAvatar(
                                          backgroundColor: Colors.transparent,
                                          child: snapshot.data[index].code==null?
                                          Icon(Icons.flag,color: Colors.grey,size:20):
                                          Image(
                                              image: NetworkImage("https://www.countryflags.io/"+snapshot.data[index].code+"/flat/64.png"),
                                              width:40,
                                              height: 40,
                                              colorBlendMode: BlendMode.darken
                                          ),
                                        ),
                                        onTap: (){
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context)=>countryCases(country: snapshot.data[index],)
                                              )
                                          );
                                        },
                                      )
                                  );
                                }
                              },
                            );
                          }

                        },
                      ),
                    ),
              ),

              Positioned(
                  top:20,
                  right:10,
                  width:50,
                  height:50,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: (){
                      openSearch();
                    },
                    child: Material(
                      elevation: 4,
                      color: _isSearchOpen?Colors.white:Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      child: Center(
                          child: Icon(Icons.search,size:30.0,color: _isSearchOpen?primaryColor:Colors.white)
                      ),
                    ),
                  )
              ),
              AnimatedPositioned(
                duration: Duration(milliseconds: 500),
                top: _isSearchOpen?70:-120,
                right: 50,
                left:50,
                child: Container(
                  width:320,
                  height:60,
                  child: Center(
                    child: Material(
                      elevation:3,
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      child: Container(
                        width: 320,
                        height:60,
                        decoration:BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        child: ListTile(
                          trailing: GestureDetector(
                            onTap: (){
                              SearchCoutry();
                              print(search.text);
                            },
                            child: Container(
                              width:50,
                              height:50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:primaryColor
                              ),
                              child:Center(
                                child: Icon(Icons.search,size:50,color: Colors.white)
                              )
                            ),
                          ),
                          title: TextField(
                            controller: search,
                            decoration:  InputDecoration(
                              contentPadding: const EdgeInsets.all(3.5),
                              labelText: "Country Name",
                              enabled: _isSearchOpen,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                                borderSide: BorderSide(color: primaryColor,style: BorderStyle.solid,width: 1.3)
                              ),
                              disabledBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(Radius.circular(60.0)),
                                  borderSide: BorderSide(color: Colors.grey,style: BorderStyle.solid,width: 1.3)
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(Radius.circular(60.0)),
                                  borderSide: BorderSide(color: Colors.grey,style: BorderStyle.solid,width: 1.3)
                              )
                            ),
                          ),
                        )
                      )
                    ),
                  ),
                )
              )
            ]
        )
    );
  }
  _capitalize(String str){
    return '${str[0].toUpperCase()}${str.substring(1)}';
  }

}


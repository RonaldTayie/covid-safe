import 'package:covidsafe/models/country_model.dart';
import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';

class countryCases extends StatelessWidget {
  final country_model country;

  countryCases({this.country});
  @override
  Widget build(BuildContext context) {

    var width  = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    String name = this.country.name.toUpperCase();

    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        bottomOpacity: 25.0,
        elevation: 9.0,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Positioned(
              bottom:-80,
              left: -80,
              width: 300,
              height:300,
              child: Stack(
                  fit: StackFit.expand,
                  children:<Widget>[
                    Positioned(
                      bottom: 40,
                      right: 40,
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
                      bottom: 0,
                      right: 0,
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
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Container(
                        height:200,
                        width:200,
                        decoration:BoxDecoration(
                            color:Colors.red,
                            shape: BoxShape.circle
                        ),
                      child: Center(
                        child: Image(image: NetworkImage("https://www.countryflags.io/"+country.code+"/flat/64.png"),fit: BoxFit.fill,width:100,height: 100,),
                      ),
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        child:Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  width:width*0.4,
                                  height: 200.0,
                                  decoration: BoxDecoration(
                                    color: Colors.redAccent,
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(Icons.local_hospital,size:60,color:Colors.white),
                                        SizedBox(height:20),
                                        Text(
                                            "Total Cases",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 25,
                                                letterSpacing: 2,
                                                color: Colors.white
                                            )
                                        ),
                                        SizedBox(height: 20,),
                                        Text(
                                            this.country.totalCase.toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 20,
                                                letterSpacing: 2,
                                                color: Colors.white
                                            )
                                        )
                                      ]
                                    ),
                                  )
                                ),
                                Container(
                                  width:width*0.4,
                                  height: 200.0,
                                  decoration: BoxDecoration(
                                    color: Colors.redAccent,
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.all(Radius.circular((20.0))),
                                  ),
                                  child: Center(
                                    child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(Mdi.accountConvert,color:Colors.white,size:60),
                                          SizedBox(height:20),
                                          Text(
                                              "Recoveries",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 25,
                                                  letterSpacing: 2,
                                                  color: Colors.white
                                              )
                                          ),
                                          SizedBox(height: 20,),
                                          Text(
                                              this.country.totalRecovered.toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 20,
                                                  letterSpacing: 2,
                                                  color: Colors.white
                                              )
                                          )
                                        ]
                                    ),
                                  )
                                )
                              ],
                            )
                      ),

                      SizedBox(height: 20,),
                      Container(
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                                width:width*0.4,
                                height: 200.0,
                                decoration: BoxDecoration(
                                  color: Colors.redAccent,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                ),
                                child: Center(
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(Mdi.skullCrossbonesOutline,color:Colors.white,size:60),
                                        SizedBox(height:20),
                                        Text(
                                            "Deaths",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 25,
                                                letterSpacing: 2,
                                                color: Colors.white
                                            )
                                        ),
                                        SizedBox(height: 20,),
                                        Text(
                                            this.country.totalDeath.toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 20,
                                                letterSpacing: 2,
                                                color: Colors.white
                                            )
                                        )
                                      ]
                                  ),
                                )
                            ),
                            Container(
                                width:width*0.4,
                                height: 200.0,
                                decoration: BoxDecoration(
                                  color: Colors.redAccent,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.all(Radius.circular((20.0))),
                                ),
                                child: Center(
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(Icons.flag,color:Colors.white,size:60),
                                        SizedBox(height:20),
                                        Text(
                                          "New Cases",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 25,
                                            letterSpacing: 2,
                                            color: Colors.white
                                          )
                                        ),
                                        SizedBox(height: 20,),
                                        Text(
                                            this.country.newCase.toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 20,
                                                letterSpacing: 2,
                                                color: Colors.white
                                            )
                                        )
                                      ]
                                  ),
                                )
                            )
                          ],
                          ),
                      ),

                      SizedBox(height: 20,),
                      Container(
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                                width:width*0.4,
                                height: 200.0,
                                decoration: BoxDecoration(
                                  color: Colors.redAccent,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                ),
                                child: Center(
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(Mdi.biohazard,color:Colors.white,size:60),
                                        SizedBox(height:20),
                                        Text(
                                            "Active Cases",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 25,
                                                letterSpacing: 2,
                                                color: Colors.white
                                            )
                                        ),
                                        SizedBox(height: 20,),
                                        Text(
                                            this.country.seriousUser.toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 20,
                                                letterSpacing: 2,
                                                color: Colors.white
                                            )
                                        )
                                      ]
                                  ),
                                )
                            ),
                            Container(
                                width:width*0.4,
                                height: 200.0,
                                decoration: BoxDecoration(
                                  color: Colors.redAccent,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.all(Radius.circular((20.0))),
                                ),
                                child: Center(
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(Mdi.testTube,color:Colors.white,size:60),
                                        SizedBox(height:20),
                                        Text(
                                          "Tests",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 25,
                                            letterSpacing: 2,
                                            color: Colors.white
                                          )
                                        ),
                                        SizedBox(height: 20,),
                                        Text(
                                            this.country.totalTests.toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 20,
                                                letterSpacing: 2,
                                                color: Colors.white
                                            )
                                        )
                                      ]
                                  ),
                                )
                            )
                          ],
                          ),
                      )
                    ],
                  )

                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}

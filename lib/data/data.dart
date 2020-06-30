import 'package:covidsafe/data/DataStorage.dart';
import 'package:covidsafe/models/country_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;
Connectivity connectivity = Connectivity();

Future <bool> isInternetConnected()async{
  Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
    if(result==ConnectivityResult.mobile||result == ConnectivityResult.wifi){
      print("Connected");
      return true;
    }else{
      print("No conection");
      return false;
    }
  });
}

class data{

  _Shared()async{
    return SharedPreferences.getInstance();
  }

}
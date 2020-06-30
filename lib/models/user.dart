import 'dart:convert';

user userFromJson(String str) => user.fromjson(json.decode(str));
String userToJson(user data) => json.encode(data.toJson());

class user{
  // ignore: non_constant_identifier_names
  String FullName;
  String Email;
  String Country;

  user({this.FullName,this.Email,this.Country});

  factory user.fromjson(Map<String,dynamic> json) => user (
    FullName:json['FullName'],
    Email: json['Email'],
    Country: json['Country']

  );

  Map<String,dynamic> toJson() =>{
    "FullName": FullName,
    "Email":Email,
    "Country":Country
  };

}
import 'package:covidsafe/models/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class DBProvider{
  DBProvider._();
  static final db = DBProvider._();
  static Database _database;

  Future <Database> get database async{
    return _database !=null?_database:await initDB();
  }

  initDB() async {
    return await openDatabase(
      join(
        await getDatabasesPath(),"covidsafe.db"
      ),
      onCreate: (db,version)async{
        await db.execute('''
          CREATE TABLE user ( 'Fullname' TEXT NOT NULL , 'Country' TEXT NOT NULL , 'Email' VARCHAR(35) NOT NULL PRIMARY KEY ) ENGINE = InnoDB;
        ''');
      },
      version: 1
    );
  }

  newUser(user newUser) async{

    var FullName = newUser.FullName;
    var Country= newUser.Country;
    var Email = newUser.Email;

    final db = await database;
    var resp = await db.rawInsert(''' INSERT INTO `user` (FullName,Country,Email) VALUES (?,?,?)''',[FullName,Country,Email]);
    return resp;
  }

  Future <dynamic> getUser()async{
    final db = await database;
    var resp = await db.query("user");

    if(resp.length<1){
      return null;
    }else{
      var respMap = resp[0];
      return respMap.isNotEmpty? respMap:null;
    }

  }

}
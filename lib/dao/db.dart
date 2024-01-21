import 'package:sqflite/sqflite.dart';

Future<Database> getdb ()async{
  var dbpath = await getDatabasesPath();
  final path = join(dbpath,'');

  return openDatabase(path, version: 1, onCreate: (Database db, int version){
    db.execute('');
  });



}
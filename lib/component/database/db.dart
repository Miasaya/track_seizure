import 'package:path/path.dart'; 
import 'package:sqflite/sqflite.dart';
import 'package:track_seizure/component/seizure_data.dart';
import 'dart:async';

class DatabaseService{
  static final DatabaseService _instance = DatabaseService._internal(); 

  Future<Database> database; 

  factory DatabaseService(){
    return _instance;
  }
  DatabaseService._internal(){
    initDataBase(); 
  }

  initDataBase() async {
    database = openDatabase(
      join(await getDatabasesPath(),'seizure_db.db'), 
      onCreate: (db,version){
        return db.execute(
          "CREATE TABLE seizures(date DATE PRIMARY KEY, type STRING, length INT, feel INT, note STRING)",);
        }, 
    version: 1
    );
  }
  Future<void> createSeize(Seizure seizure) async {
    final Database db = await database; 
    await db.insert('seizures', seizure.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateSeize(Seizure seizure) async {
    final Database db = await database; 
    await db.update('seizures', seizure.toMap(),where: "date = ?",whereArgs: [seizure.date]);
  }

  Future<void> deleteSeize(DateTime date) async {
    final Database db = await database; 
    await db.delete('seizures', where: "date = ?",whereArgs: [date]);
  }
}



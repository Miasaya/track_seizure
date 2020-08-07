import 'package:path/path.dart'; 
import 'package:sqflite/sqflite.dart';
import 'package:track_seizure/component/seizure_data.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DatabaseService{
  DatabaseService._();
  static final DatabaseService db = DatabaseService._(); 
  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database; 
    _database = await initDataBase(); 
    return _database;
  }

  initDataBase() async {
    Directory directory = await getApplicationSupportDirectory(); 
    String path = join(directory.path,'seizure_db.db');
    return openDatabase(
      path, 
      onCreate: (Database db, int version) async {
        db.execute(
          "CREATE TABLE seizures(date TEXT PRIMARY KEY, type TEXT, length INT, feel INT, note TEXT)",);
        }, 
    version: 1
    );
  }
  createSeize(Seizure seizure) async {
    final Database db = await database; 
    await db.insert('seizures', seizure.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
  }

  updateSeize(Seizure seizure) async {
    final Database db = await database; 
    await db.update('seizures', seizure.toMap(),where: "date = ?",whereArgs: [seizure.date]);
  }

  deleteSeize(String date) async {
    final Database db = await database; 
    await db.delete('seizures', where: "date = ?",whereArgs: [date]);
  }
  
  Future<List<Seizure>> getAllSeizures() async {
    final db = await database;
    var response = await db.query("seizures"); 
    return List.generate(response.length, (i) {
    return Seizure(
      date: response[i]['date'],
      type: response[i]['type'],
      length: response[i]['length'],
      feel: response[i]['feel'],
      note: response[i]['note']
    );
  });
  }
}



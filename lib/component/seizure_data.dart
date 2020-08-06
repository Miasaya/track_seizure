import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

enum Type { absence, tc, other }

class Seizure {
  final DateTime date; 
  final Type type; 
  final int length;
  final int feel;
  final String note;

  Seizure({this.date,this.feel,this.length,this.note,this.type});

  Map<String,dynamic> toMap(){
    return {
      'date': date, 
      'type': type, 
      'length': length, 
      'feel' : feel, 
      'note' : note,
    };
  }
}

final Future<Database> database = openDatabase(
  join(await getDatabasePath(),'seizure_db.db'), 
  onCreate: (db,version){
    return db.execute(
      "CREATE TABLE seizures(date DATE PRIMARY KEY, type STRING, length INT, feel INT, note STRING)",);
  }, 
  version: 1,
); 

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
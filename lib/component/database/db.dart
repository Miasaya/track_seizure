import 'package:path/path.dart'; 
import 'package:sqflite/sqflite.dart';
import 'package:track_seizure/component/seizure_data.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'FilesFunctions.dart';
import 'package:file_picker/file_picker.dart';
import 'package:csv/csv.dart';


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

  deleteAll() async {
    final Database db = await database; 
    await db.delete('seizures');
  }
  
  
  Future<List<Seizure>> getAllSeizures() async {
    DateFormat format = DateFormat("dd-MM-yy – kk:mm");
    final db = await database;
    var response = await db.query("seizures"); 
    List<Seizure> listOfAll = List.generate(response.length, (i) {
      return Seizure(
        date: response[i]['date'],
        type: response[i]['type'],
        length: response[i]['length'],
        feel: response[i]['feel'],
        note: response[i]['note']
      );
    }
    );
    listOfAll.sort((a,b) => ((format.parse(b.date)).compareTo((format.parse(a.date)))));
    return (listOfAll);
  }

  export() async {
    String path = '/storage/emulated/0/Documents';
    List<Map<String,dynamic>> result= [];
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }

    print(path);

    var data = await db.getAllSeizures();
    for (int i = 0; i < data.length; i++){
      result.add(data[i].toMap());
    }
    var csv = mapListToCsv(result);

    File file = File('$path/ListOfSeizures.csv');
    file.writeAsString(csv);
  }

  import() async {
    try {
      File file = await FilePicker.getFile(
        type: FileType.custom,
        allowedExtensions:['csv'],
      );
      //Read the file 
      String contents = await file.readAsString();
      List<List<dynamic>> results = CsvToListConverter().convert(contents);
      results.removeAt(0);
      // Create the list of seizures
      db.deleteAll();
      for (List elem in results) {
        Seizure s = Seizure(
          date: elem[0],
          type: elem[1],
          length: elem[2],
          feel: elem[3],
          note :elem[4]);  
        db.createSeize(s);
      }

    } catch (e) {
      // If we encounter an error, return 0
      return e;
    }
  }
}




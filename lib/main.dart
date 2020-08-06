import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:track_seizure/component/database/db.dart';
import 'screens/home.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  DatabaseService();
  runApp(MyApp());
  }

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Seizure Tracking App', 
      home: HomePage()
    );
  }
}
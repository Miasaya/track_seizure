import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:track_seizure/component/localNotifications.dart';
import 'package:track_seizure/screens/signIn.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Notifications();
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  runApp(MyApp());
  }

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Seizure Tracking App', 
      home: LoginPage()
    );
  }
}
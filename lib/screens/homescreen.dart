import 'package:flutter/material.dart';
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Track your Seizures',
        theme: ThemeData(
          primarySwatch: Colors.blue,

          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Scaffold(
          backgroundColor: Colors.white10,
          body: Container(
              child: Center(child: Text('This is my seizure tracking app'))),
        ));
  }
}

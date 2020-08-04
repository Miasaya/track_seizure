import 'package:flutter/material.dart';
import 'package:track_seizure/component/constants.dart';

class TrackingPage extends StatefulWidget {
  TrackingPage({Key key}) : super(key: key);

  @override
  _TrackingPageState createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Center(
            child: Text(
              'Anything up today?',
              style: trackHeaderStyle,
            ),
          )
        ],
      ),
    );
  }
}

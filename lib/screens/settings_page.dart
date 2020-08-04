import 'package:flutter/material.dart';
import 'package:track_seizure/component/constants.dart';

class SettingPage extends StatefulWidget {
  SettingPage({Key key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Center(
            child: Text(
              'Setting Screen',
              style: trackHeaderStyle,
            ),
          )
        ],
      ),
    );
  }
}

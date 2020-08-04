import 'package:flutter/material.dart';
import 'package:track_seizure/component/constants.dart';

class StatsPage extends StatefulWidget {
  StatsPage({Key key}) : super(key: key);

  @override
  _StatsPageState createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          Center(
            child: Text(
              'Here\'s your monthly statistics',
              style: trackHeaderStyle,
            ),
          )
        ],
      );
  }
}

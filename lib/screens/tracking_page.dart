import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


import 'package:track_seizure/component/constants.dart';
import 'package:track_seizure/component/header.dart';

class TrackingPage extends StatefulWidget {
  TrackingPage({Key key}) : super(key: key);

  @override
  _TrackingPageState createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Header(),
        Center(
          child: Text(
            'Anything up today?',
            style: trackHeaderStyle,
          ),
        )
      ],
    );
  }
}


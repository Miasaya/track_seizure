import 'package:flutter/material.dart';

import 'package:track_seizure/component/constants.dart';
import 'package:track_seizure/component/header.dart';
import 'package:track_seizure/component/entryComponents.dart';
import 'new_entry.dart';

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
        Text(
          'Anything up today?',
          style: trackHeaderStyle,
        ),
        SizedBox(
          height: 30.0,
        ),
        EntryButton(
          text: 'Track',
          onPress: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return NewEntryPage();
            }));
          },
        ),
        SizedBox(
          height: 40.0,
        ),
      ],
    );
  }
}

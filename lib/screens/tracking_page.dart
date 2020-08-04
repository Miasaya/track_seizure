import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:track_seizure/component/constants.dart';
import 'package:track_seizure/component/header.dart';
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
        Container(
          height: 50.0,
          child: RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context){
              return NewEntryPage();
              }
              ));
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(80.0)),
            padding: EdgeInsets.all(0.0),
            child: Ink(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF554BD8),
                      Color(0xFF804CD9),
                    ],
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                  ),
                  borderRadius: BorderRadius.circular(30.0)),
              child: Container(
                constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                alignment: Alignment.center,
                child: Text(
                  "Track",
                  textAlign: TextAlign.center,
                  style: kTrackingButton,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 40.0,),
      ],
    );
  }
}

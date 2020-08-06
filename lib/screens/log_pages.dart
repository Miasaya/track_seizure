import 'package:flutter/material.dart';
import 'package:track_seizure/component/constants.dart';

class LogPage extends StatefulWidget {
  LogPage({Key key}) : super(key: key);

  @override
  _LogPageState createState() => _LogPageState();
}

class _LogPageState extends State<LogPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          SizedBox(height: 20),
          Center(
            child: Text(
              'Here\' your logs',
              style: trackHeaderStyle,
            ),
          ), 
          ListView.builder(
            itemBuilder: (context,index){
              return Card(
                child:Column(
                  children: [
                    Text('Date'), 
                    Text('Informations')
                  ],
                )
              );
            },
            itemCount: 5,
          )
        ],
      );
  }
}

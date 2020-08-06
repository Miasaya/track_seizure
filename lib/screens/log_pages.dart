import 'package:flutter/material.dart';
import 'package:track_seizure/component/constants.dart';
import 'package:track_seizure/component/database/db.dart';
import 'package:track_seizure/component/seizure_data.dart';

class LogPage extends StatefulWidget {
  LogPage({Key key}) : super(key: key);

  @override
  _LogPageState createState() => _LogPageState();
}

class _LogPageState extends State<LogPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Seizure>>(
      future: DatabaseService.db.getAllSeizures(),
      builder: (BuildContext context, AsyncSnapshot <List<Seizure>> snapshot){
        if (snapshot.hasData){
          return ListView.builder(
            physics: BouncingScrollPhysics(), 
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index){
              Seizure elem = snapshot.data[index]; 
              return Card(
                child: ListTile(
                  title: Text(elem.date,style:  trackHeaderStyle ),
                  subtitle: Text(elem.type, style : kEntryDate),
                ),
              );
            },
          );
        } else {
          return Center(
            child: Text("There's no entry yet.", style: trackHeaderStyle,) 
            );
        }
      }
    );
  }
}

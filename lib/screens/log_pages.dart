import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:track_seizure/component/constants.dart';
import 'package:track_seizure/component/database/db.dart';
import 'package:track_seizure/component/header.dart';
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
          return Stack(
            children: [
              LogHeader(),
              DraggableScrollableSheet(
                initialChildSize: 0.90,
                maxChildSize: 0.90,
                builder: (context, scrollController) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      ),
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(), 
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index){
                        Seizure elem = snapshot.data[index]; 
                        return Card(
                          child: ListTile(
                            title: Text(elem.date, style:  trackHeaderStyle ),
                            subtitle: Text(elem.type, style : kEntryDate),
                            trailing: Icon(Feather.chevron_right),
                          ),
                        );
                      },
                    ),
                  );
                }
              ),
            ],
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

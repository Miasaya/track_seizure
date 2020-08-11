import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:track_seizure/component/constants.dart';
import 'package:track_seizure/component/database/db.dart';
import 'package:track_seizure/component/header.dart';
import 'package:track_seizure/component/seizure_data.dart';
import 'package:track_seizure/component/Log_StatsComponents.dart';

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
              LogHeader(text: "Recent Entries"),
              DraggableScrollableSheet(
                initialChildSize: 0.90,
                maxChildSize: 0.90,
                builder: (context, scrollController) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topRight : Radius.circular(40.0),topLeft: Radius.circular(40.0))
                      ),
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(), 
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index){
                        Seizure elem = snapshot.data[index]; 
                        return ListTile(
                          title: Text(elem.date, style:  kLogDateStyle ),
                          subtitle: Text(elem.type, style : kLogTypeStyle),
                          trailing: Icon(Feather.chevron_right),
                          onTap: () {
                            showBottomSheet(
                              context: context, 
                              builder: (context) => BottomSheetContainer(entry: elem,) //TODO: Change the style to make it more friendly
                              );
                          },
                        );
                      },
                    ),
                  );
                }
              ),
            ],
          );
        } else {
          return NoDataWidget();
        }
      }
    );
  }
}



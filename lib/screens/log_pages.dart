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
          return Center(
            child: Text("There's no entry yet.", style: trackHeaderStyle,) 
            );
        }
      }
    );
  }
}

class BottomSheetContainer extends StatelessWidget {

  BottomSheetContainer({@required this.entry});

  final Seizure entry; 
  

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 270, 
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topRight : Radius.circular(40.0),topLeft: Radius.circular(40.0)),
        boxShadow: [
          BoxShadow(blurRadius :5, color : kLogListShadow,spreadRadius: 2, offset: Offset(0, -3.0))
        ]
        ),
      child: Padding(
        padding: const EdgeInsets.only(left: 25,right: 25,),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children : [
            Center(
              child: IconButton(
                icon: Icon(Feather.chevron_up),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            Text("Summary of the seizure: ", style:  kLogDateStyle ),
            SizedBox(height: 14,),
            Text("TIME: " + entry.date, style:  kLogTypeStyle ),
            Text("TYPE: " + entry.type, style : kLogTypeStyle),
            Text("LENGTH: " + entry.length.toString() +" sec",style:kLogTypeStyle),
            Text("INTENSITY: " + entry.feel.toString() +" /10",style:kLogTypeStyle),
            Text("NOTES: " + entry.note ,style:kLogTypeStyle),
            SizedBox(height: 14,),
            Center(
              child: RaisedButton(
                onPressed: (){
                  DatabaseService.db.deleteSeize(entry.date);
                  Navigator.pop(context);
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                color: Colors.red[400],
                child: Container(
                  height: 42,
                  width: 150,
                  child: Icon(Feather.trash,color: Colors.white,)
                  ),
              ),
            )
            ]
          ),
      ),
      );
  }
}

import 'package:flutter/material.dart';
import 'seizure_data.dart';
import 'constants.dart';
import 'database/db.dart';
import 'package:flutter_icons/flutter_icons.dart';


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

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Image.asset("assets/images/404.jpg"),
          Text(
            "There's no entries yet.",
            style: trackHeaderStyle,
          ),
        ],
      ),
    );
  }
}
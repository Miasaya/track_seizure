import 'package:flutter/material.dart';
import 'seizure_data.dart';
import 'constants.dart';
import 'database/db.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:track_seizure/screens/new_entry.dart';


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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
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
                      width: 100,
                      child: Icon(Feather.trash,color: Colors.white,)
                      ),
                  ),
                  RaisedButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return NewEntryPage(seizeEntry: entry,);
                      }));
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    color: kTopGradientColor,
                    child: Container(
                      height: 42,
                      width: 100,
                      child: Icon(Feather.edit_2,color: Colors.white,)
                      ),
                  ),
                ],
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

class Indicator extends StatelessWidget {
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color textColor;

  const Indicator({
    Key key,
    this.color,
    this.text,
    this.isSquare,
    this.size = 16,
    this.textColor = const Color(0xFF707070),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: textColor,fontFamily: 'Open'),
        )
      ],
    );
  }
}

class PieChartTypeLabel extends StatelessWidget {
  const PieChartTypeLabel({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Indicator(
          color: kAbsenceColor,
          text: 'Absence',
          isSquare: true,
        ),
        SizedBox(
          height: 4,
        ),
        Indicator(
          color: kGeneralizedColor,
          text: 'Generalized',
          isSquare: true,
        ),
        SizedBox(
          height: 4,
        ),
        Indicator(
          color: kOtherColor,
          text: 'Other',
          isSquare: true,
        ),
      ]
    );
  }
}

BarChartGroupData makeGroupData(int x, int y1, int y2, int y3) {
    return BarChartGroupData(barsSpace: 4, x: x, barRods: [
      BarChartRodData(
        y: (y1+y2+y3).toDouble(),
        width: 15,
        rodStackItems: [
          BarChartRodStackItem(0, y1.toDouble(), kAbsenceColor),
          BarChartRodStackItem(y1.toDouble(), (y1+y2).toDouble(), kGeneralizedColor),
          BarChartRodStackItem((y1+y2).toDouble(), (y1+y2+y3).toDouble(), kOtherColor),]
      ),
    ]);
  }
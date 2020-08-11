import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:track_seizure/component/constants.dart';
import 'package:track_seizure/component/database/db.dart';
import 'package:track_seizure/component/header.dart';
import 'package:track_seizure/component/seizure_data.dart';
import 'package:track_seizure/component/Log_StatsComponents.dart';

class StatsPage extends StatefulWidget {
  StatsPage({Key key}) : super(key: key);

  @override
  _StatsPageState createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  int touchedIndex;
  List<Seizure> snapshotList;

  List<PieChartSectionData> _showingSections(List<Seizure> snapshot) {
    List percentage = getPercentageType(snapshot);
    
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 20 : 15;
      final double radius = isTouched ? 60 : 60;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: kAbsenceColor,
            value: percentage[0],
            title: "${percentage[0]}%",
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: kGeneralizedColor,
            value: percentage[1],
            title: "${percentage[1]}%",
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: kOtherColor,
            value: percentage[2],
            title: "${percentage[2]}%",
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        default:
          return null;
      }
    });
  }

  PieChart buildPieChart() {
    return PieChart(
      PieChartData(
        pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
          setState(() {
            if (pieTouchResponse.touchInput is FlLongPressEnd ||
                pieTouchResponse.touchInput is FlPanEnd) {
              touchedIndex = -1;
            } else {
              touchedIndex = pieTouchResponse.touchedSectionIndex;
            }
          });
        }),
        borderData: FlBorderData(
          show: false,
        ),
        sectionsSpace: 0,
        centerSpaceRadius: 40,
        sections: _showingSections(snapshotList))
    );
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Seizure>>(
        future: DatabaseService.db.getAllSeizures(),
        builder: (BuildContext context, AsyncSnapshot<List<Seizure>> snapshot) {
          if (snapshot.hasData) {
            snapshotList = snapshot.data;
            return Stack(children: [
              LogHeader(text: "Statistics"),
              DraggableScrollableSheet(
                  initialChildSize: 0.90,
                  maxChildSize: 0.90,
                  builder: (context, scrollController) {
                    return Container(
                      padding: EdgeInsets.only(right:15.0,top:10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(40.0),
                            topLeft: Radius.circular(40.0))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children :[
                          Padding(
                            padding: const EdgeInsets.only(left:15.0),
                            child: Text("Type :", style: trackHeaderStyle),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              buildPieChart(),
                              PieChartTypeLabel(),                              
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:15.0),
                            child: Text("Monthly Chart :", style: trackHeaderStyle),
                          ),
                          
                        ]
                      ),
                    );
                  })
            ]);
          } else {
            return NoDataWidget();
          }
        });
  }
}





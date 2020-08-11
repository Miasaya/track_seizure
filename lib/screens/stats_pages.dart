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

  List<BarChartGroupData> _showingBarGroups (List<Seizure> snapshot) {
    BarChartGroupData barGroup1 = makeGroupData(0, getNumberEntries(snapshot,'01')[0], getNumberEntries(snapshot,'01')[1],getNumberEntries(snapshot,'01')[2]);
    BarChartGroupData barGroup2 = makeGroupData(1, getNumberEntries(snapshot,'02')[0], getNumberEntries(snapshot,'02')[1],getNumberEntries(snapshot,'02')[2]);
    BarChartGroupData barGroup3 = makeGroupData(2, getNumberEntries(snapshot,'03')[0], getNumberEntries(snapshot,'03')[1],getNumberEntries(snapshot,'03')[2]);
    BarChartGroupData barGroup4 = makeGroupData(3, getNumberEntries(snapshot,'04')[0], getNumberEntries(snapshot,'04')[1],getNumberEntries(snapshot,'04')[2]);
    BarChartGroupData barGroup5 = makeGroupData(4, getNumberEntries(snapshot,'05')[0], getNumberEntries(snapshot,'05')[1],getNumberEntries(snapshot,'05')[2]);
    BarChartGroupData barGroup6 = makeGroupData(5, getNumberEntries(snapshot,'06')[0], getNumberEntries(snapshot,'06')[1],getNumberEntries(snapshot,'06')[2]);
    BarChartGroupData barGroup7 = makeGroupData(6, getNumberEntries(snapshot,'07')[0], getNumberEntries(snapshot,'07')[1],getNumberEntries(snapshot,'07')[2]);
    BarChartGroupData barGroup8 = makeGroupData(7, getNumberEntries(snapshot,'08')[0], getNumberEntries(snapshot,'08')[1],getNumberEntries(snapshot,'08')[2]);
    BarChartGroupData barGroup9 = makeGroupData(8, getNumberEntries(snapshot,'09')[0], getNumberEntries(snapshot,'09')[1],getNumberEntries(snapshot,'09')[2]);
    BarChartGroupData barGroup10 = makeGroupData(9, getNumberEntries(snapshot,'10')[0], getNumberEntries(snapshot,'10')[1],getNumberEntries(snapshot,'10')[2]);
    BarChartGroupData barGroup11 = makeGroupData(10, getNumberEntries(snapshot,'11')[0], getNumberEntries(snapshot,'11')[1],getNumberEntries(snapshot,'11')[2]);
    BarChartGroupData barGroup12 = makeGroupData(11, getNumberEntries(snapshot,'12')[0], getNumberEntries(snapshot,'12')[1],getNumberEntries(snapshot,'12')[2]);

    return [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
      barGroup5,
      barGroup6,
      barGroup7,
      barGroup8,
      barGroup9,
      barGroup10,
      barGroup11,
      barGroup12,
    ];
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
                          Padding(
                            padding: const EdgeInsets.only(left:62.0),
                            child: BarChart(
                              BarChartData(
                                maxY: 20,
                                groupsSpace: 16,
                                alignment: BarChartAlignment.center,
                                barTouchData: BarTouchData(enabled: false),
                                titlesData: buildFlTitlesData(),
                                borderData: FlBorderData(
                                  show: false,
                                ),
                                barGroups: _showingBarGroups(snapshotList),
                              ),
                            ),
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

  FlTitlesData buildFlTitlesData() {
    return FlTitlesData(
      show: true,
      bottomTitles: SideTitles(
        showTitles: true,
        textStyle: TextStyle(
            color: const Color(0xff7589a2),
            fontWeight: FontWeight.bold,
            fontSize: 14),
        margin: 20,
        getTitles: (double value) {
          switch (value.toInt()) {
            case 0:
              return 'Jan';
            case 1:
              return 'Feb';
            case 2:
              return 'Mar';
            case 3:
              return 'Apr';
            case 4:
              return 'May';
            case 5:
              return 'Jun';
            case 6:
              return 'Jul';
            case 7:
              return 'Aug';
            case 8:
              return 'Sep';
            case 9:
              return 'Oct';
            case 10:
              return 'Nov';
            case 11:
              return 'Dec';
            default:
              return '';
          }
        },
      ),
      leftTitles: SideTitles(
        showTitles: false,
        textStyle: TextStyle(
          color: const Color(0xff7589a2),
          fontWeight: FontWeight.bold,
          fontSize: 14),
        margin:20,
        reservedSize: 0,
        getTitles: (value) {
          if (value == 0) {
            return '0';
          } else if (value == 10) {
            return '10';
          } else if (value == 20) {
            return '20';
          } else {
            return '';
          }
        },
      ),
    );
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
}





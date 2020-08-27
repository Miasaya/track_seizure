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


  List<LineChartBarData> linesBarData1(List<Seizure> snapshot) {
    final LineChartBarData lineChartBarData1 = LineChartBarData(
      spots: [
        FlSpot(1, getNumberEntries(snapshot,'01')[0]),
        FlSpot(2, getNumberEntries(snapshot,'2')[0]),
        FlSpot(3, getNumberEntries(snapshot,'3')[0]),
        FlSpot(4, getNumberEntries(snapshot,'4')[0]),
        FlSpot(5, getNumberEntries(snapshot,'5')[0]),
        FlSpot(6, getNumberEntries(snapshot,'6')[0]),
        FlSpot(7, getNumberEntries(snapshot,'7')[0]),
        FlSpot(8, getNumberEntries(snapshot,'8')[0]),
        FlSpot(9, getNumberEntries(snapshot,'9')[0]),
        FlSpot(10, getNumberEntries(snapshot,'10')[0]),
        FlSpot(11, getNumberEntries(snapshot,'11')[0]),
        FlSpot(12, getNumberEntries(snapshot,'12')[0]),
      ],
      isCurved: true,
      colors: [
        const Color(0xff4af699),
      ],
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
    );
    final LineChartBarData lineChartBarData2 = LineChartBarData(
      spots: [
        FlSpot(1, getNumberEntries(snapshot,'01')[1]),
        FlSpot(2, getNumberEntries(snapshot,'02')[1]),
        FlSpot(3, getNumberEntries(snapshot,'03')[1]),
        FlSpot(4, getNumberEntries(snapshot,'04')[1]),
        FlSpot(5, getNumberEntries(snapshot,'05')[1]),
        FlSpot(6, getNumberEntries(snapshot,'06')[1]),
        FlSpot(7, getNumberEntries(snapshot,'07')[1]),
        FlSpot(8, getNumberEntries(snapshot,'08')[1]),
        FlSpot(9, getNumberEntries(snapshot,'09')[1]),
        FlSpot(10, getNumberEntries(snapshot,'10')[1]),
        FlSpot(11, getNumberEntries(snapshot,'11')[1]),
        FlSpot(12, getNumberEntries(snapshot,'12')[1]),
      ],
      isCurved: true,
      colors: [
        const Color(0xffaa4cfc),
      ],
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(show: false, colors: [
        const Color(0x00aa4cfc),
      ]),
    );
    final LineChartBarData lineChartBarData3 = LineChartBarData(
      spots: [
        FlSpot(1, getNumberEntries(snapshot,'01')[2]),
        FlSpot(2, getNumberEntries(snapshot,'02')[2]),
        FlSpot(3, getNumberEntries(snapshot,'03')[2]),
        FlSpot(4, getNumberEntries(snapshot,'04')[2]),
        FlSpot(5, getNumberEntries(snapshot,'05')[2]),
        FlSpot(6, getNumberEntries(snapshot,'06')[2]),
        FlSpot(7, getNumberEntries(snapshot,'07')[2]),
        FlSpot(8, getNumberEntries(snapshot,'08')[2]),
        FlSpot(9, getNumberEntries(snapshot,'09')[2]),
        FlSpot(10, getNumberEntries(snapshot,'10')[2]),
        FlSpot(11, getNumberEntries(snapshot,'11')[2]),
        FlSpot(12, getNumberEntries(snapshot,'12')[2]),
      ],
      isCurved: true,
      colors: const [
        Color(0xff27b6fc),
      ],
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
    );
    return [
      lineChartBarData1,
      lineChartBarData2,
      lineChartBarData3,
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
                            child: LineChart(
                                buildLineData(snapshotList),
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

  LineChartData buildLineData(List<Seizure> snapshot) {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
      touchCallback: (LineTouchResponse touchResponse) {},
      handleBuiltInTouches: true,
      ),
      gridData: FlGridData(show:false),
      titlesData: FlTitlesData(
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
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(
            color: Color(0xff4e4965),
            width: 4,
          ),
          left: BorderSide(
            color: Colors.transparent,
          ),
          right: BorderSide(
            color: Colors.transparent,
          ),
          top: BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
      minX: 0,
      maxX: 12,
      maxY: 40,
      minY: 0,
      lineBarsData: linesBarData1(snapshot),
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





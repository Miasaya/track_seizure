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
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: kGeneralizedColor,
            value: percentage[1],
            title: "${percentage[1]}%",
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: kOtherColor,
            value: percentage[2],
            title: "${percentage[2]}%",
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        default:
          return null;
      }
    });
  }

  List<LineChartBarData> linesBarData1(List<Seizure> snapshot) {
    final LineChartBarData lineChartBarData1 = LineChartBarData(
      spots: [
        FlSpot(0, getNumberEntries(snapshot, '01')[0].toDouble()),
        FlSpot(1, getNumberEntries(snapshot, '02')[0].toDouble()),
        FlSpot(2, getNumberEntries(snapshot, '03')[0].toDouble()),
        FlSpot(3, getNumberEntries(snapshot, '04')[0].toDouble()),
        FlSpot(4, getNumberEntries(snapshot, '05')[0].toDouble()),
        FlSpot(5, getNumberEntries(snapshot, '06')[0].toDouble()),
        FlSpot(6, getNumberEntries(snapshot, '07')[0].toDouble()),
        FlSpot(7, getNumberEntries(snapshot, '08')[0].toDouble()),
        FlSpot(8, getNumberEntries(snapshot, '09')[0].toDouble()),
        FlSpot(9, getNumberEntries(snapshot, '10')[0].toDouble()),
        FlSpot(10, getNumberEntries(snapshot, '11')[0].toDouble()),
        FlSpot(11, getNumberEntries(snapshot, '12')[0].toDouble()),
      ],
      isCurved: true,
      preventCurveOverShooting: true,
      colors: [
        kAbsenceColor,
      ],
      barWidth: 4,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: true,
        colors: [kAbsenceColor.withOpacity(0.3)]
      ),
    );
    final LineChartBarData lineChartBarData2 = LineChartBarData(
      spots: [
        FlSpot(0, getNumberEntries(snapshot, '01')[1].toDouble()),
        FlSpot(1, getNumberEntries(snapshot, '02')[1].toDouble()),
        FlSpot(2.0, getNumberEntries(snapshot, '03')[1].toDouble()),
        FlSpot(3.0, getNumberEntries(snapshot, '04')[1].toDouble()),
        FlSpot(4.0, getNumberEntries(snapshot, '05')[1].toDouble()),
        FlSpot(5.0, getNumberEntries(snapshot, '06')[1].toDouble()),
        FlSpot(6.0, getNumberEntries(snapshot, '07')[1].toDouble()),
        FlSpot(7.0, getNumberEntries(snapshot, '08')[1].toDouble()),
        FlSpot(8.0, getNumberEntries(snapshot, '09')[1].toDouble()),
        FlSpot(9.0, getNumberEntries(snapshot, '10')[1].toDouble()),
        FlSpot(10.0, getNumberEntries(snapshot, '11')[1].toDouble()),
        FlSpot(11.0, getNumberEntries(snapshot, '12')[1].toDouble()),
      ],
      isCurved: true,
      colors: [
        kGeneralizedColor,
      ],
      barWidth: 4,
      preventCurveOverShooting: true,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: true,
        colors: [kGeneralizedColor.withOpacity(0.3)]
      ),
    );
    final LineChartBarData lineChartBarData3 = LineChartBarData(
      spots: [
        FlSpot(0, getNumberEntries(snapshot, '01')[2].toDouble()),
        FlSpot(1, getNumberEntries(snapshot, '02')[2].toDouble()),
        FlSpot(2, getNumberEntries(snapshot, '03')[2].toDouble()),
        FlSpot(3, getNumberEntries(snapshot, '04')[2].toDouble()),
        FlSpot(4, getNumberEntries(snapshot, '05')[2].toDouble()),
        FlSpot(5, getNumberEntries(snapshot, '06')[2].toDouble()),
        FlSpot(6, getNumberEntries(snapshot, '07')[2].toDouble()),
        FlSpot(7, getNumberEntries(snapshot, '08')[2].toDouble()),
        FlSpot(8, getNumberEntries(snapshot, '09')[2].toDouble()),
        FlSpot(9, getNumberEntries(snapshot, '10')[2].toDouble()),
        FlSpot(10, getNumberEntries(snapshot, '11')[2].toDouble()),
        FlSpot(11, getNumberEntries(snapshot, '12')[2].toDouble()),
      ],
      isCurved: true,
      colors: [
        kOtherColor,
      ],
      barWidth: 4,
      preventCurveOverShooting: true,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: true,
        colors: [Colors.white]
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
                      padding: EdgeInsets.only(right: 15.0, top: 10.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(40.0),
                              topLeft: Radius.circular(40.0))),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0,top: 10.0),
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
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Text("Monthly Chart :",
                                  style: trackHeaderStyle),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Container(
                                width: 380.0,
                                child: LineChart(
                                  buildLineData(snapshotList),
                                ),
                              ),
                            ),
                          ]),
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
          tooltipBgColor: Colors.grey[600],
        ),
        touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: true,
      ),
      gridData: FlGridData(show: false),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          textStyle: TextStyle(
              color: const Color(0xff7589a2),
              fontWeight: FontWeight.bold,
              fontSize: 14),
          margin: 10,
          reservedSize: 30.0,
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
          showTitles: true,
          textStyle: TextStyle(
              color: const Color(0xff7589a2),
              fontWeight: FontWeight.bold,
              fontSize: 14),
          getTitles: (value) {
            if (value == 5) {
              return '';
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
      minX: 0.0,
      maxX: 11.0,
      maxY: 25.0,
      minY: 0.0,
      lineBarsData: linesBarData1(snapshot),
    );
  }

  PieChart buildPieChart() {
    return PieChart(PieChartData(
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
        sections: _showingSections(snapshotList)));
  }
}

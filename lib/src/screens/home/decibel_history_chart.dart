import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DecibelHistoryChart extends StatelessWidget {
  final List<double> decibelHistory;

  const DecibelHistoryChart({Key? key, required this.decibelHistory})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return decibelHistory.isNotEmpty
        ? SizedBox(
            height: size.height * .2,
            width: size.width * .9,
            child: LineChart(LineChartData(
                minX: 0,
                maxX: 70,
                maxY: 130,
                minY: 5,
                titlesData: FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                gridData: FlGridData(show: false),
                lineBarsData: [
                  LineChartBarData(
                      spots: decibelHistory
                          .asMap()
                          .entries
                          .map((e) => FlSpot(e.key.toDouble(), e.value.floor().toDouble() - 20))
                          .toList(),
                      isCurved: true,
                      dotData: FlDotData(show: false),
                      barWidth: 4,
                      color: Color(0xff4285f4)),
                ])),
          )
        : const SizedBox();
  }
}

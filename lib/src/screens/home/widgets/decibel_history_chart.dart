import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DecibelHistoryChart extends StatelessWidget {
  final List<int> decibelHistory;
  final Color lineColor;

  const DecibelHistoryChart(
      {Key? key, required this.decibelHistory, required this.lineColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.5,
      child: LineChart(LineChartData(
          minX: 0,
          maxX: 60,
          maxY: 120,
          minY: 0,
          titlesData: FlTitlesData(
            show: false,
          ),
          borderData: FlBorderData(show: false),
          lineTouchData: LineTouchData(enabled: false),
          gridData: FlGridData(
              show: true, horizontalInterval: 20, drawVerticalLine: false),
          clipData: FlClipData.all(),
          lineBarsData: [
            LineChartBarData(
                spots: decibelHistory
                    .asMap()
                    .entries
                    .map((e) =>
                        FlSpot(e.key.toDouble(), e.value.floor().toDouble()))
                    .toList(),
                isCurved: true,
                dotData: FlDotData(show: false),
                barWidth: 4,
                color: lineColor),
          ])),
    );
  }
}

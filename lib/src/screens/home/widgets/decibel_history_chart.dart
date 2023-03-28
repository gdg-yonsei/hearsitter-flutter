import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hear_sitter/src/core/app_constants.dart';

class DecibelHistoryChart extends StatelessWidget {
  final List<int> decibelHistory;
  final Color lineColor;

  const DecibelHistoryChart(
      {Key? key, required this.decibelHistory, required this.lineColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '        ( dB )',
                style: TextStyle(fontSize: 12, color: AppColor.grayColor),
                textAlign: TextAlign.left,
              )),
          const SizedBox(height: 3,),
          AspectRatio(
            aspectRatio: 3.4,
            child: LineChart(LineChartData(
                minX: 0,
                maxX: 60,
                maxY: 120,
                minY: 0,
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: false,
                    ),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: false,
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: false,
                    ),
                  ),
                  leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                          showTitles: true,
                          interval: 20,
                          reservedSize: 25,
                          getTitlesWidget: leftTitleWidgets)),
                ),
                borderData: FlBorderData(
                    show: true,
                    border: const Border.symmetric(
                        horizontal: BorderSide(
                      color: AppColor.lightGrayColor,
                      width: 1,
                    ))),
                lineTouchData: LineTouchData(enabled: false),
                gridData: FlGridData(
                    show: true,
                    horizontalInterval: 40,
                    drawVerticalLine: false,
                    drawHorizontalLine: true),
                clipData: FlClipData.all(),
                lineBarsData: [
                  LineChartBarData(
                      spots: decibelHistory
                          .asMap()
                          .entries
                          .map((e) => FlSpot(
                              e.key.toDouble(), e.value.floor().toDouble()))
                          .toList(),
                      isCurved: true,
                      dotData: FlDotData(show: false),
                      barWidth: 4,
                      color: lineColor,
                      belowBarData: BarAreaData(
                          show: true,
                          // applyCutOffY: true,
                          gradient: LinearGradient(
                              begin: FractionalOffset.topCenter,
                              end: FractionalOffset.bottomCenter,
                              tileMode: TileMode.repeated,
                              colors: [AppColor.secondaryColor, Colors.white]
                                  .map((color) => color.withOpacity(.4))
                                  .toList()))),
                ])),
          ),
        ],
      ),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(fontSize: 12, color: AppColor.grayColor);
    String text;

    switch (value.toInt()) {
      case 0:
        text = '0';
        break;
      case 20:
        text = '20';
        break;
      case 40:
        text = '40';
        break;
      case 60:
        text = '60';
        break;
      case 80:
        text = '80';
        break;
      case 100:
        text = '100';
        break;
      case 120:
        text = '120';
        break;
      default:
        return const SizedBox();
    }

    return Text(
      text,
      style: style,
      textAlign: TextAlign.left,
    );
  }
}

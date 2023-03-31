import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hear_sitter/src/core/app_constants.dart';

class DecibelScaleChart extends StatelessWidget {
  const DecibelScaleChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
      child: AspectRatio(
        aspectRatio: 1.3,
        child: BarChart(BarChartData(
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
                      showTitles: true,
                      reservedSize: 25,
                      getTitlesWidget: leftTitleWidgets),
                ),
                leftTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false))),
            barTouchData: barTouchData(),
            gridData: FlGridData(
                show: true,
                horizontalInterval: 20,
                drawVerticalLine: false,
                drawHorizontalLine: true),
            alignment: BarChartAlignment.spaceBetween,
            borderData: FlBorderData(
                show: true,
                border: const Border.symmetric(
                    horizontal: BorderSide(
                  color: AppColor.lightGrayColor,
                  width: 1,
                ))),
            barGroups: barGroups())),
      ),
    );
  }

  BarTouchData barTouchData() {
    return BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.transparent,
            tooltipMargin: 5,
            tooltipPadding: EdgeInsets.zero,
            getTooltipItem: (group, groupIdx, rod, rodIdx) {
              late String tooltip;
              switch (group.x) {
                case 0:
                  tooltip = 'Silent';
                  break;
                case 1:
                  tooltip = 'Quiet';
                  break;
                case 2:
                  tooltip = 'Whispered';
                  break;
                case 3:
                  tooltip = 'Noraml\nConversation';
                  break;
                case 4:
                  tooltip = 'Noisy';
                  break;
                case 5:
                  tooltip = 'Dangerous';
                  break;
                case 6:
                  tooltip = 'Very\nDangerous';
                  break;
              }
              return BarTooltipItem(
                tooltip,
                const TextStyle(
                    color: AppColor.darkColor,
                    fontSize: 11,
                    fontWeight: FontWeight.w500),
              );
            }));
  }

  List<BarChartGroupData> barGroups() {
    return [
      BarChartGroupData(
          x: 0,
          barRods: [BarChartRodData(toY: 10, color: AppColor.primaryColor)],
          showingTooltipIndicators: [0]),
      BarChartGroupData(x: 1, barRods: [
        BarChartRodData(toY: 20, width: 10, color: const Color(0xff00bfcd))
      ], showingTooltipIndicators: [
        0
      ]),
      BarChartGroupData(x: 2, barRods: [
        BarChartRodData(toY: 40, width: 14, color: const Color(0xff4dab3c))
      ], showingTooltipIndicators: [
        0
      ]),
      BarChartGroupData(x: 3, barRods: [
        BarChartRodData(toY: 70, width: 18, color: const Color(0xff99cd89))
      ], showingTooltipIndicators: [
        0
      ]),
      BarChartGroupData(x: 4, barRods: [
        BarChartRodData(toY: 90, width: 20, color: const Color(0xfff7b300))
      ], showingTooltipIndicators: [
        0
      ]),
      BarChartGroupData(x: 5, barRods: [
        BarChartRodData(toY: 100, width: 22, color: AppColor.errorColor)
      ], showingTooltipIndicators: [
        0
      ]),
      BarChartGroupData(x: 6, barRods: [
        BarChartRodData(toY: 120, width: 24, color: const Color(0xffa22b1e))
      ], showingTooltipIndicators: [
        0
      ]),
    ];
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(fontSize: 12, color: Colors.black54);
    String text;

    switch (value.toInt()) {
      case 0:
        text = '0-10';
        break;
      case 1:
        text = '10-20';
        break;
      case 2:
        text = '20-40';
        break;
      case 3:
        text = '40-60';
        break;
      case 4:
        text = '60-70';
        break;
      case 5:
        text = '70-90';
        break;
      case 6:
        text = '90-100';
        break;
      case 7:
        text = '100-120';
        break;
      default:
        return const SizedBox();
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 5,
      child: Text(
        text,
        style: style,
        textAlign: TextAlign.left,
      ),
    );
  }
}

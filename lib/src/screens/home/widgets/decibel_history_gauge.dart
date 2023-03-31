import 'package:flutter/material.dart';
import 'package:hear_sitter/src/core/app_constants.dart';
import 'package:hear_sitter/src/screens/home/widgets/decibel_history_chart.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

Widget decibelHistoryGauge(
    {required List<int> decibelHistory,
    required Color lineColor,
    required int decibel}) {
  return Column(
    children: [
      DecibelHistoryChart(decibelHistory: decibelHistory, lineColor: lineColor),
      const SizedBox(
        height: 10,
      ),
      AspectRatio(
        aspectRatio: 1.3,
        child: SfRadialGauge(
          axes: <RadialAxis>[
            RadialAxis(
              minimum: 0,
              maximum: 120,
              interval: 20,
              showLastLabel: true,
              showTicks: false,
              useRangeColorForAxis: true,
              axisLineStyle: const AxisLineStyle(
                thickness: 25,
                cornerStyle: CornerStyle.bothCurve,
              ),
              axisLabelStyle: const GaugeTextStyle(
                fontSize: 13,
                fontFamily: 'NotoSansKR',
                color: AppColor.grayColor,
              ),
              pointers: [
                RangePointer(
                  value: decibel.toDouble(),
                  cornerStyle: CornerStyle.bothCurve,
                  width: 25,
                  color: decibel > 89
                      ? AppColor.errorColor
                      : AppColor.primaryColor,
                ),
              ],
              annotations: [
                GaugeAnnotation(
                  widget: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: '$decibel\n',
                        style: const TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: AppColor.darkColor),
                        children: const [
                          TextSpan(
                            text: 'dB',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          )
                        ]),
                  ),
                  angle: 90,
                  positionFactor: 0.1,
                ),
              ],
            )
          ],
        ),
      ),
    ],
  );
}

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';
import 'indicator.dart';

class PieChartSample2 extends StatefulWidget {
  final int? cash;
  final int? qris;
  final int? va;
  final int? others;
  const PieChartSample2({
    super.key,
    this.cash = 0,
    this.qris = 0,
    this.va = 0,
    this.others = 0,
  });

  @override
  State<PieChartSample2> createState() => _PieChartSample2State();
}

class _PieChartSample2State extends State<PieChartSample2> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 15, left: 15),
            child: Text(
              'Payment Method',
            ),
          ),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: widget.cash == 0 &&
                      widget.qris == 0 &&
                      widget.va == 0 &&
                      widget.others == 0
                  ? const Center(
                      child: Text(
                        "No Data",
                        style: TextStyle(color: AppColors.darkGrey),
                      ),
                    )
                  : PieChart(
                      PieChartData(
                        pieTouchData: PieTouchData(
                          touchCallback:
                              (FlTouchEvent event, pieTouchResponse) {
                            setState(() {
                              if (!event.isInterestedForInteractions ||
                                  pieTouchResponse == null ||
                                  pieTouchResponse.touchedSection == null) {
                                touchedIndex = -1;
                                return;
                              }
                              touchedIndex = pieTouchResponse
                                  .touchedSection!.touchedSectionIndex;
                            });
                          },
                        ),
                        borderData: FlBorderData(
                          show: false,
                        ),
                        sectionsSpace: 0,
                        centerSpaceRadius: 40,
                        sections: showingSections(widget.cash!, widget.qris!,
                            widget.va!, widget.others!),
                      ),
                    ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Indicator(
                color: AppColors.green,
                text: 'Cash',
                isSquare: true,
              ),
              Indicator(
                color: Colors.green[800],
                text: 'Qris',
                isSquare: true,
              ),
              const Indicator(
                color: AppColors.primary,
                text: 'VA',
                isSquare: true,
              ),
              const Indicator(
                color: Colors.grey,
                text: 'Others',
                isSquare: true,
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections(
      int cash, int qris, int va, int others) {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      // const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: AppColors.green,
            value: cash == 0 ? 0 : ((cash / (cash + qris + va + others)) * 100),
            title:
                '${cash == 0 ? 0 : ((cash / (cash + qris + va + others)) * 100).ceil()}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              // shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: AppColors.primary,
            value: qris == 0 ? 0 : ((qris / (cash + qris + va + others)) * 100),
            title:
                '${qris == 0 ? 0 : ((qris / (cash + qris + va + others)) * 100).ceil()}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              // shadows: shadows,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: Colors.green[800],
            value: va == 0 ? 0 : ((va / (cash + qris + va + others)) * 100),
            title:
                '${va == 0 ? 0 : ((va / (cash + qris + va + others)) * 100).ceil()}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              // shadows: shadows,
            ),
          );
        case 3:
          return PieChartSectionData(
            color: Colors.grey,
            value: others == 0
                ? 0
                : ((others / (cash + qris + va + others)) * 100),
            title:
                '${others == 0 ? 0 : ((others / (cash + qris + va + others)) * 100).ceil()}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              // shadows: shadows,
            ),
          );
        default:
          throw Error();
      }
    });
  }
}

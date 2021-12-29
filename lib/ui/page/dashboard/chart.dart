import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'chart_list_item.dart';

double _width = 25;

class Chart extends StatelessWidget {
  const Chart({Key? key, required this.items}) : super(key: key);

  final List<ChartListItem> items;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Stack(
        children: [
          PieChart(
            PieChartData(
              sectionsSpace: 0,
              centerSpaceRadius: 30,
              startDegreeOffset: -90,
              sections: items.map((item) {
                return PieChartSectionData(
                  color: item.color,
                  value: item.amount,
                  showTitle: false,
                  radius: _width,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

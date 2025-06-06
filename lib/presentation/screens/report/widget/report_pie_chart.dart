import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:joes_jwellery_crm/core/theme/dimens.dart';

class ReportPieChart extends StatelessWidget {
  final double value2 ;
  final double value4 ;
  final double value5 ;
  const ReportPieChart({super.key, this.value2 = 0, this.value4 = 0, this.value5 = 0});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Legend
        Padding(
          padding: EdgeInsets.only(left: AppDimens.spacing10,top: AppDimens.spacing10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              LegendItem(color: Colors.orange, text: 'Joes 2'),
              LegendItem(color: Colors.green, text: 'Joes 4'),
              LegendItem(color: Colors.blue, text: 'Joes 5'),
            ],
          ),
        ),

        SizedBox(
          height: 250,
          child: PieChart(
            curve: Curves.easeIn,  
            duration: Duration(seconds: 2),          
            PieChartData(
              sectionsSpace: 4,
              centerSpaceRadius: 0,
              sections: [
                PieChartSectionData(
                  value: value4,
                  color: Colors.green[600],
                  title: '$value4 %',
                  radius: AppDimens.spacing100,
                  titleStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: AppDimens.textSize12,
                    color: Colors.white,
                  ),
                ),
                PieChartSectionData(
                  value: value5,
                  color: Colors.blue[600],
                  title: '$value5 %',
                  radius: AppDimens.spacing100,
                  titleStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: AppDimens.textSize12,
                    color: Colors.white,
                  ),
                ),
                PieChartSectionData(
                  value: value2,
                  color: Colors.orange[600],
                  title: '$value2 %',
                  radius: AppDimens.spacing100,
                  titleStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: AppDimens.textSize12,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class LegendItem extends StatelessWidget {
  final Color color;
  final String text;

  const LegendItem({super.key, required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          color: color,
        ),
        const SizedBox(width: 8),
        Text(text),
      ],
    );
  }
}

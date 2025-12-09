import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:fl_chart/fl_chart.dart';

class ConversionRateChart extends StatelessWidget {
  final double percentage;

  const ConversionRateChart({super.key, required this.percentage});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE0E0E0))
      ),
      child: Column(
        children: [
           Align(
             alignment: AlignmentGeometry.topLeft,
             child: Text(
              "Conversion Rate",
              style:MyTexts.bold17,
                       ),
           ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(top: 80.0),
            child: SizedBox(
              height: 90,
              width: double.infinity,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  PieChart(
                    PieChartData(
                      startDegreeOffset: 180,
                      sectionsSpace: 0,
                      centerSpaceRadius: 80,
                      sections: [
                        PieChartSectionData(
                          value: 10,
                          color: Colors.blue.shade600,
                          radius: 45,
                          showTitle: false,
                        ),
                        PieChartSectionData(
                          value: 10,
                          color: Colors.amber.shade400,
                          radius: 45,
                          showTitle: false,
                        ),
                        PieChartSectionData(
                          value: 10,
                          color: Colors.redAccent.shade200,
                          radius: 45,
                          showTitle: false,
                        ),

                        /// Hide bottom half (180°)
                        PieChartSectionData(
                          value: 30,
                          color: Colors.transparent,
                          radius: 45,
                          showTitle: false,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "${percentage.toInt()}%",
                    style:MyTexts.bold24,
                  ),
                ],
              ),
            ),
          ),
           Text(
            "Admin - Accessible to all team\nTeam Member - Accessible only his",
            textAlign: TextAlign.center,
            style:MyTexts.regular14,
          ),
        ],
      ),
    );
  }
}

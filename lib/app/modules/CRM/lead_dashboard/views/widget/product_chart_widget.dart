import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/controller/lead_dash_controller.dart';
import 'package:fl_chart/fl_chart.dart';

class ProductChartWidget extends GetView<LeadDashController> {
  const ProductChartWidget({super.key});

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text(
            'Product A and Product B',
            style:MyTexts.bold17,
          ),
          const Gap(15),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Obx(
                () => _legendDot(
                  'Product A',
                  Colors.blue,
                  controller.showA.value,
                  controller.toggleA,
                ),
              ),
              const SizedBox(width: 16),
              Obx(
                () => _legendDot(
                  'Product B',
                  Colors.red,
                  controller.showB.value,
                  controller.toggleB,
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          // Chart area
          SizedBox(
            height: 220,
            child: Obx(
              () => LineChart(
                _buildChartData(
                  controller.productA,
                  controller.productB,
                  controller.showA.value,
                  controller.showB.value,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _legendDot(
    String label,
    Color color,
    bool visible,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: visible ? color : color.withValues(alpha: 0.25),
              border: Border.all(color: Colors.white, width: 0),
              boxShadow: [
                BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 2),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }

  LineChartData _buildChartData(
    List<double> a,
    List<double> b,
    bool showA,
    bool showB,
  ) {
    final List<FlSpot> spotsA = List.generate(
      a.length,
      (i) => FlSpot(i.toDouble(), a[i]),
    );
    final List<FlSpot> spotsB = List.generate(
      b.length,
      (i) => FlSpot(i.toDouble(), b[i]),
    );

    final double maxVal = [...a, ...b].reduce((v, w) => v > w ? v : w);
    final double maxY = (maxVal <= 1000) ? 1000 : (maxVal * 1.1).ceilToDouble();

    return LineChartData(
      gridData: FlGridData(
        horizontalInterval: 300,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) =>
            const FlLine(strokeWidth: 0.2, dashArray: [4, 4]),
        getDrawingVerticalLine: (value) =>
            const FlLine(strokeWidth: 0.2, dashArray: [4, 4]),
      ),
      titlesData: FlTitlesData(
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 50,
            interval: 300,
            getTitlesWidget: (value, meta) {
              // show $ labels like $0K $300K $600K ...
              final int v = value.toInt();
              // Only show the nice round ticks
              if (v % 300 != 0) return const SizedBox.shrink();
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(
                  '\$${v}K',
                    style: MyTexts.regular14
                ),
              );
            },
          ),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) {
              // show month labels for integer x positions
              final int idx = value.toInt();
              if (idx < 0 || idx >= controller.months.length) {
                return const SizedBox.shrink();
              }
              return Padding(
                padding: const EdgeInsets.only(top: 6.0),
                child: Text(
                  controller.months[idx],
                  style: MyTexts.regular14
                ),
              );
            },
            interval: 1,
          ),
        ),
        rightTitles: const AxisTitles(),
        topTitles: const AxisTitles(),
      ),
      minX: 0,
      maxX: (a.length - 1).toDouble(),
      minY: 0,
      maxY: maxY,
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBorderRadius: BorderRadius.circular(8),
          // tooltipBgColor: Colors.white,
          tooltipPadding: const EdgeInsets.all(8),
          getTooltipItems: (touchedSpots) => touchedSpots.map((t) {
            return LineTooltipItem(
              '\$${t.y.toInt()}K',
              const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 8,
              ),
            );
          }).toList(),
        ),
      ),
      lineBarsData: [
        if (showA)
          LineChartBarData(
            spots: spotsA,
            isCurved: true,
            color: Colors.blue,
            barWidth: 1.5,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(),
          ),
        if (showB)
          LineChartBarData(
            spots: spotsB,
            isCurved: true,
            color: Colors.red,
            barWidth: 1.5,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(),
          ),
      ],
      borderData: FlBorderData(
        show: true,
        border: Border(
          left: BorderSide(color: Colors.grey.shade800),
          bottom: BorderSide(color: Colors.grey.shade800),
          right: const BorderSide(color: Colors.transparent),
          top: const BorderSide(color: Colors.transparent),
        ),
      ),
    );
  }
}

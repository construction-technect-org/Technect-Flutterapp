import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/CRM/lead_dashboard/controller/lead_dash_controller.dart';
import 'package:fl_chart/fl_chart.dart';

class ProductChartWidget extends GetView<LeadDashController> {
  const ProductChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
        ),
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title + Legend (match image layout)
            const Text(
              'Product A and Product B',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
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
              height: 380,
              child: Obx(
                () => LineChart(
                  _buildChartData(
                    controller.productA,
                    controller.productB,
                    controller.showA.value,
                    controller.showB.value,
                  ),
                  // swapAnimationDuration: const Duration(milliseconds: 600),
                ),
              ),
            ),
          ],
        ),
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
          // larger ring with center dot to match the image's legend style
          Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: visible ? color : color.withOpacity(0.25),
              border: Border.all(color: Colors.white, width: 0),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 2),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
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
    // convert to FlSpot (x index, y value)
    final List<FlSpot> spotsA = List.generate(
      a.length,
      (i) => FlSpot(i.toDouble(), a[i]),
    );
    final List<FlSpot> spotsB = List.generate(
      b.length,
      (i) => FlSpot(i.toDouble(), b[i]),
    );

    // Decide y axis ticks at 0,300,600,900,1200 (assuming data in K)
    final double maxVal = [...a, ...b].reduce((v, w) => v > w ? v : w);
    final double maxY = (maxVal <= 1000) ? 1000 : (maxVal * 1.1).ceilToDouble();

    return LineChartData(
      gridData: FlGridData(
        horizontalInterval: 300,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) =>
            const FlLine(strokeWidth: 0.7, dashArray: [6, 6]),
        getDrawingVerticalLine: (value) =>
            const FlLine(strokeWidth: 0.7, dashArray: [6, 6]),
      ),
      titlesData: FlTitlesData(
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 56,
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
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
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
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
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
                color: Colors.black,
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
            barWidth: 3.5,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(),
          ),
        if (showB)
          LineChartBarData(
            spots: spotsB,
            isCurved: true,
            color: Colors.red,
            barWidth: 3.5,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(),
          ),
      ],
      borderData: FlBorderData(
        show: true,
        border: Border(
          left: BorderSide(color: Colors.grey.shade800, width: 2),
          bottom: BorderSide(color: Colors.grey.shade800, width: 2),
          right: const BorderSide(color: Colors.transparent),
          top: const BorderSide(color: Colors.transparent),
        ),
      ),
    );
  }
}

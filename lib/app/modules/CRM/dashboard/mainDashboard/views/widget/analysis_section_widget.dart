import 'package:construction_technect/app/core/utils/imports.dart';
class FunnelChartWidget extends StatelessWidget {
  final List<Map<String, dynamic>> funnelData;
  final double minWidthFactor;

  const FunnelChartWidget({
    super.key,
    required this.funnelData,
    this.minWidthFactor = 0.28,
  });

  @override
  Widget build(BuildContext context) {
    if (funnelData.isEmpty) {
      return const SizedBox.shrink();
    }
    final sorted = List<Map<String, dynamic>>.from(funnelData)
      ..sort((a, b) => (b['count'] as int).compareTo(a['count'] as int));

    final int n = sorted.length;
    late final denom = (n - 1) > 0 ? (n - 1) : 1;

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
            "Analysis",
            style: MyTexts.bold17
          ),
          const SizedBox(height: 18),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  children: List.generate(n, (index) {
                    final step = sorted[index];
                    final t = index / denom;
                    final widthFactor = 1.0 - t * (1.0 - minWidthFactor);

                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: index < n - 1 ? 12 : 0,
                      ),
                      child: FractionallySizedBox(
                        widthFactor: widthFactor.clamp(minWidthFactor, 1.0),
                        child: CustomPaint(
                          painter: _TrapezoidPainter(color: step['color'] as Color),
                          child: Container(
                            height: 16,
                            alignment: Alignment.center,
                            child: Text(
                              "${step['count']}",
                              style: MyTexts.medium14.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),

              const SizedBox(width: 24),
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: sorted.map((step) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: SizedBox(
                        height: 15,
                        child: Row(
                          children: [
                            Container(
                              width: 12,
                              height: 8,
                              decoration: BoxDecoration(
                                color: step['color'] as Color,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                "${step['label']}: ${step['count']}",
                                style: MyTexts.medium14.copyWith(color: MyColors.fontBlack),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TrapezoidPainter extends CustomPainter {
  final Color color;
  _TrapezoidPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final double topWidth = size.width;
    final double bottomWidth = size.width * 0.66;

    final leftTop = Offset((size.width - topWidth) / 2, 0);
    final rightTop = Offset((size.width + topWidth) / 2, 0);
    final rightBottom = Offset((size.width + bottomWidth) / 2, size.height);
    final leftBottom = Offset((size.width - bottomWidth) / 2, size.height);

    final path = Path()
      ..moveTo(leftTop.dx, leftTop.dy)
      ..lineTo(rightTop.dx, rightTop.dy)
      ..lineTo(rightBottom.dx, rightBottom.dy)
      ..lineTo(leftBottom.dx, leftBottom.dy)
      ..close();

    canvas.drawShadow(path, Colors.black.withOpacity(0.08), 2, false);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _TrapezoidPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}

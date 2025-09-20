import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:dotted_border/dotted_border.dart';

class DottedLinePainter extends CustomPainter {
  final Color color;

  DottedLinePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    const dashWidth = 5;
    const dashSpace = 5;
    double startX = 0;
    final double endX = size.width;

    while (startX < endX) {
      canvas.drawLine(
        Offset(startX, size.height / 2),
        Offset(startX + dashWidth, size.height / 2),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class StepperWidgetAddProduct extends StatelessWidget {
  final int currentStep;

  const StepperWidgetAddProduct({super.key, required this.currentStep});

  Widget _buildDottedLine(Color color) {
    return SizedBox(
      width: 39,
      height: 1,
      child: CustomPaint(painter: DottedLinePainter(color: color)),
    );
  }

  Widget _buildStepCircle({
    required bool isActive,
    required bool isCompleted,
    required Color borderColor,
    required Color fillColor,
  }) {
    return DottedBorder(
      options: CircularDottedBorderOptions(
        color: borderColor,
        dashPattern: const [4, 4],
        padding: const EdgeInsets.all(6),
      ),
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(color: fillColor, shape: BoxShape.circle),
        child: isCompleted
            ? const Icon(Icons.check, color: Colors.white, size: 16)
            : isActive
            ? const SizedBox()
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Circles and lines
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Step 1 - Role
            _buildStepCircle(
              isActive: currentStep == 0,
              isCompleted: currentStep > 0,
              borderColor: currentStep > 0
                  ? const Color(0xFF3DA741)
                  : currentStep == 0
                  ? const Color(0xFF1B2F62)
                  : const Color(0xFF6C6C6C),
              fillColor: currentStep > 0
                  ? const Color(0xFF3DA741)
                  : currentStep == 0
                  ? const Color(0xFF1B2F62)
                  : const Color(0xFF6C6C6C),
            ),
            const SizedBox(width: 10),
            // Dotted line
            _buildDottedLine(
              currentStep > 0 ? const Color(0xFF3DA741) : const Color(0xFF1B2F62),
            ),
            const SizedBox(width: 10),
            // Step 2 - Basic Details
            _buildStepCircle(
              isActive: currentStep == 1,
              isCompleted: currentStep > 1,
              borderColor: currentStep > 1
                  ? const Color(0xFF3DA741)
                  : currentStep == 1
                  ? const Color(0xFF1B2F62)
                  : const Color(0xFF6C6C6C),
              fillColor: currentStep > 1
                  ? const Color(0xFF3DA741)
                  : currentStep == 1
                  ? const Color(0xFF1B2F62)
                  : const Color(0xFF6C6C6C),
            ),
          ],
        ),
        const SizedBox(height: 8),
        // Labels
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 50,
              child: Text(
                'Product',
                style: MyTexts.medium14.copyWith(
                  color: currentStep > 0
                      ? const Color(0xFF3DA741)
                      : currentStep == 0
                      ? const Color(0xFF3D41A7)
                      : const Color(0xFF787878),
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ).paddingOnly(right: 16),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: SizedBox(
                width: 80,
                child: Text(
                  'Specifications',
                  style: MyTexts.medium14.copyWith(
                    color: currentStep > 1
                        ? const Color(0xFF3DA741)
                        : currentStep == 1
                        ? const Color(0xFF3D41A7)
                        : const Color(0xFF787878),
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

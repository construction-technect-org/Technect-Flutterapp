import 'package:construction_technect/app/core/utils/imports.dart';

class PillButtonWidget extends StatelessWidget {
  final String text;
  final Color background;
  final Color textColor;
  final IconData? icon;
  final bool trailingChevron;
  const PillButtonWidget({
    super.key,
    required this.text,
    this.background = Colors.white,
    this.textColor = Colors.black,
    this.icon,
    this.trailingChevron = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: MyColors.grayEA),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 18, color: textColor),
            const SizedBox(width: 8),
          ],
          Text(text, style: MyTexts.medium14.copyWith(color: textColor)),
          if (trailingChevron) ...[
            const SizedBox(width: 6),
            const Icon(
              Icons.keyboard_arrow_down,
              size: 18,
              color: Colors.black54,
            ),
          ],
        ],
      ),
    );
  }
}

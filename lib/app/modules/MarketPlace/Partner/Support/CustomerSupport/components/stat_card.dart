import 'package:construction_technect/app/core/utils/imports.dart';

class StatCard extends StatelessWidget {
  const StatCard({
    super.key,
    required this.title,
    required this.value,
    this.gradient,
    this.backgroundColor,
    this.onTap,
    this.trailingIcon = Icons.arrow_outward,
  });

  final String title;
  final String value;
  final Gradient? gradient;
  final Color? backgroundColor;
  final Function()? onTap;
  final IconData trailingIcon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: backgroundColor ?? MyColors.white,
          gradient: gradient,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: MyTexts.medium12.copyWith(color: MyColors.primary),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                Icon(trailingIcon, size: 16, color: MyColors.primary),
              ],
            ),
            Text(
              value,
              style: MyTexts.bold20.copyWith(
                color: MyColors.primary,
                fontFamily: MyTexts.SpaceGrotesk,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

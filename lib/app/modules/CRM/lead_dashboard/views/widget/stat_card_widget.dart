import 'package:construction_technect/app/core/utils/imports.dart';

class StatCardWidget extends StatelessWidget {
  const StatCardWidget({super.key, required this.title, required this.value, this.onTap});

  final String title;
  final String value;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: MyColors.white,
          borderRadius: BorderRadius.circular(12),
          // border: Border.all(color: MyColors.grayEA),
        ),
        child: Column(
          children: [
            Text(
              title,
              style: MyTexts.medium14.copyWith(color: MyColors.fontBlack),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const Gap(4),
            Text(value, style: MyTexts.bold20.copyWith(color: MyColors.primary)),
          ],
        ),
      ),
    );
  }
}

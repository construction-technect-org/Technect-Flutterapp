import 'package:construction_technect/app/core/utils/imports.dart';

class StatisticTile extends StatelessWidget {
  final String image;
  final String title;
  final String value;

  const StatisticTile({
    super.key,
    required this.image,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(image, height: 50, width: 50, fit: BoxFit.cover),
        const Gap(8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: MyTexts.bold18.copyWith(color: MyColors.gray2E),
              ),
              SizedBox(height: 0.4.h),
              Text(
                title,
                style: MyTexts.medium14.copyWith(color: MyColors.gray54),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

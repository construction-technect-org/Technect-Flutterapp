import 'package:construction_technect/app/core/utils/imports.dart';

class VrmCommonTodayCard extends StatelessWidget {
  final String filterName;
  final int totalCount;

  const VrmCommonTodayCard({super.key, required this.filterName, required this.totalCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12, top: 9),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: MyColors.grayD4),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Today's Total $filterName",
            style: MyTexts.medium14.copyWith(color: MyColors.black),
          ),
          Text(
            '$totalCount',
            style: MyTexts.medium24.copyWith(fontWeight: FontWeight.w700, letterSpacing: 0.5),
          ),
        ],
      ),
    );
  }
}

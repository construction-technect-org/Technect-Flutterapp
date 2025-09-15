import 'package:construction_technect/app/core/utils/imports.dart';

class StatCard extends StatelessWidget {
  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.iconBackground,
    this.showCornerBadge = false, // new parameter
  });

  final String title;
  final String value;
  final Widget icon;
  final Color iconBackground;
  final bool showCornerBadge;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 84,
      decoration: BoxDecoration(
        color: MyColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: MyColors.americanSilver),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 15),
      child: Row(
        children: [
          /// 🔲 Icon box with red corner badge
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: iconBackground,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(10),
                child: SizedBox(height: 36, width: 36, child: icon),
              ),

              if (showCornerBadge)
                Positioned(
                  right: -2,
                  top: -2,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: MyColors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),

          SizedBox(width: 1.h),

          /// 📄 Title + Value
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: MyTexts.regular14.copyWith(color: MyColors.davysGrey),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                SizedBox(height: 0.4.h),
                Text(
                  value,
                  style: MyTexts.bold16.copyWith(color: MyColors.fontBlack),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

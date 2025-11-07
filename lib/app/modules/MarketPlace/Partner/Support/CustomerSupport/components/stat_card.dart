import 'package:construction_technect/app/core/utils/imports.dart';

class StatCard extends StatelessWidget {
  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.iconBackground,
    this.showCornerBadge = false,
    this.onTap,
  });

  final String title;
  final String value;
  final Widget icon;
  final Color iconBackground;
  final Function()? onTap;
  final bool showCornerBadge;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: MyColors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: MyColors.grayEA),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 15),
        child: Row(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: iconBackground,
                    shape: BoxShape.circle
                  ),
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(height: 30, width: 30, child: icon),
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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value,
                    style: MyTexts.bold18.copyWith(
                      color: MyColors.fontBlack,
                      fontFamily: MyTexts.SpaceGrotesk,
                    ),
                  ),
                  SizedBox(height: 0.4.h),
                  Text(
                    title,
                    style: MyTexts.medium14.copyWith(
                      color: MyColors.davysGrey,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),


                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:construction_technect/app/core/utils/imports.dart';

class VrmCommonStatusWidget extends StatelessWidget {
  final List<String> statusList;
  final String activeStatus;
  final Function(String) onStatusTap;

  const VrmCommonStatusWidget({
    super.key,
    required this.statusList,
    required this.activeStatus,
    required this.onStatusTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: statusList.length,
          separatorBuilder: (_, _) => const SizedBox(width: 20),
          itemBuilder: (context, index) {
            final String label = statusList[index];
            final bool isActive = activeStatus == label;
            return Center(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => onStatusTap(label),
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 200),
                  style: MyTexts.medium15.copyWith(
                    color: isActive ? const Color(0xFF17345A) : MyColors.grey,
                    fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                    letterSpacing: 0.4,
                  ),
                  child: Text(label),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

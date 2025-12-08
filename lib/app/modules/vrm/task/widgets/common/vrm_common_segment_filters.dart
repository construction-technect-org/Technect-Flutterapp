import 'package:construction_technect/app/core/utils/imports.dart';

class VrmCommonSegmentFilters extends StatelessWidget {
  final List<String> items;
  final String activeFilter;
  final Function(String) onFilterTap;

  const VrmCommonSegmentFilters({
    super.key,
    required this.items,
    required this.activeFilter,
    required this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: AlignmentGeometry.topCenter,
          end: AlignmentGeometry.bottomCenter,
          colors: [MyColors.custom("FFF9BD"), Colors.white],
        ),
      ),
      padding: const EdgeInsets.only(right: 5),
      child: SizedBox(
        height: 40,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: items.map((it) {
            final bool isActive = activeFilter == it;
            return GestureDetector(
              onTap: () => onFilterTap(it),
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(it, style: MyTexts.medium14.copyWith(color: MyColors.black)),
                    const Gap(10),
                    if (isActive)
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        height: 3,
                        width: 73,
                        decoration: const BoxDecoration(
                          color: MyColors.primary,
                          borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                        ),
                      )
                    else
                      const SizedBox(height: 3, width: 73),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/CRM/marketing/controller/marketing_controller.dart';

class TodaysLeadsCard extends GetView<MarketingController> {
  const TodaysLeadsCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12, top: 9),
      decoration: BoxDecoration(
        border: Border.all(color: MyColors.grayD4),
        gradient: const LinearGradient(
          colors: [Color(0xFFEFF6FF), Color(0xFFE7F0FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(26),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Today's Total ${controller.activeFilter.value}",
                style: MyTexts.medium14.copyWith(color: MyColors.black),
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: MyColors.custom('CBE0FF'),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today_outlined, size: 12),
                    const SizedBox(width: 6),
                    Text('Month', style: MyTexts.medium12),
                  ],
                ),
              ),
            ],
          ),

          Obx(
            () => Text(
              '${controller.todaysTotal}',
              style: MyTexts.medium24.copyWith(
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
            ),
          ),

          Center(
            child: RoundedButton(
              onTap: () {
                _openSourceBottomSheet();
              },
              height: 30,
              width: 115,
              buttonName: "View  in details",
              style: MyTexts.medium14.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _openSourceBottomSheet() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// ---- HEADER ----
            Row(
              children: [
                Text("Lead Details", style: MyTexts.bold20),
                const Spacer(),
                GestureDetector(
                  onTap: Get.back,
                  child: const CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.black12,
                    child: Icon(Icons.close, color: Colors.black),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            /// ---- GRID ----
            GridView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 18,
                crossAxisSpacing: 18,
                childAspectRatio: 0.85,
              ),
              children: [
                _sourceCard("Indian Mart", "09"),
                _sourceCard("Just dial", "02"),
                _sourceCard("Trade India", "06"),
                _sourceCard("Ads", "08"),
                _sourceCard("Manual Lead", "10"),
              ],
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _sourceCard(
    String name,
    String count, {
    String buttonText = "View All",
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE3E6EE)),
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            color: Colors.black.withValues(alpha: 0.04),
            offset: const Offset(0, 3),
          ),
        ],
        gradient: const LinearGradient(
          colors: [Color(0xFFEEF4FF), Color(0xFFFEFEFF)],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// NAME
          Text(
            name,
            textAlign: TextAlign.center,
            style: MyTexts.medium14.copyWith(color: Colors.black),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  count,
                  style: MyTexts.medium20.copyWith(
                    color: Colors.black,
                    fontSize: 26,
                  ),
                ),
                const Gap(4),
                const Icon(Icons.star, size: 18, color: Color(0xFFFAC740)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF142243),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              buttonText,
              style: MyTexts.bold15.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

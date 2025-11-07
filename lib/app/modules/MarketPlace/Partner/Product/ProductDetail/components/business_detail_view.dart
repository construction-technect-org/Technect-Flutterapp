import 'package:construction_technect/app/core/utils/common_appbar.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/More/Profile/components/add_certificate.dart';
import 'package:construction_technect/app/modules/MarketPlace/Partner/Product/ProductDetail/controllers/product_detail_controller.dart';

class BusinessDetailView extends StatelessWidget {
  BusinessDetailView({super.key});

  final controller = Get.find<ProductDetailsController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const CommonBgImage(),
          Column(
            children: [
              CommonAppBar(
                backgroundColor: Colors.transparent,
                title: const Text('Business Details'),
                isCenter: false,
                leading: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: const Padding(
                    padding: EdgeInsets.zero,
                    child: Icon(
                      Icons.arrow_back_ios_new_sharp,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        SizedBox(height: 2.h),
                        Row(
                          children: [
                            Text(
                              'Business Metrics',
                              style: MyTexts.bold16.copyWith(
                                color: MyColors.gray2E,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 1.h),
                        _buildBusinessMetricsContent(),
                        SizedBox(height: 2.h),
                        Row(
                          children: [
                            Text(
                              'Business Hours',
                              style: MyTexts.medium16.copyWith(
                                color: MyColors.fontBlack,
                                fontFamily: MyTexts.SpaceGrotesk,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 1.h),
                        _buildBusinessHourContent(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBusinessMetricsContent() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: MyColors.white,
        border: Border.all(color: MyColors.grayEA),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildRow(
            title: "Business name",
            data: controller.product.merchantName ?? "-",
          ),
          const Gap(6),
          buildRow(
            title: "GSTIN",
            data: controller.product.merchantGstNumber ?? "-",
          ),
          const Gap(6),

          buildRow(
            title: "Mobile Number",
            data: controller.product.merchantPhone ?? "-",
          ),
          const Gap(6),
          buildRow(
            title: "Website",
            data: controller.product.merchantWebsite ?? "-",
          ),
          const Gap(6),
          buildRow(
            title: "Email id",
            data: controller.product.merchantEmail ?? "-",
          ),
          const Gap(6),
        ],
      ),
    );
  }

  Widget _buildBusinessHourContent() {
    final data = controller.businessHoursData;
    return Obx(() {
      if (data.isEmpty) {
        return Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Text(
            "No business hours set",
            style: MyTexts.regular14.copyWith(color: MyColors.gray54),
          ),
        );
      }
      data.sort(
        (a, b) => (a['day_of_week'] as int).compareTo(b['day_of_week'] as int),
      );

      final openDays = data.where((d) => d['is_open'] == true).toList();
      final closedDays = data.where((d) => d['is_open'] == false).toList();

      final List<Widget> items = [];

      for (final day in openDays) {
        items.add(_buildBusinessHourItem([day], isOpen: true));
      }

      if (closedDays.isNotEmpty) {
        items.add(_buildBusinessHourItem(closedDays, isOpen: false));
      }

      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: MyColors.grayEA),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Working Hours",
              style: MyTexts.medium15.copyWith(color: MyColors.grayA5),
            ),
            const Gap(12),
            Column(children: items),
          ],
        ),
      );
    });
  }

  Widget _buildBusinessHourItem(
    List<Map<String, dynamic>> days, {
    required bool isOpen,
  }) {
    String dayLabel = "";
    if (days.length == 1) {
      dayLabel = days.first['day_name'];
    } else {
      dayLabel = days.map((d) => d['day_name']).join(", ");
    }

    final String openTime = isOpen ? (days.first['open_time'] ?? "") : "";
    final String closeTime = isOpen ? (days.first['close_time'] ?? "") : "";

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: isOpen ? const Color(0xFFEAF0FF) : const Color(0xFFFFEEEE),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isOpen ? const Color(0xFFCAD6FF) : const Color(0xFFF5C8C8),
        ),
      ),
      child: Column(
        children: [
          const Gap(16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    isOpen
                        ? "$dayLabel ${openTime.isNotEmpty ? '$openTime - $closeTime' : ''}"
                        : dayLabel,
                    style: MyTexts.medium15.copyWith(color: MyColors.gray2E),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: AlignmentGeometry.bottomRight,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: Text(
                isOpen ? "Open" : "Closed",
                style: MyTexts.medium14.copyWith(
                  color: MyColors.gray2E,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRow({String? data, required String title}) {
    return Row(
      children: [
        Text(title, style: MyTexts.medium14.copyWith(color: MyColors.grayA5)),
        const Spacer(),
        Text(
          data ?? "",
          style: MyTexts.medium15.copyWith(color: MyColors.gray2E),
        ),
      ],
    );
  }
}

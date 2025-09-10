import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/modules/profile/controllers/profile_controller.dart';

class InfoMetricsComponent extends StatelessWidget {
  const InfoMetricsComponent({super.key});

  ProfileController get controller => Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildInfoMetricsContent(),
        SizedBox(height: 2.h),
        _buildBusinessMetricsCard(),
        SizedBox(height: 4.h),
      ],
    );
  }

  Widget _buildInfoMetricsContent() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: MyColors.white,
        border: Border.all(color: const Color(0xFFD0D0D0)),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Information',
                style: MyTexts.medium16.copyWith(
                  color: MyColors.black,
                  fontFamily: MyTexts.Roboto,
                ),
              ),
              SizedBox(height: 1.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          color: MyColors.primary,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Image.asset(Asset.infoIcon),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFED29),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Icon(Icons.camera_alt, size: 12, color: MyColors.black),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: Obx(() {
                      final userData = controller.userData;
                      final merchantProfile = controller.merchantProfile;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${userData?.firstName ?? ''} ${userData?.lastName ?? ''}'
                                    .trim()
                                    .isEmpty
                                ? 'User Name'
                                : '${userData?.firstName ?? ''} ${userData?.lastName ?? ''}'
                                      .trim(),
                            style: MyTexts.medium16.copyWith(
                              color: MyColors.black,
                              fontFamily: MyTexts.Roboto,
                            ),
                          ),
                          SizedBox(height: 0.5.h),
                          Text(
                            merchantProfile?.businessName ??
                                'Business name not available',
                            style: MyTexts.regular14.copyWith(
                              color: const Color(0xFF838383),
                              fontFamily: MyTexts.Roboto,
                            ),
                          ),
                          Text(
                            'GST Number: ${merchantProfile?.gstinNumber ?? ''}',
                            style: MyTexts.regular14.copyWith(
                              color: const Color(0xFF838383),
                              fontFamily: MyTexts.Roboto,
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 1.h),
          Container(width: double.infinity, height: 1, color: const Color(0xFFD9D9D9)),
          SizedBox(height: 1.h),
          Text(
            'Contact Details',
            style: MyTexts.regular14.copyWith(
              color: MyColors.black,
              fontFamily: MyTexts.Roboto,
            ),
          ),
          SizedBox(height: 1.h),
          Obx(() {
            final userData = controller.userData;
            final merchantProfile = controller.merchantProfile;

            return Column(
              children: [
                if (controller.currentAddress != null)
                  _buildContactItem(Icons.location_on, controller.currentAddress!),
                if (controller.currentAddress != null) SizedBox(height: 1.h),
                if (userData?.mobileNumber != null)
                  _buildContactItem(Icons.phone, userData!.mobileNumber!),
                if (userData?.mobileNumber != null) SizedBox(height: 1.h),
                if (userData?.email != null)
                  _buildContactItem(Icons.email, userData?.email ?? ''),
                if (userData?.email != null) SizedBox(height: 1.h),
                if (merchantProfile?.businessEmail != null)
                  _buildContactItem(Icons.email, merchantProfile?.businessEmail ?? ''),
                if (merchantProfile?.businessEmail != null) SizedBox(height: 1.h),
                if (controller.businessWebsite != null)
                  _buildContactItem(Icons.language, controller.businessWebsite!),
                if (controller.businessWebsite != null) SizedBox(height: 1.h),
              ],
            );
          }),
          SizedBox(height: 1.h),
          Container(width: double.infinity, height: 1, color: const Color(0xFFD9D9D9)),
          SizedBox(height: 1.h),
          // Business Hours Section
          Text(
            'Business Hours',
            style: MyTexts.regular14.copyWith(
              color: MyColors.black,
              fontFamily: MyTexts.Roboto,
            ),
          ),
          SizedBox(height: 1.h),
          Obx(() {
            final businessHours = controller.businessHours;

            if (businessHours.isEmpty) {
              return Text(
                'No business hours set',
                style: MyTexts.regular14.copyWith(
                  color: const Color(0xFF838383),
                  fontFamily: MyTexts.Roboto,
                ),
              );
            }

            return Column(
              children: businessHours.map((hours) {
                final dayName = _getDayName(hours.dayOfWeek ?? 0);
                final timeText = (hours.isOpen == true)
                    ? '${hours.openTime} - ${hours.closeTime}'
                    : 'Closed';

                return Column(
                  children: [
                    _buildBusinessHourItem(dayName, timeText),
                    if (hours != businessHours.last) SizedBox(height: 0.5.h),
                  ],
                );
              }).toList(),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14, color: MyColors.iconColor),
        SizedBox(width: 1.w),
        Expanded(
          child: Text(
            text,
            style: MyTexts.medium14.copyWith(
              color: MyColors.black,
              fontFamily: MyTexts.Roboto,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBusinessHourItem(String day, String hours) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          day,
          style: MyTexts.regular14.copyWith(
            color: const Color(0xFF808080),
            fontFamily: MyTexts.Roboto,
          ),
        ),
        Text(
          hours,
          style: MyTexts.medium14.copyWith(
            color: const Color(0xFF2B2B2B),
            fontFamily: MyTexts.Roboto,
          ),
        ),
      ],
    );
  }

  Widget _buildBusinessMetricsCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: MyColors.white,
        border: Border.all(color: const Color(0xFFD0D0D0)),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Business Metrics',
            style: MyTexts.medium16.copyWith(
              color: MyColors.black,
              fontFamily: MyTexts.Roboto,
            ),
          ),
          SizedBox(height: 2.h),
          Obx(() {
            final merchantProfile = controller.merchantProfile;

            return Column(
              children: [
                if (merchantProfile?.yearsInBusiness != null)
                  _buildMetricItem(
                    'Years in Business',
                    '${merchantProfile!.yearsInBusiness}+',
                  ),
                if (merchantProfile?.yearsInBusiness != null) SizedBox(height: 1.h),
                if (merchantProfile?.projectsCompleted != null)
                  _buildMetricItem(
                    'Projects Completed',
                    '${merchantProfile!.projectsCompleted}+',
                  ),
                if (merchantProfile?.projectsCompleted != null) SizedBox(height: 1.h),
                _buildMetricItem('Customer Rating', '4.9/5'), // Static for now
                SizedBox(height: 1.h),
                _buildMetricItem('Response Time', '< 2 hours'), // Static for now
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildMetricItem(String label, String value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFEEF8FF), // Light blue background
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: MyTexts.regular14.copyWith(
              color: const Color(0xFF505050),
              fontFamily: MyTexts.Roboto,
            ),
          ),
          Text(
            value,
            style: MyTexts.medium14.copyWith(
              color: MyColors.primary,
              fontFamily: MyTexts.Roboto,
            ),
          ),
        ],
      ),
    );
  }

  String _getDayName(int dayOfWeek) {
    switch (dayOfWeek) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return 'Unknown';
    }
  }
}

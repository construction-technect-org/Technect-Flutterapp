import 'package:construction_technect/app/core/utils/imports.dart';

class InfoMetricsComponent extends StatelessWidget {
  const InfoMetricsComponent({super.key});

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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Rachita Sdisd',
                          style: MyTexts.medium16.copyWith(
                            color: MyColors.black,
                            fontFamily: MyTexts.Roboto,
                          ),
                        ),
                        SizedBox(height: 0.5.h),
                        Text(
                          'Premium construction materials supplier serving the greater metropolitan area for over 15 years.',
                          style: MyTexts.regular14.copyWith(
                            color: const Color(0xFF838383),
                            fontFamily: MyTexts.Roboto,
                          ),
                        ),
                      ],
                    ),
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
          _buildContactItem(
            Icons.location_on,
            '123 Industrial Blvd, Construction City, CC 12345',
          ),
          SizedBox(height: 1.h),
          _buildContactItem(Icons.phone, '+1 (555) 123-4567'),
          SizedBox(height: 1.h),
          _buildContactItem(Icons.email, 'contact@probuilder.com'),
          SizedBox(height: 1.h),
          _buildContactItem(Icons.language, 'www.probuilder.com'),
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
          _buildBusinessHourItem('Monday - Friday', '7:00 AM - 6:00 PM'),
          SizedBox(height: 0.5.h),
          _buildBusinessHourItem('Saturday', '7:00 AM - 6:00 PM'),
          SizedBox(height: 0.5.h),
          _buildBusinessHourItem('Sunday', 'Closed'),
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
          _buildMetricItem('Years in Business', '15+'),
          SizedBox(height: 1.h),
          _buildMetricItem('Projects Completed', '12+'),
          SizedBox(height: 1.h),
          _buildMetricItem('Customer Rating', '4.9/5'),
          SizedBox(height: 1.h),
          _buildMetricItem('Response Time', '< 2 hours'),
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
}

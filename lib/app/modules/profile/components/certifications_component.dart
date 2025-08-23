import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:dotted_border/dotted_border.dart';

class CertificationsComponent extends StatelessWidget {
  const CertificationsComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          children: [
            SvgPicture.asset(Asset.certificateIcon, width: 20, height: 20),
            SizedBox(width: 1.w),
            Text(
              'Certifications & Licenses',
              style: MyTexts.medium16.copyWith(
                color: MyColors.black,
                fontFamily: MyTexts.Roboto,
              ),
            ),
          ],
        ),
        SizedBox(height: 2.h),
        _buildCertificationItem(
          'FSSAI License',
          'International Organization for Standardization',
          'Expires on 12/12/2025',
        ),
        SizedBox(height: 1.7.h),
        _buildCertificationItem(
          'FSSAI License',
          'International Organization for Standardization',
          'Expires on 12/12/2025',
        ),
        SizedBox(height: 3.h),
        Center(
          child: RoundedButton(
            buttonName: '',
            borderRadius: 12,
            width: 50.w,
            height: 45,
            verticalPadding: 0,
            horizontalPadding: 0,
            child: Center(
              child: Text(
                '+ Add Certification',
                style: MyTexts.medium16.copyWith(
                  color: MyColors.white,
                  fontFamily: MyTexts.Roboto,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCertificationItem(
    String title,
    String organization,
    String expiryDate,
  ) {
    return DottedBorder(
      borderType: BorderType.RRect,
      radius: const Radius.circular(12),
      color: const Color(0xFF8C8C8C),
      dashPattern: const [5, 5],
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          color: MyColors.white,
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
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFD9F0FF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: SvgPicture.asset(
                  Asset.certificateIcon,
                  colorFilter: const ColorFilter.mode(
                    MyColors.primary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            SizedBox(height: 2.w),
            // Content
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: MyTexts.medium22.copyWith(
                    color: MyColors.black,
                    fontFamily: MyTexts.Roboto,
                  ),
                ),
                Text(
                  organization,
                  style: MyTexts.medium14.copyWith(
                    color: const Color(0xFF717171),
                    fontFamily: MyTexts.Roboto,
                  ),
                ),
                SizedBox(height: 0.3.h),
                Text(
                  expiryDate,
                  style: MyTexts.medium14.copyWith(
                    color: const Color(0xFF717171),
                    fontFamily: MyTexts.Roboto,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
